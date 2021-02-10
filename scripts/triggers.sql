CREATE OR REPLACE FUNCTION add_creator() RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO
        joined (gameid, userid, attended)
        VALUES(NEW.gameid, NEW.ownerid, false);
           RETURN NEW;
END;
$BODY$
language plpgsql;

CREATE TRIGGER add_creator_on_game_created_trigger
	AFTER INSERT ON game
	FOR EACH ROW
	EXECUTE PROCEDURE add_creator();