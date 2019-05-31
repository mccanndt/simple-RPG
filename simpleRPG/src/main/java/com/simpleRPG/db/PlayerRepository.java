package com.simpleRPG.db;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.simpleRPG.business.Player;

public interface PlayerRepository extends CrudRepository<Player, Integer> {
	Optional<Player> findByUserNameAndPassword(String userName, String password);

	Optional<Player> findByUserName(String userName);
}
