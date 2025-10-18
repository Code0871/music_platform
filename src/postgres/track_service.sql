create extension if not exists "uuid-ossp";

-- кеш-таблица данных об авторах
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
)with(fillfactor = 85);

create table genres (
	genre_guid uuid primary key default uuid_generate_v4(),
	genre_name varchar(50) not null unique
);

create table tracks (
	track_guid uuid primary key default uuid_generate_v4(),
	track_name varchar(100) not null,
	track_text text,
	track_path text, -- путь на файл трека в файловой системе
	track_author uuid not null, -- логическая связка с автором
	track_album uuid not null, -- логическая связка с альбомом
	track_genre uuid not null,
	track_created_at timestamptz not null, default now(),
	track_updated_at timestamptz not null, default now(),
	track_deleted boolean default false,

	constraint fk_track_genre foreign key (track_genre)
        	references genres(genre_guid)
)with(fillfactor = 85);

create index idx_tracks_author on tracks(track_author);
create index idx_tracks_album on tracks(track_album);
create index idx_tracks_genre on tracks(track_genre);
Ccreate index idx_tracks_deleted on tracks(track_deleted) where not track_deleted;