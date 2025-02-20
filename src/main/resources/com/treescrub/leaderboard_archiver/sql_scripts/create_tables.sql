CREATE TABLE IF NOT EXISTS archives (
	id	                INTEGER PRIMARY KEY AUTO_INCREMENT UNIQUE,
	uuid                BINARY(16) NOT NULL,

	start_time	        BIGINT NOT NULL,
	end_time	        BIGINT NOT NULL,
	total_runs	        INTEGER NOT NULL,
	total_categories	INTEGER NOT NULL,
	game_id	            VARCHAR(16) NOT NULL,
	game_name	        TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS players (
	archive_id  INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	type	    VARCHAR(5) NOT NULL,
	name	    TEXT NOT NULL,
	id	        VARCHAR(16) NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS runs (
	id	            VARCHAR(16) NOT NULL,
	archive_id	    INTEGER NOT NULL,
	archive_time	BIGINT NOT NULL,
	category_id	    VARCHAR(16) NOT NULL,
	category_name	TEXT NOT NULL,
	level_id	    VARCHAR(16),
	level_name	    TEXT,
	comment	        TEXT,
	submission_time	BIGINT,
	date_ran	    DATE,

	PRIMARY KEY(id, archive_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id)
);

CREATE TABLE IF NOT EXISTS splits (
	archive_id	INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	url	        TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS status (
	archive_id	    INTEGER NOT NULL,
	run_id	        VARCHAR(16) NOT NULL,
	status	        VARCHAR(8) NOT NULL,
	examiner_id	    VARCHAR(16),
	examiner_name	TEXT,
	verify_date	    BIGINT,

	PRIMARY KEY(run_id, archive_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS systems (
	archive_id	    INTEGER NOT NULL,
	run_id	        VARCHAR(16) NOT NULL,
	platform_name	TEXT NOT NULL,
	emulated	    BOOLEAN NOT NULL,
	region_name	    TEXT,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS times (
	archive_id	        INTEGER NOT NULL,
	run_id	            VARCHAR(16) NOT NULL,
	primary_time	    REAL NOT NULL,
	real_time	        REAL,
	real_noloads_time	REAL,
	ingame_time	        REAL,

	PRIMARY KEY(run_id, archive_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS variables (
	archive_id  INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	name	    TEXT NOT NULL,
	value	    TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);

CREATE TABLE IF NOT EXISTS versions (
	version	        TEXT NOT NULL UNIQUE,
	upgrade_time	TIMESTAMP,

	PRIMARY KEY(version)
);

CREATE TABLE IF NOT EXISTS videos (
	archive_id	INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	url	        TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archives(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES runs(id, archive_id)
);