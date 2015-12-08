select concat('insert into "suggestions" (title, author, email, comment, latitude, longitude, address, updated_at, created_at, visible) VALUES "(', incident_title, '","', concat(ip.person_first, ' ', ip.person_last), '","',person_email, '","',incident_description, '",',latitude, ',',longitude, ',"',location_name, '",',incident_date, ',',incident_date, ',',1,')') from incident i inner join incident_person ip on ip.incident_id=i.id inner join location l on l.id = i.location_id;

select incident_id, concat('http://alertaciclista.com/media/uploads/',media_link) from media;
