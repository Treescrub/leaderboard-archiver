package com.treescrub.leaderboard_archiver;

import com.treescrub.spedran.Spedran;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.nio.file.Path;
import java.sql.*;
import java.util.Optional;

public class App extends Application {
    private static final Logger logger = LogManager.getLogger();

    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource("javafx.fxml"));
        Scene scene = new Scene(fxmlLoader. load());

        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }

    private static String getDatabasePath() {
        return Path.of("database.db").toAbsolutePath().toString();
    }

    /**
     * Inserts a new archive into the database and returns the new archive ID.
     *
     * @param gameId game ID string for a game on SRC
     * @return an Optional containing the archive ID if successful
     */
    private static Optional<Integer> insertNewArchive(String gameId) {
        long startTime = System.currentTimeMillis() / 1000;

        String gameName = Spedran.getGame(gameId)
                .thenApply(game -> game.getNames().getInternationalName())
                .exceptionally(e -> {
                    logger.error("Failed to get game", e);
                    return null;
                })
                .join();

        if(gameName == null) {
            return Optional.empty();
        }

        try(
                Connection connection = DriverManager.getConnection("jdbc:sqlite:" + getDatabasePath());
                PreparedStatement insertArchive = connection.prepareStatement("INSERT INTO archives (start_time, game_id, game_name) VALUES (?, ?, ?) RETURNING ROWID");
        ) {
            connection.setAutoCommit(false);

            insertArchive.setLong(1, startTime);
            insertArchive.setString(2, gameId);
            insertArchive.setString(3, gameName);
            insertArchive.executeUpdate();

            ResultSet result = insertArchive.getResultSet();
            int archiveId = result.getInt("id");

            connection.commit();

            return Optional.of(archiveId);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
