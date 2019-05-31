package com.simpleRPG.db;

import org.springframework.data.repository.CrudRepository;

import com.simpleRPG.business.Item;

public interface ItemRepository extends CrudRepository<Item, Integer> {

}
