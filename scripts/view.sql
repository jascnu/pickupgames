CREATE VIEW game_list AS
SELECT game.gameid, game.title, sports.name as sport, game.iscompetitive, game.datetime, location.address, pickupuser.username AS owner, game.playersjoined, game.playersrequired, game.description, competitivelevels.level
FROM game
INNER JOIN sports ON game.sportid=sports.sportid
INNER JOIN competitivelevels ON game.levelid=competitivelevels.levelid
INNER JOIN location ON game.locationid=location.locationid
INNER JOIN pickupuser ON game.ownerid = pickupuser.userid;

CREATE VIEW sport_list AS
SELECT name
FROM sports;

CREATE VIEW rank_list AS
SELECT level
FROM competitivelevels;

CREATE VIEW location_list AS
SELECT address
FROM location;

CREATE VIEW profile_page AS
SELECT firstname, middle, lastname, email, username, attendancescore, zipcode, description, rolename
FROM pickupuser
JOIN role USING(roleid)

CREATE VIEW game_data AS
 SELECT gl.gameid,
    gl.title,
    g.description,
    gl.sport,
    gl.level,
    gl.datetime,
    gl.address,
    gl.owner,
    gl.playersjoined,
    gl.playersrequired,
    ag.attendees
   FROM ((( SELECT game_list.gameid,
            array_agg(p.username) AS attendees
           FROM ((game_list
             JOIN joined j USING (gameid))
             JOIN pickupuser p USING (userid))
          GROUP BY game_list.gameid) ag
     JOIN game_list gl ON ((gl.gameid = ag.gameid)))
     JOIN game g ON ((g.gameid = gl.gameid)));