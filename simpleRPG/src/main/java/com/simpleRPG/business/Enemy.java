package com.simpleRPG.business;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Enemy {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private int basePower;
	private int baseDefense;
	private int baseHealth;
	private int level;
	private boolean isBoss;
	private int baseExp;
	private double attackRate;
	private String iconPath;

	public Enemy() {
	}

	public Enemy(String name, int basePower, int baseDefense, int baseHealth, int level, boolean isBoss, int baseExp,
			double attackRate, String iconPath) {
		this.name = name;
		this.basePower = basePower;
		this.baseDefense = baseDefense;
		this.baseHealth = baseHealth;
		this.level = level;
		this.isBoss = isBoss;
		this.baseExp = baseExp;
		this.attackRate = attackRate;
		this.iconPath = iconPath;
	}

	public Enemy(int id, String name, int basePower, int baseDefense, int baseHealth, int level, boolean isBoss,
			int baseExp, double attackRate, String iconPath) {
		this.id = id;
		this.name = name;
		this.basePower = basePower;
		this.baseDefense = baseDefense;
		this.baseHealth = baseHealth;
		this.level = level;
		this.isBoss = isBoss;
		this.baseExp = baseExp;
		this.attackRate = attackRate;
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

	public boolean isBoss() {
		return isBoss;
	}

	public void setBoss(boolean isBoss) {
		this.isBoss = isBoss;
	}

	public int getBaseExp() {
		return baseExp;
	}

	public void setBaseExp(int baseExp) {
		this.baseExp = baseExp;
	}

	public double getAttackRate() {
		return attackRate;
	}

	public void setAttackRate(double attackRate) {
		this.attackRate = attackRate;
	}

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

}
