-- Replication (Maser-Slave - Master and 3 Slaves - Failover) SemiSync AP
-- Sharding (Key based (Hash) Coordinator Consistent Hashing 
CREATE TYPE "MEIDA_TYPE" AS ENUM (
  'PHOTO',
  'VIDEO',
  'AUDIO'
);

CREATE TYPE "RELATION_TYPE" AS ENUM (
  'FRIEND',
  'SUBSCRIBER',
  'LOVE'
);

CREATE TABLE "user" (
  "id" integer PRIMARY KEY,
  "name" text NOT NULL,
  "description" text,
  "city" text,
  "post" post DEFAULT null,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "relation" (
  "id" integer PRIMARY KEY,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now()),
  "from_user_id" user.user.id NOT NULL,
  "to_user_id" user.user.id NOT NULL,
  "type" RELATION_TYPE NOT NULL
);

CREATE TABLE "media" (
  "id" integer PRIMARY KEY,
  "title" text DEFAULT null,
  "description" varchar DEFAULT null,
  "type" MEDIA_TYPE,
  "created_at" timestamp DEFAULT (now()),
  "size" float,
  "link" text UNIQUE NOT NULL,
  "user_id" user.user.id NOT NULL
);

CREATE TABLE "interest" (
  "id" integer PRIMARY KEY,
  "title" text UNIQUE NOT NULL,
  "description" text DEFAULT null,
  "created_at" timestamp DEFAULT (now()),
  "user_id" user.user.id NOT NULL
);

CREATE TABLE "chat" (
  "id" integer PRIMARY KEY,
  "title" varchar DEFAULT null,
  "owner_id" user.user.id NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "message" (
  "id" integer PRIMARY KEY,
  "content" text NOT NULL,
  "chat_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "created_at" integer DEFAULT (now()),
  "updated_at" integer DEFAULT (now()),
  "is_updated" bool DEFAULT false
);

CREATE TABLE "post" (
  "id" integer PRIMARY KEY,
  "content" text,
  "body" text,
  "user_id" integer,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now()),
  "media" media[],
  "likes_counter" integer DEFAULT null,
  "comments_counter" integer DEFAULT null,
  "watchs_counter" integer DEFAULT null
);

CREATE TABLE "watch" (
  "id" integer PRIMARY KEY,
  "post_id" post.post.id NOT NULL,
  "user_id" user.user.id NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "like" (
  "id" integer PRIMARY KEY,
  "user_id" user.user.id NOT NULL,
  "user" user NOT NULL,
  "post_id" post.post.id NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "comment" (
  "id" integer PRIMARY KEY,
  "user_id" user.user.id NOT NULL,
  "user" user NOT NULL,
  "post_id" integer NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_interest" (
  "user_id" integer,
  "interest_id" integer,
  PRIMARY KEY ("user_id", "interest_id")
);

ALTER TABLE "user_interest" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "user_interest" ADD FOREIGN KEY ("interest_id") REFERENCES "interest" ("id");


ALTER TABLE "media" ADD FOREIGN KEY ("id") REFERENCES "user" ("id");

CREATE TABLE "user_relation" (
  "user_id" integer,
  "relation_id" integer,
  PRIMARY KEY ("user_id", "relation_id")
);

ALTER TABLE "user_relation" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "user_relation" ADD FOREIGN KEY ("relation_id") REFERENCES "relation" ("id");


ALTER TABLE "message" ADD FOREIGN KEY ("id") REFERENCES "chat" ("id");

CREATE TABLE "user_chat" (
  "user_id" integer,
  "chat_id" integer,
  PRIMARY KEY ("user_id", "chat_id")
);

ALTER TABLE "user_chat" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "user_chat" ADD FOREIGN KEY ("chat_id") REFERENCES "chat" ("id");


ALTER TABLE "watch" ADD FOREIGN KEY ("id") REFERENCES "post" ("id");

ALTER TABLE "like" ADD FOREIGN KEY ("id") REFERENCES "post" ("id");

ALTER TABLE "comment" ADD FOREIGN KEY ("id") REFERENCES "post" ("id");

ALTER TABLE "post" ADD FOREIGN KEY ("id") REFERENCES "user" ("id");
