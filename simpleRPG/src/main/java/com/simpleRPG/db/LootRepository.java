package com.simpleRPG.db;

import org.springframework.data.repository.CrudRepository;

import com.simpleRPG.business.Loot;

public interface LootRepository extends CrudRepository<Loot, Integer> {

}
