CREATE TABLE IF NOT EXISTS archive (
	id	                INTEGER PRIMARY KEY AUTO_INCREMENT UNIQUE,
	uuid                CHAR(36) NOT NULL,

	start_time	        BIGINT NOT NULL,
	end_time	        BIGINT NOT NULL,
	total_runs	        INTEGER NOT NULL,
	total_categories	INTEGER NOT NULL,
	game_id	            VARCHAR(16) NOT NULL,
	game_name	        TEXT NOT NULL,
	INDEX(uuid)
);

CREATE TABLE IF NOT EXISTS run (
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
	FOREIGN KEY(archive_id) REFERENCES archive(id)
);

CREATE TABLE IF NOT EXISTS player (
	archive_id  INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	type	    VARCHAR(5) NOT NULL,
	name	    TEXT NOT NULL,
	id	        VARCHAR(16) NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS split (
	archive_id	INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	url	        TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS status (
	archive_id	    INTEGER NOT NULL,
	run_id	        VARCHAR(16) NOT NULL,
	status	        VARCHAR(8) NOT NULL,
	examiner_id	    VARCHAR(16),
	examiner_name	TEXT,
	verify_date	    BIGINT,

	PRIMARY KEY(run_id, archive_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS run_system (
	archive_id	    INTEGER NOT NULL,
	run_id	        VARCHAR(16) NOT NULL,
	platform_name	TEXT NOT NULL,
	emulated	    BOOLEAN NOT NULL,
	region_name	    TEXT,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS run_time (
	archive_id	        INTEGER NOT NULL,
	run_id	            VARCHAR(16) NOT NULL,
	primary_time	    REAL NOT NULL,
	real_time	        REAL,
	real_noloads_time	REAL,
	ingame_time	        REAL,

	PRIMARY KEY(run_id, archive_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS variable (
	archive_id  INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	name	    TEXT NOT NULL,
	value	    TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);

CREATE TABLE IF NOT EXISTS video (
	archive_id	INTEGER NOT NULL,
	run_id	    VARCHAR(16) NOT NULL,
	url	        TEXT NOT NULL,

	PRIMARY KEY(archive_id, run_id),
	FOREIGN KEY(archive_id) REFERENCES archive(id),
	FOREIGN KEY(run_id, archive_id) REFERENCES run(id, archive_id)
);