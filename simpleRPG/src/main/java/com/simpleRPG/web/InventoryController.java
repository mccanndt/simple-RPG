package com.simpleRPG.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.simpleRPG.business.JsonResponse;
import com.simpleRPG.business.Inventory;
import com.simpleRPG.db.InventoryRepository;

@RestController
@RequestMapping("/inventories")
public class InventoryController {

	@Autowired
	private InventoryRepository inventoryRepo;

	@GetMapping("/")
	public JsonResponse getAll() {
		JsonResponse jr = null;
		try {
			jr = JsonResponse.getInstance(inventoryRepo.findAll());
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@GetMapping("/{id}")
	public JsonResponse get(@PathVariable int id) {
		JsonResponse jr = null;
		try {
			if (inventoryRepo.existsById(id)) {
				jr = JsonResponse.getInstance(inventoryRepo.findById(id));
			} else {
				jr = JsonResponse.getInstance("No inventory found for id: " + id);
			}
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PostMapping("/")
	public JsonResponse add(@RequestBody Inventory i) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			jr = JsonResponse.getInstance(inventoryRepo.save(i));
		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@PutMapping("/")
	public JsonResponse update(@RequestBody Inventory i) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (inventoryRepo.existsById(i.getId())) {
				jr = JsonResponse.getInstance(inventoryRepo.save(i));
			} else {
				jr = JsonResponse
						.getInstance("Inventory ID: " + i.getId() + " does not exist and you are attempting to save it");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

	@DeleteMapping("/")
	public JsonResponse delete(@RequestBody Inventory i) {
		JsonResponse jr = null;
		// NOTE: May need to enhance execption handling if more than one excpetion type
		// needs to be caught
		try {
			if (inventoryRepo.existsById(i.getId())) {
				inventoryRepo.delete(i);
				jr = JsonResponse.getInstance("Inventory deleted");
			} else {
				jr = JsonResponse
						.getInstance("Inventory ID: " + i.getId() + " does not exist and you are attempting to delete it.");
			}

		} catch (Exception e) {
			jr = JsonResponse.getInstance(e);
		}
		return jr;
	}

}
