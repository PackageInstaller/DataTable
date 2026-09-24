local var_0_0 = {}
local var_0_3 = gamecore.dormitory_idea

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onBeginDrag_sort_layer_img(arg_2_1, arg_2_2)
		self._callbacks.on_furniture_begin_drag(self._data.id, arg_2_1, arg_2_2)
	end

	function arg_1_0:__onDrag_sort_layer_img(arg_3_1, arg_3_2)
		self._callbacks.on_furniture_drag(self._data.id, arg_3_1, arg_3_2)
	end

	function arg_1_0:__onEndDrag_sort_layer_img(arg_4_1, arg_4_2)
		self._callbacks.on_furniture_end_drag(self._data.id, arg_4_1, arg_4_2)
	end

	function arg_1_0:__onPointerDown_sort_layer_img()
		self._callbacks.on_furniture_pointer_down(self._data.id)
	end

	function arg_1_0:__onPointerUp_sort_layer_img()
		self._callbacks.on_furniture_pointer_up(self._data.id)
	end

	function arg_1_0.__onPointerClick_sort_layer_img(arg_7_0)
		return
	end

	function arg_1_0:__onTriggerEnter2D_sort_layer_spine_furniture_collider(arg_8_1)
		if self._control.sort_layer.spine.furniture_collider.trigger2DEvent.colliderName == "animal" then
			local var_8_0 = arg_8_1.gameObject:GetComponent("Trigger2DEvent")

			if not var_8_0 then
				return
			end

			local var_8_1 = var_8_0.colliderName
			local var_8_2, var_8_3 = self:get_pet_name_and_can_anim()

			if var_8_1 == "ship" and var_8_3 and not self._pet_action_cooling[var_8_2] and not self._pet_love_action_during[var_8_2] and not self._acting then
				self._acting = true

				self:__reset_seq_list()
				self:clear_walk_path_grid_list()
				self:clear_walk_pos_interpolation_list()
				self:set_furniture_animation(0, "love", false)

				self._pet_action_cooling_timer[var_8_2] = 10 + self._furniture_skeleton_graphic.SkeletonData:FindAnimation("love").Duration
				self._pet_action_cooling[var_8_2] = true
			end
		else
			if not var_0_3:dormitory_idea_manager_is_racing_car() and not var_0_3:dormitory_idea_manager_is_interactive_car() then
				return
			end

			local var_8_4 = arg_8_1.gameObject:GetComponent("Trigger2DEvent")

			if not var_8_4 then
				return
			end

			local var_8_5 = var_8_4.colliderName

			if arg_8_1.gameObject.transform.parent.position.x > self._control.sort_layer.spine.rectTransform.position.x then
				return
			end

			if var_8_5 == "race_car" then
				var_0_3:dormitory_idea_manager_toggle_barricade_drive_car(self._data.id, true)
			elseif var_8_5 == "barricade" and self._control.sort_layer.spine.furniture_collider.trigger2DEvent.colliderName ~= "barricade" then
				var_0_3:dormitory_idea_manager_toggle_barricade_drive_car(self._data.id, true)
			elseif var_8_5 == "ship" then
				var_0_3:set_running_car_speed_touch_barrier(self._data.id)
			end
		end
	end

	function arg_1_0.__onTriggerStay2D_sort_layer_spine_furniture_collider(arg_9_0, arg_9_1)
		return
	end

	function arg_1_0:__onTriggerExit2D_sort_layer_spine_furniture_collider(arg_10_1)
		if self._control.sort_layer.spine.furniture_collider.trigger2DEvent.colliderName == "animal" then
			local var_10_0 = arg_10_1.gameObject:GetComponent("Trigger2DEvent")
			local var_10_1

			if not var_10_0 then
				do return end

				var_10_1 = self:get_pet_name_and_can_anim()
			end

			if var_10_0.colliderName == "ship" and not self._pet_action_cooling[var_10_1] and not self._pet_love_action_during[var_10_1] then
				self._acting = false

				self:__reset_seq_list()
				self:add_ai_data(self._config.cid)
				self:random_walk()
			end
		else
			if not var_0_3:dormitory_idea_manager_is_racing_car() and not var_0_3:dormitory_idea_manager_is_interactive_car() then
				return
			end

			local var_10_2 = arg_10_1.gameObject:GetComponent("Trigger2DEvent")

			if not var_10_2 then
				return
			end

			local var_10_3 = var_10_2.colliderName

			if arg_10_1.gameObject.transform.parent.position.x > self._control.sort_layer.spine.rectTransform.position.x then
				return
			end

			if var_10_3 == "race_car" then
				var_0_3:dormitory_idea_manager_toggle_barricade_drive_car(self._data.id, false)
			elseif var_10_3 == "barricade" then
				var_0_3:dormitory_idea_manager_toggle_barricade_drive_car(self._data.id, false)
			end
		end
	end

	function arg_1_0.__onClick_sort_layer_spine_btn(arg_11_0)
		return
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
