CREATE PROCEDURE Freigabe
    @RFID VARCHAR(255)
AS
BEGIN
    -- Declare variables
    DECLARE @BenutzerID INT;
    DECLARE @BuchungsID INT;
    DECLARE @Startzeit TIME;
    DECLARE @Endzeit TIME;
    DECLARE @AktuelleZeit TIME;

    -- Get the current time
    SET @AktuelleZeit = GETDATE();

    -- Find the user ID by RFID
    SELECT @BenutzerID = BenutzerID FROM Benutzer WHERE RFID = @RFID;

    -- Check if the user exists
    IF @BenutzerID IS NULL
    BEGIN
        PRINT 'Kein Benutzer mit diesem RFID gefunden.';
        RETURN;
    END

    -- Find the booking ID by user ID
    SELECT @BuchungsID = BuchungsID FROM Buchung WHERE BenutzerID = @BenutzerID;

    -- Check if the user has a booking
    IF @BuchungsID IS NULL
    BEGIN
        PRINT 'Der Benutzer hat keine Buchung.';
        RETURN;
    END

    -- Find the start and end time by booking ID
    SELECT @Startzeit = Startzeit, @Endzeit = Endzeit FROM Buchung WHERE BuchungsID = @BuchungsID;

    -- Check if the current time is within the booking time
    IF @AktuelleZeit BETWEEN @Startzeit AND @Endzeit
    BEGIN
        PRINT 'Die Buchung ist gültig. Freigabe erteilt.';
    END
    ELSE
    BEGIN
        PRINT 'Die Buchung ist nicht gültig. Keine Freigabe.';
    END
END
GO