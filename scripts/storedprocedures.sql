CREATE OR REPLACE FUNCTION public.attended(IN givengameid integer,IN givenuserid integer,IN userattended boolean)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
AS $BODY$
BEGIN
  UPDATE joined SET attended = userAttended WHERE gameid = givengameid AND userid = givenuserid;
  RETURN TRUE;
END;
$BODY$;