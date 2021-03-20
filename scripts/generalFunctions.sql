--Create games, returns gameId
CREATE OR REPLACE FUNCTION public.creategame(IN title text,IN playersrequired integer,IN description text,IN datetime date,IN ownerid integer,IN sportid integer,IN locationid integer,IN levelid integer,IN iscompetitive boolean DEFAULT false,IN playersjoined integer DEFAULT  1)
    RETURNS integer
    LANGUAGE 'sql'
    VOLATILE SECURITY DEFINER
    PARALLEL UNSAFE
    COST 100
AS $BODY$

INSERT INTO game (title, playersrequired, iscompetitive, playersjoined, description, datetime, ownerid, sportid, locationid, levelid) VALUES
    (creategame.title, creategame.playersrequired, creategame.iscompetitive, creategame.playersjoined, creategame.description, creategame.datetime, creategame.ownerid, creategame.sportid, creategame.locationid, creategame.levelid)
	RETURNING gameid;

	
$BODY$;

--Delete game
CREATE OR REPLACE FUNCTION public.deletegame(IN gameid integer)
    RETURNS void
    LANGUAGE 'sql'
    VOLATILE SECURITY DEFINER
    PARALLEL UNSAFE
    COST 100
AS $BODY$
DELETE FROM joined WHERE joined.gameid = deletegame.gameid;
DELETE FROM game WHERE game.gameid = deletegame.gameid;
	
$BODY$;