package com.simpleRPG.db;

import org.springframework.data.repository.CrudRepository;

import com.simpleRPG.business.Inventory;

public interface InventoryRepository extends CrudRepository<Inventory, Integer> {

}
