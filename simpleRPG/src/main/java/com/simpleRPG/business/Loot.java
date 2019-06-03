package com.simpleRPG.business;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Loot {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "enemyID")
	private Enemy enemy;
	@ManyToOne
	@JoinColumn(name = "itemID")
	private Item item;

	public Loot() {
	}

	public Loot(Enemy enemy, Item item) {
		this.enemy = enemy;
		this.item = item;
	}

	public Loot(int id, Enemy enemy, Item item) {
		this.id = id;
		this.enemy = enemy;
		this.item = item;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Enemy getEnemy() {
		return enemy;
	}

	public void setEnemy(Enemy enemy) {
		this.enemy = enemy;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

}
