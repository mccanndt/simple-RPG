package com.simpleRPG.business;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Inventory {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "playerID")
	private Player player;
	@ManyToOne
	@JoinColumn(name = "itemID")
	private Item item;

	public Inventory() {
	}

	public Inventory(Player player, Item item) {
		this.player = player;
		this.item = item;
	}

	public Inventory(int id, Player player, Item item) {
		this.id = id;
		this.player = player;
		this.item = item;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Player getPlayer() {
		return player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

}
