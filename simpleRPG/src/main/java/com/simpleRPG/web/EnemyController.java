package com.simpleRPG.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.simpleRPG.business.JsonResponse;
import com.simpleRPG.business.Enemy;
import com.simpleRPG.db.EnemyRepository;

@RestController
@RequestMapping("/enemies")
public class EnemyController {

	@Autowired
	private EnemyRepository enemyRepo;

	@GetMapping("/")
	public JsonResponse getAll() {
		JsonResponse jr = null;
		try {
			jr = JsonResponse.getInstance(enemyRepo.findAll());
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@GetMapping("/{id}")
	public JsonResponse get(@PathVariable int id) {
		JsonResponse jr = null;
		try {
			if (enemyRepo.existsById(id)) {
				jr = JsonResponse.getInstance(enemyRepo.findById(id));
			} else {
				jr = JsonResponse.getInstance("No enemy found for id: " + id);
			}
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PostMapping("/")
	public JsonResponse add(@RequestBody Enemy e) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			jr = JsonResponse.getInstance(enemyRepo.save(e));
		} catch (Exception ex) {
			jr = JsonResponse.getInstance(ex);
		}
		return jr;
	}

	@PutMapping("/")
	public JsonResponse update(@RequestBody Enemy e) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (enemyRepo.existsById(e.getId())) {
				jr = JsonResponse.getInstance(enemyRepo.save(e));
			} else {
				jr = JsonResponse
						.getInstance("Enemy ID: " + e.getId() + " does not exist and you are attempting to save it");
			}

		} catch (Exception ex) {
			jr = JsonResponse.getInstance(ex);
		}
		return jr;
	}

	@DeleteMapping("/")
	public JsonResponse delete(@RequestBody Enemy e) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (enemyRepo.existsById(e.getId())) {
				enemyRepo.delete(e);
				jr = JsonResponse.getInstance("Enemy deleted");
			} else {
				jr = JsonResponse
						.getInstance("Enemy ID: " + e.getId() + " does not exist and you are attempting to delete it.");
			}

		} catch (Exception ex) {
			jr = JsonResponse.getInstance(ex);
		}
		return jr;
	}

}
