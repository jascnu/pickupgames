INSERT INTO public.role(
	roleid, rolename, roledescription)
	VALUES (0, 'user', 'regular user');

INSERT INTO public.pickupuser(
	userid, firstname, middle, lastname, email, username, attendancescore, passwordhash, zipcode, description, roleid)
	VALUES (0, 'Dummy', 'U', 'User', 'dummy@gmail.com', 'dummyuser', 0, 'p@ssw0rd', 1234, 'I am a dummy user', 0);

INSERT INTO public.pickupuser(
	userid, firstname, middle, lastname, email, username, attendancescore, passwordhash, zipcode, description, roleid)
	VALUES (0, 'Dummy', 'U', 'User', 'dummy2@gmail.com', 'dummyuser2', 0, 'p@ssw0rd', 1234, 'I am a dummy user', 4);

INSERT INTO public.competitivelevels(
	level, levelid)
	VALUES ('Beginner', 0);

INSERT INTO public.competitivelevels(
	level, levelid)
	VALUES ('Intermediate', 1);

INSERT INTO public.competitivelevels(
	level, levelid)
	VALUES ('Advanced', 2);

INSERT INTO public.location(
	locationid, address, lat, "long", website, isopenaccess)
	VALUES (0, '888 E 222 E', 12.2222, 12.2222, 'https://www.bing.com', true);

INSERT INTO public.sports(
	name, sportid)
	VALUES ('Tennis', 0);

INSERT INTO public.game(
	gameid, title, playersrequired, iscompetitive, playersjoined, description, datetime, ownerid, sportid, locationid, levelid)
	VALUES (0, 'Dummy Title', 20, true, 0, 'Dummy Description', to_timestamp(1612490936758), 0, 0, 0, 0);

INSERT INTO public.joined(
	attended, userid, gameid)
	VALUES (false, 0, 0);

INSERT INTO public.joined(
	attended, userid, gameid)
	VALUES (false, 4, 0);
	
