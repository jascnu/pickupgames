INSERT INTO public.role(
	roleid, rolename, roledescription)
	VALUES (0, 'user', 'regular user');


INSERT INTO public.pickupuser(
	firstname, middle, lastname, email, username, attendancescore, passwordhash, zipcode, description, roleid)
	VALUES ('Bronson', 'Scott', 'Puzey', 'bronsonisat@gmail.com', 'bpuzey', 0, 'p@ssw0rd', 84604, 'Placeholder', 0);

	
