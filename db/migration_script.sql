select incident_title as title, concat(ip.person_first, ' ', ip.person_last) as author, person_email as email, incident_description as comment, latitude, longitude, location_name as address from incident i inner join incident_person ip on ip.incident_id=i.id inner join location l on l.id = i.location_id;

select incident_id, concat('http://alertaciclista.com/media/uploads/',media_link) from media;
