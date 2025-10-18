
create extension if not exists "uuid-ossp";

create table users 
(
    user_guid uuid primary key default uuid_generate_v4(),
    user_name varchar(15) not null,
    user_surname varchar(15),
    user_birthday date not null check(user_birthday between '1900-01-01' and current_date),
    user_phone char(11) unique,
    user_email varchar(245) unique,
    user_password text, -- будет записываться хэш через argon2id
    user_photo text, -- хранит путь в объектном хранилище
    user_created_at timestamp default now(),
	user_updated_at timestamp default now()
) with(fillfactor = 85);

alter table users cluster on idx_users_usersguid;
create index idx_users_email on users(user_email) with(fillfactor = 80);
create index idx_users_phone on users(user_phone) with(fillfactor = 80);