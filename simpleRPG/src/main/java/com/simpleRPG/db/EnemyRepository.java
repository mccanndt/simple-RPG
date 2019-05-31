package com.simpleRPG.db;

import org.springframework.data.repository.CrudRepository;

import com.simpleRPG.business.Enemy;

public interface EnemyRepository extends CrudRepository<Enemy, Integer> {

}
