package com.simpleRPG.business;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Item {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String flavorText;
	private int power;
	private int defense;
	private int level;
	private String slot;
	private String rarity;
	private int value;
	private String iconPath;

	public Item() {
	}

	public Item(String name, String flavorText, int power, int defense, int level, String slot, String rarity,
			int value, String iconPath) {
		this.name = name;
		this.flavorText = flavorText;
		this.power = power;
		this.defense = defense;
		this.level = level;
		this.slot = slot;
		this.rarity = rarity;
		this.value = value;
		this.iconPath = iconPath;
	}

	public Item(int id, String name, String flavorText, int power, int defense, int level, String slot, String rarity,
			int value, String iconPath) {
		this.id = id;
		this.name = name;
		this.flavorText = flavorText;
		this.power = power;
		this.defense = defense;
		this.level = level;
		this.slot = slot;
		this.rarity = rarity;
		this.value = value;
		this.iconPath = iconPath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFlavorText() {
		return flavorText;
	}

	public void setFlavorText(String flavorText) {
		this.flavorText = flavorText;
	}

	public int getPower() {
		return power;
	}

	public void setPower(int power) {
		this.power = power;
	}

	public int getDefense() {
		return defense;
	}

	public void setDefense(int defense) {
		this.defense = defense;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getSlot() {
		return slot;
	}

	public void setSlot(String slot) {
		this.slot = slot;
	}

	public String getRarity() {
		return rarity;
	}

	public void setRarity(String rarity) {
		this.rarity = rarity;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

}
