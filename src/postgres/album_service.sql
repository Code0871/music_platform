create extension if not exist "uuid_ossp";

create type album_types as enum ('single', 'split_single', 'ep', 'lp', 'concept_album', 'double_album');

create table astists (
	artist_guid uuid not null primary key,
	artist_nickname varchar(30) not null,
	artist_photo text -- ссылка на фото в файловой системе
)with(fillfactor = 85);

-- кеш-таблица данных о альбомах 
create table albums (
	album_guid uuid not null primary key,
	album_name varchar(50) not null,
	album_photo text
	artist_guid uuid not null,
	album_type album_types,
	album_created_at timestamptz not null, default now(),
	album_updated_at timestamptz not null, default now(),
	album_deleted boolean default false
)with(fillfactor = 85);


