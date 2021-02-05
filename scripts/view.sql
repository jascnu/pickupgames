CREATE VIEW game_list AS
SELECT game.gameid, game.title, sports.name, game.iscompetitive, game.datetime, location.address, pickupuser.username, game.playersjoined, game.playersrequired, game.description, competitivelevels.level
FROM game
INNER JOIN sports ON game.sportid=sports.sportid
INNER JOIN competitivelevels ON game.levelid=competitivelevels.levelid
INNER JOIN location ON game.locationid=location.locationid
INNER JOIN pickupuser ON game.userid=pickupuser.userid;

CREATE VIEW sport_list AS
SELECT name
FROM sports;

CREATE VIEW rank_list AS
SELECT level
FROM competitivelevels;

CREATE VIEW location_list AS
SELECT address
FROM location;