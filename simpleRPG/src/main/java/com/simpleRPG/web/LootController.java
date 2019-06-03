package com.simpleRPG.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.simpleRPG.business.JsonResponse;
import com.simpleRPG.business.Loot;
import com.simpleRPG.db.LootRepository;

@RestController
@RequestMapping("/loots")
public class LootController {

	@Autowired
	private LootRepository lootRepo;

	@GetMapping("/")
	public JsonResponse getAll() {
		JsonResponse jr = null;
		try {
			jr = JsonResponse.getInstance(lootRepo.findAll());
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@GetMapping("/{id}")
	public JsonResponse get(@PathVariable int id) {
		JsonResponse jr = null;
		try {
			if (lootRepo.existsById(id)) {
				jr = JsonResponse.getInstance(lootRepo.findById(id));
			} else {
				jr = JsonResponse.getInstance("No loot found for id: " + id);
			}
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PostMapping("/")
	public JsonResponse add(@RequestBody Loot l) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			jr = JsonResponse.getInstance(lootRepo.save(l));
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PutMapping("/")
	public JsonResponse update(@RequestBody Loot l) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (lootRepo.existsById(l.getId())) {
				jr = JsonResponse.getInstance(lootRepo.save(l));
			} else {
				jr = JsonResponse
						.getInstance("Loot ID: " + l.getId() + " does not exist and you are attempting to save it");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@DeleteMapping("/")
	public JsonResponse delete(@RequestBody Loot l) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (lootRepo.existsById(l.getId())) {
				lootRepo.delete(l);
				jr = JsonResponse.getInstance("Loot deleted");
			} else {
				jr = JsonResponse
						.getInstance("Loot ID: " + l.getId() + " does not exist and you are attempting to delete it.");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

}
