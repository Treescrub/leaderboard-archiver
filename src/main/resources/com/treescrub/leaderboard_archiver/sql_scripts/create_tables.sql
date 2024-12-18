CREATE TABLE "archives" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	"start_time"	INTEGER NOT NULL,
	"end_time"	INTEGER,
	"total_runs"	INTEGER,
	"total_categories"	INTEGER,
	"game_id"	TEXT NOT NULL,
	"game_name"	TEXT NOT NULL
);

CREATE TABLE "players" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"type"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"id"	TEXT NOT NULL,
	PRIMARY KEY("archive_id","run_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "runs" (
	"id"	TEXT NOT NULL,
	"archive_id"	INTEGER NOT NULL,
	"archive_time"	INTEGER NOT NULL,
	"category_id"	TEXT NOT NULL,
	"category_name"	TEXT NOT NULL,
	"level_id"	INTEGER,
	"level_name"	INTEGER,
	"comment"	TEXT,
	"submission_time"	INTEGER,
	"date_ran"	INTEGER,
	PRIMARY KEY("id","archive_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id")
);

CREATE TABLE "splits" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	PRIMARY KEY("archive_id","run_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "status" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"status"	TEXT NOT NULL,
	"examiner_id"	INTEGER,
	"examiner_name"	TEXT,
	"verify_date"	INTEGER,
	PRIMARY KEY("run_id","archive_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "systems" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"platform_name"	TEXT NOT NULL,
	"emulated"	INTEGER NOT NULL,
	"region_name"	TEXT,
	PRIMARY KEY("archive_id","run_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "times" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"primary_time"	REAL NOT NULL,
	"real_time"	REAL,
	"real_noloads_time"	REAL,
	"ingame_time"	REAL,
	PRIMARY KEY("run_id","archive_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "values" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"name"	TEXT NOT NULL,
	"value"	TEXT NOT NULL,
	PRIMARY KEY("archive_id","run_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE "versions" (
	"version"	TEXT NOT NULL UNIQUE,
	"upgrade_time"	INTEGER,
	PRIMARY KEY("version")
);

CREATE TABLE "videos" (
	"archive_id"	INTEGER NOT NULL,
	"run_id"	TEXT NOT NULL,
	"url"	TEXT NOT NULL,
	PRIMARY KEY("archive_id","run_id"),
	FOREIGN KEY("archive_id") REFERENCES "archives"("id"),
	FOREIGN KEY("run_id") REFERENCES "runs"("id") DEFERRABLE INITIALLY DEFERRED
);