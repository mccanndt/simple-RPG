package com.simpleRPG.web;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.simpleRPG.business.JsonResponse;
import com.simpleRPG.business.Player;
import com.simpleRPG.db.PlayerRepository;

@RestController
@RequestMapping("/players")
public class PlayerController {

	@Autowired
	private PlayerRepository playerRepo;

	@GetMapping("/")
	public JsonResponse getAll() {
		JsonResponse jr = null;
		try {
			jr = JsonResponse.getInstance(playerRepo.findAll());
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@GetMapping("/{id}")
	public JsonResponse get(@PathVariable int id) {
		JsonResponse jr = null;
		try {
			if (playerRepo.existsById(id)) {
				jr = JsonResponse.getInstance(playerRepo.findById(id));
			} else {
				jr = JsonResponse.getInstance("No player found for id: " + id);
			}
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PostMapping("/")
	public JsonResponse add(@RequestBody Player p) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			jr = JsonResponse.getInstance(playerRepo.save(p));
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PutMapping("/")
	public JsonResponse update(@RequestBody Player p) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (playerRepo.existsById(p.getId())) {
				jr = JsonResponse.getInstance(playerRepo.save(p));
			} else {
				jr = JsonResponse
						.getInstance("Player ID: " + p.getId() + " does not exist and you are attempting to save it");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@DeleteMapping("/")
	public JsonResponse delete(@RequestBody Player p) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (playerRepo.existsById(p.getId())) {
				playerRepo.delete(p);
				jr = JsonResponse.getInstance("Player deleted");
			} else {
				jr = JsonResponse.getInstance(
						"Player ID: " + p.getId() + " does not exist and you are attempting to delete it.");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PostMapping("/authenticate")
	public JsonResponse authenticate(@RequestBody Player p) {
		JsonResponse jr = null;
		try {
			Optional<Player> player = playerRepo.findByUserNameAndPassword(p.getUserName(), p.getPassword());
			if (player.isPresent()) {
				jr = JsonResponse.getInstance(player);
			} else {
				jr = JsonResponse.getInstance("No player found for playername: " + p.getUserName());
			}
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

}
