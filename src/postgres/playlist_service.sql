
create extension if not exists "uuid-ossp";

create table users -- кеш из сервиса пользователей
(
    user_guid uuid not null primary key,
    username varchar(15) not null,
    user_surname varchar(15),
    user_photo text
) with (fillfactor = 85);

create table artists 
(
    artist_guid uuid not null primary key,
    artist_name varchar(50) not null,
    artist_photo text,
    cached_at timestamptz not null default now()
) with (fillfactor = 85);

create table tracks -- кеш из сервиса треков
(
    track_guid uuid not null primary key, -- UUID трека из сервиса треков
    track_name varchar(200) not null, -- Название трека
    track_path text not null, -- Путь к файлу в объектном хранилище
    author_guid uuid not null,
    cached_at timestamptz not null default now() -- Важно для инвалидации кеша
) with (fillfactor = 85);

create table playlists 
(
	playlist_guid uuid primary key default uuid_generate_v4(),
	playlist_name varchar(50) not null,
	playlist_owner uuid not null,
	playlist_tracks uuid,
	created_at timpestamp not null default now()
)with(fillfactor = 85);

create table playlist_tracks 
(
    playlist_guid uuid not null,
    track_guid uuid not null,
    track_position int not null,
    added_at timestamptz not null default now(),
    primary key (playlist_guid, track_guid)

	constraint fk_playlist_track foreign key (playlist_guid)
       	references playlists(playlist_guid) on delete cascade
) with (fillfactor = 85);