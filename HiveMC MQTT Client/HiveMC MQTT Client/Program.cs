using HiveMQtt.Client;
using HiveMQtt.Client.Options;
using HiveMQtt.MQTT5.ReasonCodes;
using HiveMQtt.MQTT5.Types;
using Microsoft.Data.SqlClient;
using System.Text.Json;
using System.Data.SqlClient;

var options = new HiveMQClientOptions
{
    Host = "mqtt-dashboard.com",
    Port = 1883,
    UseTLS = false,
    UserName = "admin",
    Password = "password",
};

string received_message = "";

var client = new HiveMQClient(options);

Console.WriteLine($"Connecting to {options.Host} on port {options.Port} ...");

HiveMQtt.Client.Results.ConnectResult connectResult;
try
{
    connectResult = await client.ConnectAsync().ConfigureAwait(false);
    if (connectResult.ReasonCode == ConnAckReasonCode.Success)
    {
        Console.WriteLine($"Connect successful: {connectResult}");
    }
    else
    {
        // FIXME: Add ToString
        Console.WriteLine($"Connect failed: {connectResult}");
        Environment.Exit(-1);
    }
}
catch (System.Net.Sockets.SocketException e)
{
    Console.WriteLine($"Error connecting to the MQTT Broker with the following socket error: {e.Message}");
    Environment.Exit(-1);
}
catch (Exception e)
{
    Console.WriteLine($"Error connecting to the MQTT Broker with the following message: {e.Message}");
    Environment.Exit(-1);
}

// Message Handler
client.OnMessageReceived += (sender, args) =>
{
    received_message = args.PublishMessage.PayloadAsString;
    Console.WriteLine(received_message);                                //received Message ist die NAchricht die bekommen wird.

};

await client.ConnectAsync();                                            // Connected mit dem Broker
// Subscribe
await client.SubscribeAsync("RFID_SSK").ConfigureAwait(false);          //Subscribed das Topic

while (true){
    if(received_message != "")
    {
        Connect();
        received_message = "";
    }
}

void Connect()
{

    string connectionString = @"Data Source=localhost;Initial Catalog=CoworkingspaceDB;Trusted_Connection=true; TrustServerCertificate=true";
    SqlConnection connection = new SqlConnection(connectionString);

    connection.Open();

    // Hier Inhalte lesen

    string GetIdByRFID = "Select BenutzerID from Benutzer WHERE RFID = '" + received_message + "';";
    SqlCommand cmd = new SqlCommand(GetIdByRFID, connection);

    SqlDataReader reader = cmd.ExecuteReader();

    while (reader.Read())
    {

        string rowResult = string.Format("BenutzerID: {0}",
                        reader.GetValue(0));

        Console.WriteLine(rowResult);

    }

    // Alle Datenbank zugehörigen Objekte schließen

    reader.Close();
    cmd.Dispose();
    connection.Close();

}