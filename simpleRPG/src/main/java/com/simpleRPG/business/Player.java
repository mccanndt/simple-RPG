package com.simpleRPG.business;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Player {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String userName;
	private String password;
	private int basePower;
	private int baseDefense;
	private int baseHealth;
	private int level;
	private int inventorySize;
	private int currentExp;
	private String iconPath;

	public Player() {
	}

	public Player(String userName, String password, int basePower, int baseDefense, int baseHealth, int level,
			int inventorySize, int currentExp, String iconPath) {
		this.userName = userName;
		this.password = password;
		this.basePower = basePower;
		this.baseDefense = baseDefense;
		this.baseHealth = baseHealth;
		this.level = level;
		this.inventorySize = inventorySize;
		this.currentExp = currentExp;
		this.iconPath = iconPath;
	}

	public Player(int id, String userName, String password, int basePower, int baseDefense, int baseHealth, int level,
			int inventorySize, int currentExp, String iconPath) {
		this.id = id;
		this.userName = userName;
		this.password = password;
		this.basePower = basePower;
		this.baseDefense = baseDefense;
		this.baseHealth = baseHealth;
		this.level = level;
		this.inventorySize = inventorySize;
		this.currentExp = currentExp;
		this.iconPath = iconPath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getBasePower() {
		return basePower;
	}

	public void setBasePower(int basePower) {
		this.basePower = basePower;
	}

	public int getBaseDefense() {
		return baseDefense;
	}

	public void setBaseDefense(int baseDefense) {
		this.baseDefense = baseDefense;
	}

	public int getBaseHealth() {
		return baseHealth;
	}

	public void setBaseHealth(int baseHealth) {
		this.baseHealth = baseHealth;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getInventorySize() {
		return inventorySize;
	}

	public void setInventorySize(int inventorySize) {
		this.inventorySize = inventorySize;
	}

	public int getCurrentExp() {
		return currentExp;
	}

	public void setCurrentExp(int currentExp) {
		this.currentExp = currentExp;
	}

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

}
