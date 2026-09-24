local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameconfig.furniture_config
local var_0_3 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = UnityEngine.Vector2
local var_0_7 = UnityEngine.RenderMode
local var_0_8 = UnityEngine.Vector3
local var_0_9 = UnityEngine.Color
local var_0_10 = math.floor
local var_0_11 = UnityEngine.Time
local var_0_12 = table.remove
local var_0_13 = table.insert
local var_0_14 = gamecore.user
local var_0_15 = gamecore.dormitory_idea
local var_0_16 = gameconfig.ship_config
local var_0_18 = UnityEngine.RectTransformUtility
local var_0_19 = gamecore.util_func
local var_0_21 = gamecore.prompt
local var_0_22 = gamecore.Language
local var_0_23 = gamecore.PreloadManager
local var_0_24 = gameconfig.furniture_collection_config
local var_0_25 = DG.Tweening.DOTween

gamecore.UILoader:define("dormitory", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		var_0_14:set_to_living(true)
		self:setVisible(true)

		local var_2_0 = lx.get_millisecond()

		self:__init_panel()

		self._control.open_btn_mask.canvas.sortingOrder = self._base_canvas.sortingOrder + 101

		self:set_special_sortingOrder()

		if arg_2_1 then
			local var_2_1 = self:autoKillDOTween(var_0_25.Sequence())

			var_2_1:AppendInterval(0.5)
			var_2_1:AppendCallback(function()
				arg_2_1()
			end)
		end
	end

	function arg_1_0:__onUpdate(arg_4_1)
		self:buff_update()

		if not self._pause_sort_furniture then
			self:__sort_furniture()
		end

		self:__sort_ship_members()

		for iter_4_0, iter_4_1 in ipairs(self._ship_members_tb) do
			iter_4_1.control:update()
		end

		for iter_4_2, iter_4_3 in ipairs(self._curr_furniture_tb) do
			iter_4_3.control:update(arg_4_1)
		end

		if not self._is_editing then
			var_0_15:dormitory_idea_manager_update()
			var_0_15:dormitory_idea_manager_interactive_update()
		end

		if not self._time_execute_task_list then
			return
		end

		for iter_4_4, iter_4_5 in ipairs(self._time_execute_task_list) do
			if iter_4_5.execute_time > 0 then
				iter_4_5.execute_time = iter_4_5.execute_time - var_0_11.deltaTime

				if iter_4_5.execute_time <= 0 and iter_4_5.execute_func then
					if iter_4_4 == #self._time_execute_task_list then
						self._time_execute_task_list = nil
					end

					iter_4_5.execute_func()
				end
			end
		end
	end

	function arg_1_0:buff_update()
		if self._start_race_buff then
			local var_5_0 = self._buff_end_time - lx.ServerTime:getUtcTime()
			local var_5_1 = ""

			if var_5_0 > 59 then
				var_5_1 = var_0_5("%dm", var_5_0 / 60)
			elseif var_5_0 <= 59 and var_5_0 >= 0 then
				var_5_1 = var_0_5("%ds", var_5_0)
			else
				self._start_race_buff = false

				self:__change_canvas_group_state(self._control.buff_layer.on_furniture_button_buff, false)
			end

			self._control.buff_layer.on_furniture_button_buff.buff_time.text.text = var_5_1
		end
	end

	function arg_1_0:set_special_sortingOrder()
		self._control.close_btn_bg.canvas.sortingOrder = self._base_canvas.sortingOrder + 101
		self._control.buff_layer.canvas.sortingOrder = self._base_canvas.sortingOrder + 101
		self._control.ceiling_mask.canvas.sortingOrder = self._base_canvas.sortingOrder + 50
		self._control.room.back_grid.canvas.sortingOrder = self._base_canvas.sortingOrder + 2
		self._control.room.front_grid.canvas.sortingOrder = self._base_canvas.sortingOrder + 99
	end

	function arg_1_0:get_walkable_grid_list(arg_7_1, arg_7_2, arg_7_3)
		arg_7_1 = arg_7_1 or 0
		arg_7_2 = arg_7_2 or 0
		arg_7_3 = arg_7_3 or 0
		self._walkable_ground_grid_list = {}

		for iter_7_0 = 0 + arg_7_1, var_0_3.dormitory_const.room_max_grid_x - arg_7_2 do
			for iter_7_1 = 0, var_0_3.dormitory_const.room_max_ground_grid_y - arg_7_3 do
				local var_7_0 = false

				for iter_7_2, iter_7_3 in ipairs(self._covered_grid_pos_list) do
					if iter_7_0 == iter_7_3.grid_x and iter_7_1 == iter_7_3.grid_y then
						var_7_0 = true

						break
					end
				end

				if not var_7_0 then
					self._walkable_ground_grid_list[#self._walkable_ground_grid_list + 1] = {
						grid_x = iter_7_0,
						grid_y = iter_7_1
					}
				end
			end
		end

		return self._walkable_ground_grid_list
	end

	function arg_1_0:is_grid_pos_covered(arg_8_1)
		local var_8_0 = false
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in ipairs(self._covered_grid_pos_list) do
			if arg_8_1.grid_x == iter_8_1.grid_x and arg_8_1.grid_y == iter_8_1.grid_y then
				var_8_0 = true
				var_8_1 = iter_8_1.id

				break
			end
		end

		return var_8_0, var_8_1
	end

	function arg_1_0.is_grid_pos_in_room(arg_9_0, arg_9_1)
		return arg_9_1.grid_x >= 0 and arg_9_1.grid_x < var_0_3.dormitory_const.room_max_grid_x and arg_9_1.grid_y >= 0 and arg_9_1.grid_y < var_0_3.dormitory_const.room_max_grid_y
	end

	function arg_1_0:get_furniture_grid_pos(arg_10_1)
		local var_10_0 = self:__get_furniture_ele_by_id(arg_10_1)

		return {
			x = var_10_0.data.point.x,
			y = var_10_0.data.point.y
		}
	end

	function arg_1_0:get_ship_ele_by_id(arg_11_1)
		for iter_11_0, iter_11_1 in ipairs(self._ship_members_tb) do
			if arg_11_1 == iter_11_1.data.id then
				return iter_11_1
			end
		end
	end

	function arg_1_0:get_curr_room_index()
		return self._curr_room_index
	end

	function arg_1_0:update_room_furniture()
		for iter_13_0, iter_13_1 in ipairs(self._curr_furniture_tb) do
			iter_13_1.control:destroy_self()
		end

		for iter_13_2, iter_13_3 in ipairs(self._curr_room_bg_tb) do
			iter_13_3.control:destroy_self()
		end

		self._curr_furniture_tb = {}
		self._curr_room_bg_tb = {}

		var_0_15:dormitory_idea_manager_stop_race_car()

		local var_13_0, var_13_1 = self:__init_room_data(self._curr_room_index)

		self:__init_furniture(var_13_0)
		self:__refresh_dormitory_idea_manager()

		local var_13_2 = var_0_1:getInstance("dormitory_record")

		if var_13_2 then
			var_13_2:use_record_resp()
		end
	end

	function arg_1_0:check_need_update()
		local var_14_0 = false
		local var_14_1, var_14_2 = self:__init_room_data(self._curr_room_index)

		for iter_14_0, iter_14_1 in ipairs(self._ship_members_tb) do
			for iter_14_2, iter_14_3 in pairs(var_14_2) do
				if iter_14_1.data.id == iter_14_3 and var_0_14:find_character_by_id(iter_14_3).skin ~= iter_14_1.data.skin then
					var_14_0 = true

					break
				end
			end
		end

		if var_14_0 then
			self:update_room_role()
		end
	end

	function arg_1_0:update_room_role()
		var_0_15:dormitory_idea_manager_stop_race_car()

		local var_15_0, var_15_1 = self:__init_room_data(self._curr_room_index)
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in pairs(self._ship_members_tb) do
			var_0_13(var_15_2, iter_15_1.data)
		end

		local var_15_3 = {}

		for iter_15_2 = 1, #self._ship_members_tb do
			local var_15_4

			for iter_15_3, iter_15_4 in ipairs(self._ship_members_tb) do
				local var_15_5 = false

				for iter_15_5, iter_15_6 in pairs(var_15_1) do
					if iter_15_4.data.id == iter_15_6 then
						if var_0_14:find_character_by_id(iter_15_6).skin == iter_15_4.data.skin then
							var_15_5 = true
						end

						break
					end
				end

				if not var_15_5 then
					iter_15_4.control:destroy_self()

					var_15_4 = iter_15_3

					var_0_13(var_15_3, iter_15_4.data)

					break
				end
			end

			if var_15_4 then
				var_0_12(self._ship_members_tb, var_15_4)
			end
		end

		self:__destroy_room()
		self:__init_room(var_15_0, var_15_1)
		self:__correct_sort_layers()
		self:__init_ship_members(var_15_1)
		self:__refresh_dormitory_idea_manager({
			last_role_list = var_15_2,
			curr_remove_list = var_15_3
		})
		self:setVisible(true)
		self:set_special_sortingOrder()
	end

	function arg_1_0:select_ship_req(arg_16_1)
		var_0_14:req_ShipEnterRoomReq({
			id = self._curr_room_index,
			members = arg_16_1
		})
	end

	function arg_1_0:set_curr_bg_state(arg_17_1)
		self._control.bg.image.raycastTarget = arg_17_1
	end

	function arg_1_0:put_furniture_to_dorm(arg_18_1)
		self._now_data = arg_18_1

		local var_18_0 = var_0_2.find_object_by_cid(arg_18_1.cid)

		if not next(self._furniture_list_form_warehouse) then
			self._editing_furniture_tb = self:__copy_furniture_data(self._curr_furniture_tb)
			self._editing_room_bg_tb = self:__copy_furniture_data(self._curr_room_bg_tb)
		end

		if var_18_0.furniture_type == var_0_3.furniture_pos_type.move_forbid then
			if var_18_0.type == var_0_3.furniture_kind_type.wall then
				if self._wall_type_furniture then
					self:__remove_furniture(self._wall_type_furniture.data.id, 2)
				end
			elseif var_18_0.type == var_0_3.furniture_kind_type.ground then
				if self._ground_type_furniture then
					self:__remove_furniture(self._ground_type_furniture.data.id, 2)
				end
			elseif var_18_0.type == var_0_3.furniture_kind_type.ceiling and self._ceiling_type_furniture then
				self:__remove_furniture(self._ceiling_type_furniture.data.id, 2)
			end
		end

		if not self:__put_furniture_limit_of_pet(var_18_0) then
			var_0_21:show(var_0_22:getNowLang("petcountlimited"))

			return
		end

		self:__toggle_close_menu(false)

		if not self:__put_furniture_pretreatment(arg_18_1) then
			self:__toggle_edit_mode(true)

			return
		end

		local var_18_1 = false

		for iter_18_0, iter_18_1 in pairs(self._furniture_list_form_warehouse) do
			if iter_18_1.id == arg_18_1.id then
				var_18_1 = true

				break
			end
		end

		if not var_18_1 then
			var_0_13(self._furniture_list_form_warehouse, arg_18_1)
		end

		local var_18_2

		for iter_18_2, iter_18_3 in pairs(self._furniture_list_to_warehouse) do
			if arg_18_1.id == iter_18_3.data.id then
				var_18_2 = iter_18_2

				break
			end
		end

		if var_18_2 then
			var_0_12(self._furniture_list_to_warehouse, var_18_2)
		end

		local var_18_3 = (var_0_3.dormitory_const.panel_width - var_18_0.width * var_0_3.dormitory_const.room_x_plus) / var_0_3.dormitory_const.room_x_plus
		local var_18_4 = 0
		local var_18_5 = 0

		if var_18_0.furniture_type == var_0_3.furniture_pos_type.move_forbid then
			var_18_3 = 0
			var_18_4 = 0
		elseif var_18_0.furniture_type == var_0_3.furniture_pos_type.ground or var_18_0.furniture_type == var_0_3.furniture_pos_type.floor then
			var_18_4 = 0
			var_18_5 = var_0_3.dormitory_const.room_max_ground_grid_y
		elseif var_18_0.furniture_type == var_0_3.furniture_pos_type.wall then
			var_18_4 = var_0_3.dormitory_const.room_max_ground_grid_y
			var_18_5 = var_18_0.xindex.y ~= -1 and var_18_0.xindex.y or var_0_3.dormitory_const.room_max_wall_grid_y

			if var_18_0.cid == var_0_3.dormitory_const.oyu_door then
				var_18_4 = var_18_0.xindex.y
			end

			if var_18_0.furniture_type == var_0_3.furniture_pos_type.wall then
				var_18_4 = var_0_3.dormitory_const.room_ground_y_amount + 10
			end
		elseif var_18_0.furniture_type == var_0_3.furniture_pos_type.ceiling then
			var_18_4 = var_0_3.dormitory_const.room_max_wall_grid_y + 4
			var_18_5 = var_0_3.dormitory_const.room_max_wall_grid_y + 4
		elseif var_18_0.furniture_type == var_0_3.furniture_pos_type.lean_wall then
			var_18_4 = var_0_3.dormitory_const.room_max_lean_wall_gird_y
			var_18_5 = var_0_3.dormitory_const.room_max_ground_grid_y

			if var_18_0.cid == var_0_3.dormitory_special_furniture_id.beautiful_vines then
				var_18_4 = var_0_3.dormitory_const.room_max_ground_grid_y + 0.8
			end

			if var_18_0.cid == var_0_3.dormitory_special_furniture_id.race_car_guardrial then
				var_18_4 = var_0_3.dormitory_const.room_max_lean_wall_gird_y + 5
			end
		end

		local var_18_6 = {
			{
				rotate = false,
				id = arg_18_1.id,
				cid = arg_18_1.cid,
				point = {
					x = var_18_3,
					y = var_18_4
				}
			}
		}

		self:__toggle_open_btn(false)
		self:__init_furniture(var_18_6)

		if var_18_0.cid == var_0_3.dormitory_special_furniture_id.race_car_road then
			-- block empty
		end

		self:__toggle_edit_mode(true, true)

		local var_18_7

		if var_18_0.furniture_type == var_0_3.furniture_pos_type.move_forbid then
			for iter_18_4, iter_18_5 in pairs(self._curr_room_bg_tb) do
				if iter_18_5.data.id == arg_18_1.id then
					var_18_7 = iter_18_5

					break
				end
			end

			self._editing_room_bg_tb[#self._editing_room_bg_tb + 1] = var_18_7
			var_18_7 = self._editing_room_bg_tb[#self._editing_room_bg_tb]
		else
			for iter_18_6, iter_18_7 in pairs(self._curr_furniture_tb) do
				if iter_18_7.data.id == arg_18_1.id then
					var_18_7 = iter_18_7

					break
				end
			end

			self._editing_furniture_tb[#self._editing_furniture_tb + 1] = var_18_7
			var_18_7 = self._editing_furniture_tb[#self._editing_furniture_tb]
		end

		var_18_7.action = var_0_3.update_add

		if var_18_0.furniture_type == var_0_3.furniture_pos_type.move_forbid then
			return
		end

		var_18_7.control:open_spine(false)
		self:__on_furniture_pointer_down(arg_18_1.id)
		self:check_pos(var_18_7, var_18_0, var_18_5, var_18_3, var_18_4)
		self:__open_furniture_edit_menu(arg_18_1.id)
	end

	function arg_1_0:check_pos(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
		local var_19_0 = self:__check_grid_cover_overlap(arg_19_1.data.id)

		self:__record_overlap_info(arg_19_1.data.id, var_19_0)

		if var_19_0 then
			local var_19_1 = arg_19_1.data.point.x
			local var_19_2 = arg_19_1.data.point.y

			if arg_19_2.furniture_type == var_0_3.furniture_pos_type.ceiling then
				var_19_1 = var_19_1 - 1

				if var_19_1 < 0 then
					var_19_1 = arg_19_4
					var_19_2 = arg_19_5

					return
				end
			elseif var_19_2 >= arg_19_3 - arg_19_2.height then
				if arg_19_2.furniture_type ~= var_0_3.furniture_pos_type.wall then
					var_19_2 = 0
				end

				var_19_1 = var_19_1 - 1

				if var_19_1 < 0 then
					var_19_1 = arg_19_4
					var_19_2 = arg_19_5

					return
				end
			else
				var_19_2 = var_19_2 + 1
			end

			arg_19_1.data.point.x = var_19_1
			arg_19_1.data.point.y = var_19_2

			arg_19_1.control:set_furniture_scale(var_19_2)
			arg_19_1.control:set_furniture_position(var_19_1, var_19_2)

			self._furniture_foot_grid_root_rect.anchoredPosition = self:__convert_grid_to_pos(var_19_1, var_19_2, arg_19_1.data.id)

			self:check_pos(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
		else
			self:__set_covered_grid_pos_list(false)
		end

		self:__toggle_close_menu(false)
	end

	function arg_1_0:__record_overlap_info(arg_20_1, arg_20_2)
		if arg_20_1 and not self._record_overlap_id_list[arg_20_1] then
			self._record_overlap_id_list[arg_20_1] = arg_20_1
		end

		if not arg_20_2 and self._record_overlap_id_list[arg_20_1] then
			self._record_overlap_id_list[arg_20_1] = nil
		end
	end

	function arg_1_0:race_game_enter(arg_21_1)
		self:__destroy_room()
		self:__init_furniture(arg_21_1)
		self:__sort_furniture_race()
		self:__correct_sort_layers()
	end

	function arg_1_0:touch_head_add_love_resp(arg_22_1)
		for iter_22_0, iter_22_1 in pairs(self._ship_members_tb) do
			iter_22_1.control:touch_head_add_love_resp(arg_22_1)
		end
	end

	function arg_1_0.add_buff(arg_23_0, arg_23_1)
		if arg_23_1 == 3 then
			local var_23_0 = var_0_1:getInstance("dormitory_game")

			var_23_0._control.race_result_layer.win_buff_desc:SetActive(true)

			var_23_0._control.race_result_layer.win_buff_desc.text.text = var_0_22:getNowLang("racebufflimit")

			return
		end
	end

	function arg_1_0:update_race_buff_float()
		self._start_race_buff = false
		self._race_buff_info = var_0_14:get_dormitory_race_buff()

		if self._race_buff_info and self._race_buff_info.end_time ~= nil then
			if lx.ServerTime:getUtcTime() < self._race_buff_info.end_time then
				self._buff_end_time = self._race_buff_info.end_time
				self._start_race_buff = true

				self:__change_canvas_group_state(self._control.buff_layer.on_furniture_button_buff, true)
				self:set_buff_data()
			else
				self:__change_canvas_group_state(self._control.buff_layer.on_furniture_button_buff, false)
			end
		else
			self:__change_canvas_group_state(self._control.buff_layer.on_furniture_button_buff, false)
		end
	end

	function arg_1_0:set_buff_data()
		local var_25_0 = var_0_14:get_dormitory_race_buff()
		local var_25_1 = var_0_2.find_object_by_cid(var_25_0.id)

		self.car_buff_desc = var_25_1.buff_desc
		self._control.buff_layer.tip_bg.content.text.text = var_0_5(var_0_22:convert_rich_text(self.car_buff_desc), var_0_22:getNowLang(var_0_3:get_country_language_key(var_25_0.country)))
		self._control.buff_layer.tip_bg.title.text.text = var_25_1.title
	end

	function arg_1_0:__init_panel()
		self:__init_language()
		self:__toggle_canvas_render_mode(true)
		self:__refresh_room_select_menu()
		self:__show_room(1)
		self:update_race_buff_float()
	end

	function arg_1_0:__init_language()
		self._control.edit_menu_bg.warehouse_btn.txt.text.text = var_0_22:getNowLang("storage")
		self._control.edit_menu_bg.clear_btn.txt.text.text = var_0_22:getNowLang("clearsave")
		self._control.edit_menu_bg.cancel_btn.txt.text.text = var_0_22:getNowLang("cancel")
		self._control.edit_menu_bg.ok_btn.txt.text.text = var_0_22:getNowLang("confirm")
		self._control.menu_bg.close_menu_btn.Text.text.text = var_0_22:getNowLang("packup")
		self._control.menu_bg.race_btn.txt.text.text = var_0_22:getNowLang("racecar")
		self._control.menu_bg.room_btn.txt.text.text = var_0_22:getNowLang("room")
		self._control.menu_bg.role_btn.txt.text.text = var_0_22:getNowLang("role")
		self._control.menu_bg.warehouse_btn.txt.text.text = var_0_22:getNowLang("storage")
		self._control.menu_bg.record_btn.txt.text.text = var_0_22:getNowLang("logrecord")
		self._control.menu_bg.collection_btn.txt.text.text = var_0_22:getNowLang("collection")
		self._control.menu_bg.exhibition_btn.txt.text.text = var_0_22:getNowLang("showroom")
		self._control.menu_bg.edit_btn.txt.text.text = var_0_22:getNowLang("edit")
		self._control.room_select_bg.room1.room_btn.txt.text.text = var_0_22:getNowLang("room1")
		self._control.room_select_bg.room2.room_btn.txt.text.text = var_0_22:getNowLang("room2")
		self._control.room_select_bg.room3.room_btn.txt.text.text = var_0_22:getNowLang("room3")
		self._control.room_select_bg.room4.room_btn.txt.text.text = var_0_22:getNowLang("room4")
		self._control.room_select_bg.room5.room_btn.txt.text.text = var_0_22:getNowLang("room5")
		self._control.room_select_bg.room6.room_btn.txt.text.text = var_0_22:getNowLang("room6")
		self._control.room_select_bg.expand_btn.txt.text.text = var_0_22:getNowLang("expantion")
	end

	function arg_1_0.__init_room_data(arg_28_0, arg_28_1)
		local var_28_0 = var_0_14:get_dormitory_room_info(arg_28_1)

		if not var_28_0 then
			return {}, {}
		end

		return var_28_0.furniture, var_28_0.members
	end

	function arg_1_0:__init_room(arg_29_1, arg_29_2)
		self:__init_furniture(arg_29_1)
		self:__sort_furniture()
		self:__correct_sort_layers()
		self:__init_ship_members(arg_29_2)
		self:__refresh_dormitory_idea_manager({
			is_init = true
		})
	end

	function arg_1_0:__refresh_dormitory_idea_manager(arg_30_1)
		arg_30_1 = arg_30_1 or {}

		var_0_15:dormitory_idea_manager_init({
			curr_furniture_tb = self._curr_furniture_tb,
			curr_room_bg_tb = self._curr_room_bg_tb,
			ship_members_tb = self._ship_members_tb,
			dormitory_instance = self,
			last_role_list = arg_30_1.last_role_list,
			curr_remove_list = arg_30_1.curr_remove_list,
			is_init = arg_30_1.is_init
		})
	end

	function arg_1_0:__show_room(arg_31_1)
		if self._curr_room_index == arg_31_1 then
			return
		end

		self._bg_bgm = false
		self._curr_room_index = arg_31_1

		self:__destroy_room()

		local var_31_0, var_31_1 = self:__init_room_data(arg_31_1)

		self._get_furniture_data = var_31_0

		self:__init_room(var_31_0, var_31_1)
	end

	function arg_1_0:reset_room()
		self:__destroy_room()

		local var_32_0, var_32_1 = self:__init_room_data(self._curr_room_index)

		self._get_furniture_data = var_32_0

		self:__init_room(var_32_0, var_32_1)
	end

	function arg_1_0:__destroy_room()
		for iter_33_0, iter_33_1 in ipairs(self._curr_furniture_tb) do
			iter_33_1.control:destroy_self()
		end

		for iter_33_2, iter_33_3 in ipairs(self._curr_room_bg_tb) do
			iter_33_3.control:destroy_self()
		end

		for iter_33_4, iter_33_5 in ipairs(self._ship_members_tb) do
			iter_33_5.control:destroy_self()
		end

		self._curr_furniture_tb = {}
		self._curr_room_bg_tb = {}
		self._ship_members_tb = {}
		self._wall_type_furniture = nil
		self._ground_type_furniture = nil
		self._ceiling_type_furniture = nil
		self._pause_sort_furniture = false

		self:__clear_all_ship_inter_furniture()
		var_0_15:dormitory_idea_manager_stop_race_car()
		var_0_15:dormitory_idea_manager_destroy()
	end

	function arg_1_0:__destroy_panel()
		var_0_23:unload_dormitory_asset()
		self:__reset_temp_data()

		for iter_34_0, iter_34_1 in ipairs(self._furniture_foot_grid_obj_tb) do
			self:destroyGameObject(iter_34_1)
		end

		var_0_1:destroyInstance("dormitory")
		var_0_1:destroyInstance("dorm_warehouse")
		var_0_1:destroyInstance("dormitory_game")
		var_0_1:destroyInstance("exchange_shop_panel")
		var_0_1:destroyInstance("furniture_recycle_panel")
		var_0_1:destroyInstance("item_info")
		var_0_1:destroyInstance("item_details_view")
		var_0_1:destroyInstance("furniture_detail_panel")
		var_0_1:destroyInstance("furniture_point_view")
		var_0_15:dormitory_idea_manager_destroy()
		self:__destroy_room()
		self:__toggle_canvas_render_mode(false)

		self._furniture_foot_grid_root_rect = nil
	end

	function arg_1_0:__init_ship_members(arg_35_1)
		local var_35_0 = self:__get_curr_room_swing_pool_data()

		for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
			local var_35_1 = false

			for iter_35_2, iter_35_3 in pairs(self._ship_members_tb) do
				if iter_35_1 == iter_35_3.data.id then
					var_35_1 = true

					break
				end
			end

			if not var_35_1 then
				local var_35_2 = var_0_14:find_character_by_id(iter_35_1)
				local var_35_3 = var_0_16.find_object_by_cid(var_35_2.cid)
				local var_35_4 = self:loadUI("dormitory_ship")

				var_35_4._panel.transform:SetParent(self._control.room.ship_layer.transform, false)
				var_35_4:show({
					data = var_35_2,
					order = self._base_canvas.sortingOrder,
					config = var_35_3,
					callbacks = {
						on_ship_pointer_down = function(arg_36_0)
							return
						end,
						on_ship_pointer_up = function(arg_37_0)
							return
						end,
						on_ship_begin_drag = function(arg_38_0, arg_38_1, arg_38_2)
							return
						end,
						on_ship_drag = function(arg_39_0, arg_39_1, arg_39_2)
							return
						end,
						on_ship_end_drag = function(arg_40_0, arg_40_1, arg_40_2)
							return
						end
					},
					is_exist_special_furniture = var_35_0,
					dormitory_instance = self,
					ship_member_index = #self._ship_members_tb + 1
				})

				self._ship_members_tb[#self._ship_members_tb + 1] = {
					control = var_35_4,
					data = var_35_2,
					config = var_35_3
				}

				self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_hello))
			end
		end

		self:__sort_ship_members()
	end

	function arg_1_0:__sort_ship_members()
		for iter_41_0, iter_41_1 in ipairs(self._ship_members_tb) do
			iter_41_1.control:set_sort_order((self:__get_ship_furniture_layer(iter_41_1.control:get_foot_position())))
		end
	end

	function arg_1_0.__toggle_canvas_render_mode(arg_42_0, arg_42_1)
		if arg_42_1 then
			var_0_1:getUIRoot().parent.transform:GetComponent("Canvas").renderMode = var_0_7.ScreenSpaceOverlay or var_0_7.ScreenSpaceCamera
		end
	end

	function arg_1_0:toggle_canvas_render_mode(arg_43_1)
		self:__toggle_canvas_render_mode(arg_43_1)
	end

	function arg_1_0:__on_furniture_load_complete()
		self._have_beautiful_vines = self:__judge_have_beautiful_vines(self._curr_furniture_tb)
		self._furniture_foot_grid_root_rect = self._control.foot_grid_layer.foot_grid_root.rectTransform

		self:__set_covered_grid_pos_list(true)
		self:__check_on_water_condition()

		if gamecore.util_func.check_channel_is_en() then
			self._control.furniture_menu_bg.hide_root.deposit_btn.image.sprite = self:loadSprite(var_0_3.dormitory_imgs.room_btn_save)
			self._control.furniture_menu_bg.hide_root.rotate_btn.image.sprite = self:loadSprite(var_0_3.dormitory_imgs.room_btn_flip)
		end

		self._rotate_btn_rect = self._control.furniture_menu_bg.hide_root.rotate_btn.rectTransform
		self._deposit_btn_rect = self._control.furniture_menu_bg.hide_root.deposit_btn.rectTransform
		self._uiroot_canvas_rect = var_0_19.get_ui_root_canvas_rect()
		self._need_sort_furniture = true
		self._need_sort_ship_members = true

		self:__play_room_wall_bgm()

		if self._on_furniture_load_complete_callback then
			self._on_furniture_load_complete_callback()

			self._on_furniture_load_complete_callback = nil
		end
	end

	function arg_1_0:__init_furniture(arg_45_1)
		self._init_furniture_data = arg_45_1
		self.game_machine_list = {}

		for iter_45_0, iter_45_1 in pairs(arg_45_1) do
			if iter_45_1.cid == var_0_3.dormitory_special_furniture_id.home_host_PR5 then
				table.insert(self.game_machine_list, "1")
			elseif iter_45_1.cid == var_0_3.dormitory_special_furniture_id.Yboy_home_host then
				table.insert(self.game_machine_list, "2")
			elseif iter_45_1.cid == var_0_3.dormitory_special_furniture_id.new_home_host_nx then
				table.insert(self.game_machine_list, "3")
			end
		end

		for iter_45_2, iter_45_3 in pairs(arg_45_1) do
			local var_45_0 = var_0_2.find_object_by_cid(iter_45_3.cid)
			local var_45_1 = self:loadUI("furniture")

			if var_45_0.furniture_type == var_0_3.furniture_pos_type.move_forbid then
				var_45_1._panel.transform:SetParent(self._control.room_bg.transform, false)

				self._curr_room_bg_tb[#self._curr_room_bg_tb + 1] = {
					control = var_45_1,
					data = iter_45_3,
					config = var_45_0,
					collider = var_45_1._control.sort_layer.spine.furniture_collider
				}

				if var_45_0.type == var_0_3.furniture_kind_type.wall then
					self._wall_type_furniture = self._curr_room_bg_tb[#self._curr_room_bg_tb]
				elseif var_45_0.type == var_0_3.furniture_kind_type.ground then
					self._ground_type_furniture = self._curr_room_bg_tb[#self._curr_room_bg_tb]
				elseif var_45_0.type == var_0_3.furniture_kind_type.ceiling then
					self._ceiling_type_furniture = self._curr_room_bg_tb[#self._curr_room_bg_tb]
				end
			else
				local var_45_2 = {
					control = var_45_1,
					data = iter_45_3,
					config = var_45_0,
					collider = var_45_1._control.sort_layer.spine.furniture_collider
				}

				self._curr_furniture_tb[#self._curr_furniture_tb + 1] = var_45_2

				if self:__is_back_furniture(var_45_2) then
					var_45_1._panel.transform:SetParent(self._control.room.back_layer.transform, false)
				else
					var_45_1._panel.transform:SetParent(self._control.room.front_layer.transform, false)
				end
			end

			if not self._bg_bgm then
				self:_now_living_bgm(iter_45_3.cid)
			end

			var_45_1:show({
				order = self._base_canvas.sortingOrder,
				data = iter_45_3,
				config = var_45_0,
				game_machine_list = self.game_machine_list,
				callbacks = {
					on_furniture_pointer_down = function(arg_46_0)
						self:__on_furniture_pointer_down(arg_46_0)
					end,
					on_furniture_pointer_up = function(arg_47_0)
						self:__on_furniture_pointer_up(arg_47_0)
					end,
					on_furniture_begin_drag = function(arg_48_0, arg_48_1, arg_48_2)
						if var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.race_car_guardrial and var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.beautiful_vines then
							self:__on_furniture_begin_drag(arg_48_0, arg_48_1, arg_48_2)
						end
					end,
					on_furniture_drag = function(arg_49_0, arg_49_1, arg_49_2)
						if var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.race_car_guardrial and var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.beautiful_vines then
							self:__on_furniture_drag(arg_49_0, arg_49_1, arg_49_2)
						end
					end,
					on_furniture_end_drag = function(arg_50_0, arg_50_1, arg_50_2)
						if var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.race_car_guardrial and var_45_0.cid ~= var_0_3.dormitory_special_furniture_id.beautiful_vines then
							self:__on_furniture_end_drag(arg_50_0, arg_50_1, arg_50_2)
						end
					end
				}
			})

			local var_45_3 = var_0_1:getInstance("dormitory_game")

			if var_45_3 and var_45_0.special_type == var_0_3.furniture_special_type.race_car and var_45_0.cid ~= 10201771 then
				var_45_3:add_car_furniture(var_45_1)
			end
		end

		self._have_beautiful_vines = self:__judge_have_beautiful_vines(self._curr_furniture_tb)
		self._furniture_foot_grid_root_rect = self._control.foot_grid_layer.foot_grid_root.rectTransform

		self:__set_covered_grid_pos_list(true)
		self:__check_on_water_condition()

		self._rotate_btn_rect = self._control.furniture_menu_bg.hide_root.rotate_btn.rectTransform
		self._deposit_btn_rect = self._control.furniture_menu_bg.hide_root.deposit_btn.rectTransform
		self._uiroot_canvas_rect = var_0_19.get_ui_root_canvas_rect()
	end

	function arg_1_0.__is_special_wall_bgm_cid(arg_51_0, arg_51_1)
		return arg_51_1 == 10100171 or arg_51_1 == 10100271 or arg_51_1 == 10100371 or arg_51_1 == 10100671 or arg_51_1 == 10101671
	end

	function arg_1_0:__play_default_dormitory_bgm()
		self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))

		self._bg_bgm = false
	end

	function arg_1_0:__get_current_wall_furniture()
		for iter_53_0, iter_53_1 in pairs(self._curr_room_bg_tb) do
			if iter_53_1.config and iter_53_1.config.type == var_0_3.furniture_kind_type.wall then
				return iter_53_1
			end
		end

		return nil
	end

	function arg_1_0:_now_living_bgm(arg_54_1)
		if self:__is_special_wall_bgm_cid(arg_54_1) then
			if arg_54_1 == 10100171 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_jp))
			elseif arg_54_1 == 10100271 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_jazz))
			elseif arg_54_1 == 10100371 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_cn))
			elseif arg_54_1 == 10100671 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_eu))
			elseif arg_54_1 == 10101671 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.dormitory_model))
			end

			self._bg_bgm = true
		else
			self:__play_default_dormitory_bgm()
		end
	end

	function arg_1_0:__play_room_wall_bgm()
		local var_55_0 = self:__get_current_wall_furniture()

		if var_55_0 and self:__is_special_wall_bgm_cid(var_55_0.data.cid) then
			self:_now_living_bgm(var_55_0.data.cid)
		else
			self:__play_default_dormitory_bgm()
		end
	end

	function arg_1_0:__set_covered_grid_pos_list(arg_56_1)
		self._covered_grid_pos_list = {}

		for iter_56_0, iter_56_1 in ipairs((arg_56_1 or nil) and (self._curr_furniture_tb or self._editing_furniture_tb)) do
			for iter_56_2 = iter_56_1.data.point.x, iter_56_1.data.point.x + iter_56_1.config.width - 1 do
				local var_56_0

				if iter_56_1.data.cid == var_0_3.dormitory_const.oyu_door then
					var_56_0 = iter_56_1.data.point.y + 6 or iter_56_1.data.point.y

					local var_56_1

					if iter_56_1.data.cid == var_0_3.dormitory_const.oyu_door then
						var_56_1 = iter_56_1.data.point.y + iter_56_1.config.height - 1 + 6 or iter_56_1.data.point.y + iter_56_1.config.height - 1
					end
				end

				for iter_56_3 = var_56_0, var_56_1 do
					self._covered_grid_pos_list[#self._covered_grid_pos_list + 1] = {
						id = iter_56_1.data.id,
						grid_x = iter_56_2,
						grid_y = iter_56_3,
						cfg = iter_56_1.config
					}
				end
			end
		end
	end

	function arg_1_0:__sort_furniture()
		self:__set_ceiling_mask_active(true)

		for iter_57_0, iter_57_1 in ipairs(self._curr_room_bg_tb) do
			if iter_57_1.config.type == var_0_3.furniture_kind_type.ceiling or iter_57_1.config.special_type == var_0_3.furniture_special_type.outdoor_wall then
				if self._control.ceiling_mask.activeSelf then
					self:__set_ceiling_mask_active(false)
				end

				iter_57_1.control:set_sort_order(self._base_canvas.sortingOrder + 11)
			else
				iter_57_1.control:set_sort_order(self._base_canvas.sortingOrder + 1)
			end
		end

		for iter_57_2, iter_57_3 in ipairs(self._curr_furniture_tb) do
			if self:__is_back_furniture(iter_57_3) then
				iter_57_3.control:set_sort_order(self._base_canvas.sortingOrder + 4)
			elseif iter_57_3.control._data.cid == 10020171 then
				iter_57_3.control:set_sort_order((self:__get_ship_furniture_layer(iter_57_3.control._control.sort_layer.spine.rectTransform.anchoredPosition)))
			elseif iter_57_3.control._data.cid ~= var_0_3.dormitory_special_furniture_id.beautiful_vines then
				local var_57_0 = self:__get_ship_furniture_layer(iter_57_3.control:get_foot_position())

				if iter_57_3.config.type == var_0_3.furniture_kind_type.hang then
					var_57_0 = var_57_0 - 5
				end

				iter_57_3.control:set_sort_order(var_57_0)
			else
				iter_57_3.control:set_sort_order(512)
			end
		end
	end

	function arg_1_0:__sort_furniture_race()
		self._pause_sort_furniture = true

		for iter_58_0, iter_58_1 in ipairs(self._curr_room_bg_tb) do
			if iter_58_1.data.cid == 10202471 then
				iter_58_1.control:set_sort_order(self._base_canvas.sortingOrder + 51)
			else
				iter_58_1.control:set_sort_order(self._base_canvas.sortingOrder + 50)
			end
		end

		for iter_58_2, iter_58_3 in ipairs(self._curr_furniture_tb) do
			if self:__is_back_furniture(iter_58_3) then
				iter_58_3.control:set_sort_order(self._base_canvas.sortingOrder + 50)
			elseif iter_58_3.control._data.cid == 10040471 then
				iter_58_3.control:set_sort_order(self._base_canvas.sortingOrder + 51)
			elseif iter_58_3.control._data.car_id then
				iter_58_3.control:set_sort_order(self._base_canvas.sortingOrder + 50 + (4 - iter_58_3.control._data.car_id) * 5)
			else
				iter_58_3.control:set_sort_order(self._base_canvas.sortingOrder + 70)
			end
		end
	end

	function arg_1_0.__is_back_furniture(arg_59_0, arg_59_1)
		return arg_59_1.config.furniture_type == var_0_3.furniture_pos_type.wall or arg_59_1.config.furniture_type == var_0_3.furniture_pos_type.floor
	end

	function arg_1_0:__toggle_edit_mode(arg_60_1, arg_60_2)
		if arg_60_1 then
			for iter_60_0, iter_60_1 in ipairs(self._ship_members_tb) do
				if iter_60_1.control.is_in_coffin then
					iter_60_1.control:set_ship_animation(0, "stand1", true)
					iter_60_1.control._control.sort_layer.ship.spine.transform:SetParent(iter_60_1.control._control.sort_layer.ship.transform, false)

					iter_60_1.control._control.sort_layer.ship.spine.rectTransform.anchoredPosition = var_0_6(0, 0)
					iter_60_1.control._control.sort_layer.ship.spine.rectTransform.localScale = var_0_8.one
				end
			end
		end

		self:__toggle_edit_menu(arg_60_1)

		for iter_60_2, iter_60_3 in ipairs(self._curr_furniture_tb) do
			if not arg_60_1 and iter_60_3.config.cid == var_0_3.dormitory_special_furniture_id.cake_display_case then
				-- block empty
			else
				iter_60_3.control:__toggle_edit_mode(arg_60_1)
			end
		end

		self:__handle_editing_furniture_data(arg_60_1, arg_60_2)

		self._is_editing = arg_60_1

		for iter_60_4, iter_60_5 in ipairs(self._ship_members_tb) do
			iter_60_5.control:toggle_ship_btn_raycast(not arg_60_1)
		end

		if not arg_60_1 then
			self:__hide_furniture_menu_btn()
			self:__clear_foot_grid_root()

			for iter_60_6, iter_60_7 in ipairs(self._ship_members_tb) do
				iter_60_7.control:set_grid_foot_position(iter_60_7.control:get_grid_foot_position(), (lan_rand(1, var_0_3.dormitory_const.room_max_ground_grid_y)))
				iter_60_7.control:set_hook(false)
				iter_60_7.control:clear_idea()
				iter_60_7.control:set_ship_animation(0, "stand1", true)
				iter_60_7.control:delay_walk((var_0_19.pick_random_from_array({
					2,
					3,
					4
				})))
			end
		else
			for iter_60_8, iter_60_9 in ipairs(self._ship_members_tb) do
				iter_60_9.control:set_grid_foot_position(iter_60_9.control:get_grid_foot_position(), (lan_rand(1, var_0_3.dormitory_const.room_max_ground_grid_y)))
				iter_60_9.control:set_hook(false)
				iter_60_9.control:clear_idea()
			end

			self:__refresh_dormitory_idea_manager()
			var_0_15:dormitory_idea_manager_stop_race_car()
			var_0_15:dormitory_idea_manager_stop_all_inter_car(arg_60_2)
		end

		self:__reset_swimming_pool_logic(arg_60_1)

		self._control.room.ship_layer.canvasGroup.alpha = arg_60_1 and 0 or 1
		self._control.room.ship_layer.canvasGroup.blocksRaycasts = not arg_60_1
	end

	function arg_1_0:__reset_swimming_pool_logic(arg_61_1)
		for iter_61_0, iter_61_1 in ipairs(self._ship_members_tb) do
			iter_61_1.control:reset_swimming_pool_state(arg_61_1)
		end
	end

	function arg_1_0:__restore_furniture_position()
		for iter_62_0, iter_62_1 in ipairs(self._curr_furniture_tb) do
			iter_62_1.control:reset_furniture_position(iter_62_1.data)
		end

		self:__set_covered_grid_pos_list(true)
	end

	function arg_1_0:__handle_editing_furniture_data(arg_63_1, arg_63_2)
		if arg_63_1 then
			if next(self._furniture_list_form_warehouse) then
				return
			end

			self._editing_furniture_tb = self:__copy_furniture_data(self._curr_furniture_tb)
			self._editing_room_bg_tb = self:__copy_furniture_data(self._curr_room_bg_tb)
		else
			if arg_63_2 then
				self._curr_furniture_tb = self:__copy_furniture_data(self._editing_furniture_tb)
			end

			self._editing_furniture_tb = {}
			self._editing_room_bg_tb = {}

			self:__reset_temp_data()

			self._special_furniture_of_367 = nil
		end
	end

	function arg_1_0.__copy_furniture_data(arg_64_0, arg_64_1)
		local var_64_0 = {}

		for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
			local var_64_1 = {
				control = iter_64_1.control,
				config = iter_64_1.config,
				data = {
					id = iter_64_1.data.id,
					cid = iter_64_1.data.cid,
					point = {
						x = iter_64_1.data.point.x,
						y = iter_64_1.data.point.y
					},
					rotate = iter_64_1.data.rotate
				}
			}

			if iter_64_1.action then
				var_64_1.action = iter_64_1.action
			end

			var_64_0[#var_64_0 + 1] = var_64_1
		end

		return var_64_0
	end

	function arg_1_0.__correct_sort_layers(arg_65_0)
		local var_65_0 = {}

		var_65_0[#var_65_0 + 1] = {
			execute_time = 0.1,
			execute_func = function()
				return
			end
		}
		var_65_0[#var_65_0 + 1] = {
			execute_time = 0.2,
			execute_func = function()
				return
			end
		}
		arg_65_0._time_execute_task_list = var_65_0
	end

	function arg_1_0:__toggle_edit_menu(arg_68_1)
		self._control.edit_menu_bg.canvasGroup.alpha = arg_68_1 and 1 or 0
		self._control.edit_menu_bg.canvasGroup.blocksRaycasts = arg_68_1
	end

	function arg_1_0:__toggle_menu(arg_69_1)
		self._control.menu_bg.gameObject:SetActive(arg_69_1)

		self._control.menu_bg.canvasGroup.alpha = arg_69_1 and 1 or 0
		self._control.menu_bg.canvasGroup.blocksRaycasts = arg_69_1

		if arg_69_1 then
			self:judge_collect_reward()
		end
	end

	function arg_1_0:judge_collect_reward()
		local var_70_0 = false

		for iter_70_0, iter_70_1 in pairs((var_0_14:get_dormitory_collect())) do
			if iter_70_1.get == false then
				local var_70_1 = var_0_24.find_object_by_id(iter_70_1.id)

				if var_70_1 and #iter_70_1.furniture == #var_70_1.furniture_cids then
					var_70_0 = true

					break
				end
			end
		end

		self._control.menu_bg.collection_btn.red:SetActive(var_70_0)
	end

	function arg_1_0:__toggle_open_btn(arg_71_1)
		self._control.open_btn_mask.canvasGroup.alpha = arg_71_1 and 1 or 0
		self._control.open_btn_mask.canvasGroup.blocksRaycasts = arg_71_1
	end

	function arg_1_0:__toggle_close_menu(arg_72_1)
		self._control.close_btn_bg.canvasGroup.alpha = arg_72_1 and 1 or 0
		self._control.close_btn_bg.canvasGroup.blocksRaycasts = arg_72_1

		self._control.open_btn_mask:SetActive(arg_72_1)
	end

	function arg_1_0:__toggle_room_select(arg_73_1)
		self._control.room_select_bg.gameObject:SetActive(arg_73_1)

		self._control.room_select_bg.canvasGroup.alpha = arg_73_1 and 1 or 0
		self._control.room_select_bg.canvasGroup.blocksRaycasts = arg_73_1
	end

	function arg_1_0:__is_room_select_open()
		return self._control.room_select_bg.canvasGroup.blocksRaycasts
	end

	function arg_1_0:__clear_all_ship_inter_furniture()
		for iter_75_0, iter_75_1 in ipairs(self._ship_members_tb) do
			iter_75_1.control:clear_inter_furniture_element()
		end
	end

	function arg_1_0:__clear_foot_grid_root(arg_76_1)
		self._using_foot_grid_obj_rect_list = nil

		if arg_76_1 then
			if self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount < arg_76_1 then
				if self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount == 0 then
					for iter_76_0 = 1, arg_76_1 do
						local var_76_0, var_76_1, var_76_2 = self:__get_foot_grid_rect()

						var_76_0:SetParent(self._control.foot_grid_layer.foot_grid_root.rectTransform, false)
						var_76_2:SetActive(true)
					end
				else
					for iter_76_1 = 1, arg_76_1 - self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount do
						local var_76_3, var_76_4 = self:__get_foot_grid_rect()

						var_76_3:SetParent(self._control.foot_grid_layer.foot_grid_root.rectTransform, false)
					end

					for iter_76_2 = 0, arg_76_1 - 1 do
						self._control.foot_grid_layer.foot_grid_root.rectTransform:GetChild(iter_76_2).gameObject:SetActive(true)
					end
				end
			elseif arg_76_1 < self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount then
				for iter_76_3 = 0, self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount - 1 do
					self._control.foot_grid_layer.foot_grid_root.rectTransform:GetChild(iter_76_3).gameObject:SetActive(iter_76_3 <= arg_76_1 - 1)
				end
			else
				for iter_76_4 = 0, arg_76_1 - 1 do
					self._control.foot_grid_layer.foot_grid_root.rectTransform:GetChild(iter_76_4).gameObject:SetActive(true)
				end
			end
		else
			for iter_76_5, iter_76_6 in ipairs(self._furniture_foot_grid_obj_tb) do
				iter_76_6.transform:SetParent(self._control.foot_grid_pool.rectTransform, false)
			end
		end
	end

	function arg_1_0:__get_foot_grid_rect()
		local var_77_2

		if self._control.foot_grid_pool.rectTransform.childCount > 0 then
			var_77_2 = self._control.foot_grid_pool.rectTransform:GetChild(0).gameObject
		end

		if not var_77_2 then
			var_77_2 = self:createGameObject(var_0_3.dormitory_const.furniture_foot_grid_path)
			self._furniture_foot_grid_obj_tb[#self._furniture_foot_grid_obj_tb + 1] = var_77_2
		end

		local var_77_3 = var_77_2:GetComponent("RectTransform")

		return var_77_3, var_77_3:GetChild(0):GetComponent("Image"), var_77_2
	end

	function arg_1_0:__on_furniture_pointer_down(arg_78_1)
		local var_78_2

		if self._control.foot_grid_pool.rectTransform.childCount > 0 then
			var_78_2 = self._control.foot_grid_pool.rectTransform:GetChild(0).gameObject
		end

		if not var_78_2 then
			var_78_2 = self:createGameObject(var_0_3.dormitory_const.furniture_foot_grid_path)
			self._furniture_foot_grid_obj_tb[#self._furniture_foot_grid_obj_tb + 1] = var_78_2
		end

		local var_78_3 = var_78_2:GetComponent("RectTransform"):GetChild(0):GetComponent("Image")

		self._selecting_furniture_id = arg_78_1

		local var_78_4 = self:__get_editing_furniture_ele_by_id(arg_78_1)

		self:__hide_furniture_menu_btn()

		if var_78_4.config.cid == var_0_3.dormitory_special_furniture_id.beautiful_vines then
			self._special_furniture_of_367 = var_78_4.control._beautiful_vines_mask
			self._special_furniture_of_367:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
			self._special_furniture_of_367:GetComponent("RectTransform").pivot = var_0_6(0, 0)
			self._special_furniture_of_367:GetComponent("RectTransform").anchoredPosition = var_0_6(0, 260)

			return
		elseif self._special_furniture_of_367 then
			self._special_furniture_of_367:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0
		end

		local var_78_5 = self:__get_editing_furniture_data_pos(arg_78_1)

		if self:__is_back_furniture(var_78_4) then
			self._furniture_foot_grid_root_rect:SetParent(self._control.room.back_grid.rectTransform, false)
		else
			self._furniture_foot_grid_root_rect:SetParent(self._control.room.front_grid.rectTransform, false)
		end

		self._furniture_foot_grid_root_rect.anchoredPosition = var_78_5

		self:__clear_foot_grid_root(var_78_4.config.width * var_78_4.config.height)

		self._using_foot_grid_obj_rect_list = {}

		for iter_78_0 = 1, var_78_4.config.width do
			for iter_78_1 = 1, var_78_4.config.height do
				local var_78_6 = self._control.foot_grid_layer.foot_grid_root.rectTransform:GetChild(0)
				local var_78_7 = var_78_6.gameObject:GetComponent("RectTransform")
				local var_78_8 = var_78_6:GetChild(0):GetComponent("Image")

				var_78_7.anchoredPosition = var_0_6((iter_78_0 - 1) * var_0_3.dormitory_const.room_x_plus, (iter_78_1 - 1) * var_0_3.dormitory_const.room_y_plus)
				self._using_foot_grid_obj_rect_list[#self._using_foot_grid_obj_rect_list + 1] = {
					id = arg_78_1,
					rect = var_78_7,
					relative_grid_x = iter_78_0 - 1,
					relative_grid_y = iter_78_1 - 1,
					grid_image = var_78_8
				}
			end
		end

		self:__check_grid_cover_overlap(arg_78_1)
	end

	function arg_1_0:__on_furniture_pointer_up(arg_79_1)
		self:__open_furniture_edit_menu(arg_79_1)
	end

	function arg_1_0.__correct_furniture_menu_btn_pos(arg_80_0, arg_80_1, arg_80_2)
		return (arg_80_1.y > 720 - arg_80_2 or nil) and var_0_6(arg_80_1.x, 720 - arg_80_2 - 30)
	end

	function arg_1_0:__hide_furniture_menu_btn()
		self._rotate_btn_rect:SetParent(self._control.furniture_menu_bg.hide_root.rectTransform, false)
		self._deposit_btn_rect:SetParent(self._control.furniture_menu_bg.hide_root.rectTransform, false)
	end

	function arg_1_0:__on_click_furniture_deposit_btn()
		self._pause_sort_furniture = true

		self:__remove_furniture(self._selecting_furniture_id, 1)

		self._remove_furniture_id_list[#self._remove_furniture_id_list + 1] = self._selecting_furniture_id

		self:__set_covered_grid_pos_list(false)
		self:__hide_furniture_menu_btn()
		self:__clear_foot_grid_root()

		self._pause_sort_furniture = false

		if self._record_overlap_id_list[self._selecting_furniture_id] then
			self._record_overlap_id_list[self._selecting_furniture_id] = nil
		end
	end

	function arg_1_0:__on_click_furniture_rotate_btn()
		local var_83_0 = self:__get_editing_furniture_ele_by_id(self._selecting_furniture_id)

		var_83_0.data.rotate = not var_83_0.data.rotate

		var_83_0.control:set_furniture_flip(var_83_0.data.rotate)
	end

	function arg_1_0:__on_furniture_begin_drag(arg_84_1, arg_84_2, arg_84_3)
		self._control.foot_grid_layer.pre_mover.rectTransform.anchoredPosition = self:__get_editing_furniture_data_pos(arg_84_1)

		local var_84_0 = var_0_6()
		local var_84_1, var_84_2 = var_0_18.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_6(arg_84_2, arg_84_3), nil, nil)

		if var_84_1 then
			self._delta_vector = self._control.foot_grid_layer.pre_mover.rectTransform.anchoredPosition - var_84_2
		end

		self._editing_furniture_ele = self:__get_editing_furniture_ele_by_id(arg_84_1)
		self._editing_furniture_begin_grid = {
			x = self._editing_furniture_ele.data.point.x,
			y = self._editing_furniture_ele.data.point.y
		}
	end

	function arg_1_0:__on_furniture_drag(arg_85_1, arg_85_2, arg_85_3)
		local var_85_0 = var_0_8(arg_85_2, arg_85_3, 0)
		local var_85_1 = var_0_6()
		local var_85_2 = var_0_6()
		local var_85_3, var_85_4 = var_0_18.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_6(arg_85_2, arg_85_3), nil, nil)

		if var_85_3 then
			self._control.foot_grid_layer.pre_mover.rectTransform.anchoredPosition = self._delta_vector + var_85_4
			var_85_1 = self._control.foot_grid_layer.pre_mover.rectTransform.anchoredPosition
		end

		local var_85_5, var_85_6 = self:__check_move_grid(var_0_10(var_85_1.x / var_0_3.dormitory_const.room_x_plus + 0.5), var_0_10(var_85_1.y / var_0_3.dormitory_const.room_y_plus + 0.5), self._editing_furniture_ele.config)

		self._editing_furniture_ele.data.point.x = var_85_5
		self._editing_furniture_ele.data.point.y = var_85_6

		self._editing_furniture_ele.control:set_furniture_scale(var_85_6)
		self._editing_furniture_ele.control:set_furniture_position(var_85_5, var_85_6)

		self._furniture_foot_grid_root_rect.anchoredPosition = self:__convert_grid_to_pos(var_85_5, var_85_6, arg_85_1)

		if var_85_5 ~= self._old_checked_grid_x or var_85_6 ~= self._old_checked_grid_y then
			self:__set_covered_grid_pos_list(false)
			self:__check_grid_cover_overlap(arg_85_1)
		end

		self._old_checked_grid_x = var_85_5
		self._old_checked_grid_y = var_85_6
	end

	function arg_1_0:__on_furniture_end_drag(arg_86_1, arg_86_2, arg_86_3)
		local var_86_0 = self:__check_grid_cover_overlap(arg_86_1)

		if var_86_0 then
			self._editing_furniture_ele.data.point.x = self._editing_furniture_begin_grid.x
			self._editing_furniture_ele.data.point.y = self._editing_furniture_begin_grid.y

			self._editing_furniture_ele.control:set_furniture_scale(self._editing_furniture_begin_grid.y)
			self._editing_furniture_ele.control:set_furniture_position(self._editing_furniture_begin_grid.x, self._editing_furniture_begin_grid.y)

			self._furniture_foot_grid_root_rect.anchoredPosition = self:__convert_grid_to_pos(self._editing_furniture_begin_grid.x, self._editing_furniture_begin_grid.y, arg_86_1)

			self:__set_covered_grid_pos_list(false)
			self:__check_grid_cover_overlap(arg_86_1)
		end

		self:__open_furniture_edit_menu(arg_86_1)

		self._editing_furniture_ele.action = var_0_3.update_modify

		if not var_86_0 and next(self._record_overlap_id_list) then
			if self._record_overlap_id_list[arg_86_1] then
				self._record_overlap_id_list[arg_86_1] = nil
			end

			for iter_86_0, iter_86_1 in pairs(self._record_overlap_id_list) do
				if iter_86_1 and not self:__get_furniture_overlap_state(iter_86_1) then
					self._record_overlap_id_list[iter_86_1] = nil
				end
			end
		end
	end

	function arg_1_0:__get_furniture_overlap_state(arg_87_1)
		local var_87_0 = self:__get_editing_furniture_ele_by_id(arg_87_1)

		if not var_87_0 then
			return false
		end

		self._using_foot_grid_obj_rect_list = {}

		for iter_87_0 = 1, var_87_0.config.width do
			for iter_87_1 = 1, var_87_0.config.height do
				if 0 >= self._control.foot_grid_layer.foot_grid_root.rectTransform.childCount then
					return self:__check_grid_cover_overlap(arg_87_1)
				end

				local var_87_1 = self._control.foot_grid_layer.foot_grid_root.rectTransform:GetChild(0)
				local var_87_2 = var_87_1.gameObject:GetComponent("RectTransform")

				if var_87_1.childCount == 0 then
					return
				end

				local var_87_3 = var_87_1:GetChild(0):GetComponent("Image")

				var_87_2.anchoredPosition = var_0_6((iter_87_0 - 1) * var_0_3.dormitory_const.room_x_plus, (iter_87_1 - 1) * var_0_3.dormitory_const.room_y_plus)
				self._using_foot_grid_obj_rect_list[#self._using_foot_grid_obj_rect_list + 1] = {
					id = arg_87_1,
					rect = var_87_2,
					relative_grid_x = iter_87_0 - 1,
					relative_grid_y = iter_87_1 - 1,
					grid_image = var_87_3
				}
			end
		end

		return self:__check_grid_cover_overlap(arg_87_1)
	end

	function arg_1_0:__open_furniture_edit_menu(arg_88_1)
		local var_88_0 = self:__get_editing_furniture_ele_by_id(arg_88_1)
		local var_88_1 = 100
		local var_88_2 = var_88_0.control:get_furniture_sprite_top_pos()

		self._deposit_btn_rect.localScale = var_0_8(1.5, 1.5, 1)
		self._rotate_btn_rect.localScale = var_0_8(1.5, 1.5, 1)

		if not var_88_0.config.can_flip then
			var_88_1 = 0
		end

		local var_88_3 = self:__correct_furniture_menu_btn_pos(var_88_2 + var_0_6(var_88_1 / 2, 0), self._deposit_btn_rect.sizeDelta.y)

		if var_88_0.data.cid == var_0_3.dormitory_special_furniture_id.tree_swing then
			var_88_3.y = var_88_3.y - self._deposit_btn_rect.rect.height
		end

		self._deposit_btn_rect.anchoredPosition = var_88_3

		self._deposit_btn_rect:SetParent(self._control.furniture_menu_bg.show_root.rectTransform, false)

		if not var_88_0.config.can_flip then
			return
		end

		local var_88_4 = self:__correct_furniture_menu_btn_pos(var_88_2 - var_0_6(var_88_1 / 2, 0), self._rotate_btn_rect.sizeDelta.y)

		if var_88_0.data.cid == var_0_3.dormitory_special_furniture_id.tree_swing then
			var_88_4.y = var_88_4.y - self._rotate_btn_rect.rect.height
		end

		self._rotate_btn_rect.anchoredPosition = var_88_4

		self._rotate_btn_rect:SetParent(self._control.furniture_menu_bg.show_root.rectTransform, false)
	end

	function arg_1_0:__check_move_grid(arg_89_1, arg_89_2, arg_89_3)
		local var_89_0 = arg_89_1
		local var_89_1 = arg_89_2

		if arg_89_3.furniture_type == var_0_3.furniture_pos_type.move_forbid then
			var_89_0 = self._editing_furniture_begin_grid.x
			var_89_1 = self._editing_furniture_begin_grid.y
		elseif arg_89_3.furniture_type == var_0_3.furniture_pos_type.wall then
			if var_89_0 < 0 then
				var_89_0 = 0
			end

			if var_89_0 > var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width then
				var_89_0 = var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width
			end

			if var_89_1 < var_0_3.dormitory_const.room_max_ground_grid_y then
				var_89_1 = var_0_3.dormitory_const.room_max_ground_grid_y
			end

			if arg_89_3.xindex.y == -1 then
				if var_89_1 > var_0_3.dormitory_const.room_max_wall_grid_y - arg_89_3.height then
					var_89_1 = var_0_3.dormitory_const.room_max_wall_grid_y - arg_89_3.height
				end
			else
				var_89_1 = arg_89_3.xindex.y
			end
		elseif arg_89_3.furniture_type == var_0_3.furniture_pos_type.ground or arg_89_3.furniture_type == var_0_3.furniture_pos_type.floor then
			if var_89_0 < 0 then
				var_89_0 = 0
			end

			if var_89_0 > var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width then
				var_89_0 = var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width
			end

			if var_89_1 < 0 then
				var_89_1 = 0
			end

			if var_89_1 > var_0_3.dormitory_const.room_max_ground_grid_y - arg_89_3.height then
				var_89_1 = var_0_3.dormitory_const.room_max_ground_grid_y - arg_89_3.height
			end
		elseif arg_89_3.furniture_type == var_0_3.furniture_pos_type.lean_wall then
			if var_89_0 < 0 then
				var_89_0 = 0
			end

			if var_89_0 > var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width then
				var_89_0 = var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width
			end

			if var_89_1 < var_0_3.dormitory_const.room_max_lean_wall_gird_y then
				var_89_1 = var_0_3.dormitory_const.room_max_lean_wall_gird_y
			end

			if var_89_1 > var_0_3.dormitory_const.room_max_ground_grid_y - arg_89_3.height then
				var_89_1 = var_0_3.dormitory_const.room_max_ground_grid_y - arg_89_3.height
			end
		elseif arg_89_3.furniture_type == var_0_3.furniture_pos_type.ceiling then
			if var_89_0 < 0 then
				var_89_0 = 0
			end

			if var_89_0 > var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width then
				var_89_0 = var_0_3.dormitory_const.room_max_grid_x - arg_89_3.width
			end

			if var_89_1 ~= var_0_3.dormitory_const.room_max_wall_grid_y + 4 then
				var_89_1 = var_0_3.dormitory_const.room_max_wall_grid_y + 4
			end
		end

		return var_89_0, var_89_1
	end

	function arg_1_0:__check_grid_cover_overlap(arg_90_1)
		local var_90_0 = false

		if not self._using_foot_grid_obj_rect_list then
			return false
		end

		local var_90_1 = self:__get_editing_furniture_ele_by_id(arg_90_1)

		for iter_90_0, iter_90_1 in ipairs(self._using_foot_grid_obj_rect_list) do
			local var_90_2 = false

			for iter_90_2, iter_90_3 in ipairs(self._covered_grid_pos_list) do
				if var_90_1.config.furniture_type == var_0_3.furniture_pos_type.wall and self._have_beautiful_vines then
					var_90_2 = true
					var_90_0 = true

					break
				end

				if arg_90_1 ~= iter_90_3.id and var_90_1.data.point.x + iter_90_1.relative_grid_x == iter_90_3.grid_x and var_90_1.data.point.y + iter_90_1.relative_grid_y == iter_90_3.grid_y then
					if self:__special_condition_overlap(iter_90_3.id, var_90_1.config) then
						self:__check_furniture_cover_contain(iter_90_3.id, arg_90_1)
					else
						var_90_2 = true
						var_90_0 = true

						break
					end
				end
			end

			if var_90_2 then
				iter_90_1.grid_image.color = self._cover_grid_red_color or self._cover_grid_green_color
			end
		end

		return var_90_0
	end

	function arg_1_0:__get_furniture_data_pos(arg_91_1)
		local var_91_0 = self:__get_furniture_ele_by_id(arg_91_1)

		return self:__convert_grid_to_pos(var_91_0.data.point.x, var_91_0.data.point.y)
	end

	function arg_1_0:__get_editing_furniture_data_pos(arg_92_1)
		local var_92_0 = self:__get_editing_furniture_ele_by_id(arg_92_1)

		return self:__convert_grid_to_pos(var_92_0.data.point.x, var_92_0.data.point.y, arg_92_1)
	end

	function arg_1_0:__convert_grid_to_pos(arg_93_1, arg_93_2, arg_93_3)
		if arg_93_3 and self:__get_editing_furniture_ele_by_id(arg_93_3).config.cid == var_0_3.dormitory_const.oyu_door then
			arg_93_2 = arg_93_2 + 6
		end

		return var_0_6(arg_93_1 * var_0_3.dormitory_const.room_x_plus, arg_93_2 * var_0_3.dormitory_const.room_y_plus)
	end

	function arg_1_0.__convert_to_grid(arg_94_0, arg_94_1, arg_94_2)
		return var_0_6(var_0_10(arg_94_1 / var_0_3.dormitory_const.room_x_plus + 0.5), (var_0_10(arg_94_2 / var_0_3.dormitory_const.room_y_plus + 0.5)))
	end

	function arg_1_0:__get_furniture_ele_by_id(arg_95_1)
		for iter_95_0, iter_95_1 in ipairs(self._curr_furniture_tb) do
			if iter_95_1.data.id == arg_95_1 then
				return iter_95_1
			end
		end
	end

	function arg_1_0:__get_editing_furniture_ele_by_id(arg_96_1)
		local var_96_0

		for iter_96_0, iter_96_1 in pairs(self._editing_furniture_tb) do
			if iter_96_1.data.id == arg_96_1 then
				var_96_0 = iter_96_1

				return iter_96_1
			end
		end

		if not var_96_0 then
			return self:__get_furniture_ele_by_id(arg_96_1)
		end
	end

	function arg_1_0:__special_condition_overlap(arg_97_1, arg_97_2)
		local var_97_0 = false
		local var_97_1 = self:__get_editing_furniture_ele_by_id(arg_97_1)

		if var_97_1.config.cid == var_0_3.furniture_special_condition.on_water.swimming_pool_cid and arg_97_2.special_type == var_0_3.furniture_special_condition.on_water.special_type_num then
			var_97_0 = true
		end

		if (var_97_1.config.cid == var_0_3.furniture_special_condition.on_water.water_motorcycle_cid or var_97_1.config.cid == var_0_3.furniture_special_condition.on_water.rubber_boat_cid) and arg_97_2.cid == var_0_3.furniture_special_condition.on_water.swimming_pool_cid then
			var_97_0 = true
		end

		return (var_97_1.config.type ~= arg_97_2.type and (var_97_1.config.type == var_0_3.furniture_kind_type.floor or arg_97_2.type == var_0_3.furniture_kind_type.floor) and var_97_1.config.cid ~= var_0_3.furniture_special_condition.on_water.swimming_pool_cid and arg_97_2.cid ~= var_0_3.furniture_special_condition.on_water.swimming_pool_cid or nil) and true
	end

	function arg_1_0:__check_furniture_cover_contain(arg_98_1, arg_98_2)
		local var_98_0 = true
		local var_98_1 = self:__get_editing_furniture_ele_by_id(arg_98_1)
		local var_98_2 = self:__get_editing_furniture_ele_by_id(arg_98_2)

		if var_98_1.config.cid ~= var_0_3.furniture_special_condition.on_water.swimming_pool_cid and var_98_2.config.cid ~= var_0_3.furniture_special_condition.on_water.water_motorcycle_cid and var_98_1.config.cid ~= var_0_3.furniture_special_condition.on_water.swimming_pool_cid and var_98_2.config.cid ~= var_0_3.furniture_special_condition.on_water.rubber_boat_cid and (var_98_1.config.type == var_0_3.furniture_kind_type.floor or var_98_2.config.type == var_0_3.furniture_kind_type.floor) then
			return
		end

		local var_98_3
		local var_98_4

		if var_98_1.config.width >= var_98_2.config.width then
			var_98_3 = var_98_1
			var_98_4 = var_98_2
		else
			var_98_3 = var_98_2
			var_98_4 = var_98_1
		end

		if var_98_4.data.point.x >= var_98_3.data.point.x and var_98_4.data.point.y >= var_98_3.data.point.y and var_98_4.data.point.x + var_98_4.config.width <= var_98_3.data.point.x + var_98_3.config.width and var_98_4.data.point.y + var_98_4.config.height <= var_98_3.data.point.y + var_98_3.config.height then
			var_98_0 = false

			var_98_4.control:set_forbid_anim_flag(false)
		else
			var_98_4.control:set_forbid_anim_flag(var_98_0)
			self:__set_curr_furniture_spine_state(var_98_4.data.id, var_98_0)
			var_98_4.control:toggle_spine(var_98_0)
		end
	end

	function arg_1_0:__set_curr_furniture_spine_state(arg_99_1, arg_99_2)
		for iter_99_0, iter_99_1 in pairs(self._curr_furniture_tb) do
			if iter_99_1.data.id == arg_99_1 then
				iter_99_1.control._forbid_anim_flag = arg_99_2
			end
		end
	end

	function arg_1_0:__check_on_water_condition()
		local var_100_1 = -1
		local var_100_2 = -1
		local var_100_3 = self:__check_have_swimming_pool()

		for iter_100_0, iter_100_1 in ipairs(self._curr_furniture_tb) do
			if iter_100_1.config.cid == var_0_3.furniture_special_condition.on_water.water_motorcycle_cid then
				var_100_1 = iter_100_1.data.id
			elseif iter_100_1.config.cid == var_0_3.furniture_special_condition.on_water.rubber_boat_cid then
				var_100_2 = iter_100_1.data.id
			end

			if var_100_3 < 0 then
				if var_100_1 > 0 then
					local var_100_4 = self:__get_furniture_ele_by_id(var_100_1)

					var_100_4.control:set_forbid_anim_flag(true)
					var_100_4.control:toggle_spine(true)
				end

				if var_100_2 > 0 then
					local var_100_5 = self:__get_furniture_ele_by_id(var_100_2)

					var_100_5.control:set_forbid_anim_flag(true)
					var_100_5.control:toggle_spine(true)
				end
			else
				if var_100_1 > 0 then
					self:__check_furniture_cover_contain(var_100_3, var_100_1)
				end

				if var_100_2 > 0 then
					self:__check_furniture_cover_contain(var_100_3, var_100_2)
				end
			end
		end
	end

	function arg_1_0:__check_have_swimming_pool()
		for iter_101_0, iter_101_1 in ipairs(self._curr_furniture_tb) do
			if iter_101_1.config.cid == var_0_3.furniture_special_condition.on_water.swimming_pool_cid then
				return iter_101_1.data.id
			end
		end

		return -1
	end

	function arg_1_0:__refresh_room_select_menu()
		local var_102_0 = var_0_14:get_dormitory_room_num()

		for iter_102_0 = 1, 6 do
			local var_102_1 = iter_102_0 <= var_102_0

			self._control.room_select_bg[var_0_5("room%s", iter_102_0)].room_btn.canvasGroup.alpha = iter_102_0 <= var_102_0 and 1 or 0
			self._control.room_select_bg[var_0_5("room%s", iter_102_0)].room_btn.canvasGroup.blocksRaycasts = var_102_1
		end

		self._control.room_select_bg.expand_btn.canvasGroup.alpha = var_102_0 == 6 and 0 or 1
		self._control.room_select_bg.expand_btn.canvasGroup.blocksRaycasts = var_102_0 ~= 6
	end

	function arg_1_0:__handle_editing_furniture_data_2()
		local var_103_0 = {}

		for iter_103_0, iter_103_1 in pairs(var_0_14:get_dormitory_furniture()) do
			if iter_103_1.room == self._curr_room_index or iter_103_1.room == 0 then
				var_0_13(var_103_0, iter_103_1)
			end
		end

		local var_103_1 = var_0_19.concat_array(self:__copy_furniture_data(self._editing_furniture_tb), (self:__copy_furniture_data(self._editing_room_bg_tb)))

		for iter_103_2, iter_103_3 in pairs(var_103_0) do
			local var_103_2

			for iter_103_4, iter_103_5 in pairs(var_103_1) do
				if iter_103_3.id == iter_103_5.data.id then
					var_103_2 = iter_103_4

					break
				end
			end

			if var_103_2 then
				if iter_103_3.room == 0 then
					var_103_1[var_103_2].action = var_0_3.update_add
				elseif iter_103_3.room == self._curr_room_index then
					var_103_1[var_103_2].action = var_0_3.update_modify
				end
			end
		end

		for iter_103_6, iter_103_7 in pairs(self._furniture_list_to_warehouse) do
			local var_103_5

			for iter_103_8, iter_103_9 in pairs(var_103_1) do
				if iter_103_7.data.id == iter_103_9.data.id then
					var_103_5 = iter_103_8
				end
			end

			if var_103_5 == nil then
				iter_103_7.action = var_0_3.update_remove

				var_0_13(var_103_1, iter_103_7)
			end
		end

		return var_103_1
	end

	function arg_1_0:__reset_temp_data()
		self:__reset_all_furniture_action()

		self._furniture_list_form_warehouse = {}
		self._furniture_list_to_warehouse = {}
	end

	function arg_1_0:__reset_all_furniture_action()
		for iter_105_0 = 1, #self._editing_furniture_tb do
			if self._editing_furniture_tb[iter_105_0].action then
				self._editing_furniture_tb[iter_105_0].action = nil
			end
		end

		for iter_105_1 = 1, #self._editing_room_bg_tb do
			if self._editing_room_bg_tb[iter_105_1].action then
				self._editing_room_bg_tb[iter_105_1].action = nil
			end
		end
	end

	function arg_1_0:__click_edit_ok_btn_event(arg_106_1, arg_106_2)
		if arg_106_1 then
			for iter_106_0, iter_106_1 in pairs((self:__copy_furniture_data(self._editing_furniture_tb))) do
				self:__remove_furniture(iter_106_1.data.id, 1)
			end

			for iter_106_2, iter_106_3 in pairs((self:__copy_furniture_data(self._editing_room_bg_tb))) do
				self:__remove_furniture(iter_106_3.data.id, 2)
			end

			return true
		end

		local var_106_0

		if arg_106_2 ~= nil and not arg_106_2 then
			self:update_room_furniture()
			self:__reset_temp_data()

			do return true end

			var_106_0 = {}
		end

		for iter_106_4, iter_106_5 in pairs((self:__handle_editing_furniture_data_2())) do
			if iter_106_5.action then
				var_0_13(var_106_0, {
					action = iter_106_5.action,
					furniture = {
						id = iter_106_5.data.id,
						point = iter_106_5.data.point,
						rotate = iter_106_5.data.rotate
					}
				})
			end
		end

		self:__reset_temp_data()

		if #var_106_0 <= 0 then
			return true
		end

		var_0_14:req_LayoutRoomReq({
			empty = false,
			id = self._curr_room_index,
			layout = var_106_0
		})

		return true
	end

	function arg_1_0:__remove_furniture(arg_107_1, arg_107_2)
		local var_107_0 = {}
		local var_107_1 = {}

		if arg_107_2 == 1 then
			var_107_0 = self._curr_furniture_tb
			var_107_1 = self._editing_furniture_tb

			if self:__get_furniture_ele_by_id(arg_107_1).config.cid == var_0_3.dormitory_special_furniture_id.beautiful_vines then
				self._special_furniture_of_367 = nil
			end
		elseif arg_107_2 == 2 then
			var_107_0 = self._curr_room_bg_tb
			var_107_1 = self._editing_room_bg_tb
		end

		local var_107_2
		local var_107_3 = false

		for iter_107_0, iter_107_1 in pairs(var_107_0) do
			if arg_107_1 == iter_107_1.data.id then
				var_107_2 = iter_107_0

				if arg_107_2 == 2 then
					if iter_107_1.config.type == var_0_3.furniture_kind_type.wall then
						var_107_3 = true

						if self._wall_type_furniture and self._wall_type_furniture.data.id == arg_107_1 then
							self._wall_type_furniture = nil
						end
					elseif iter_107_1.config.type == var_0_3.furniture_kind_type.ground then
						if self._ground_type_furniture and self._ground_type_furniture.data.id == arg_107_1 then
							self._ground_type_furniture = nil
						end
					elseif iter_107_1.config.type == var_0_3.furniture_kind_type.ceiling and self._ceiling_type_furniture and self._ceiling_type_furniture.data.id == arg_107_1 then
						self._ceiling_type_furniture = nil
					end
				end

				iter_107_1.control:destroy_self()

				iter_107_1.control = nil

				break
			end
		end

		if var_107_2 then
			var_0_12(var_107_0, var_107_2)

			var_107_2 = nil
		end

		for iter_107_2, iter_107_3 in pairs(var_107_1) do
			if arg_107_1 == iter_107_3.data.id then
				var_107_2 = iter_107_2

				break
			end
		end

		local var_107_4

		for iter_107_4, iter_107_5 in pairs(self._furniture_list_form_warehouse) do
			if arg_107_1 == iter_107_5.id then
				var_107_4 = iter_107_4

				break
			end
		end

		if var_107_4 == nil then
			local var_107_5 = false

			for iter_107_6, iter_107_7 in pairs(self._furniture_list_to_warehouse) do
				if arg_107_1 == iter_107_7.data.id then
					var_107_5 = true

					break
				end
			end

			if not var_107_5 then
				local var_107_6 = var_0_14:get_furniture_data_by_id(arg_107_1)

				if var_107_6 and var_107_6.room ~= 0 then
					var_0_13(self._furniture_list_to_warehouse, var_107_1[var_107_2])
				end
			end
		else
			var_0_12(self._furniture_list_form_warehouse, var_107_4)

			if var_0_14:get_furniture_data_by_id(arg_107_1).room ~= 0 then
				var_0_13(self._furniture_list_to_warehouse, var_107_1[var_107_2])
			end
		end

		var_0_12(var_107_1, var_107_2)

		if var_107_3 then
			self:__play_room_wall_bgm()
		end

		self._have_beautiful_vines = self:__judge_have_beautiful_vines(self._editing_furniture_tb)
	end

	function arg_1_0:__put_furniture_pretreatment(arg_108_1)
		local var_108_0 = true
		local var_108_1 = var_0_2.find_object_by_cid(arg_108_1.cid)

		if var_108_1.type == var_0_3.furniture_kind_type.wall then
			if self:__is_special_wall_bgm_cid(arg_108_1.cid) then
				self:_now_living_bgm(arg_108_1.cid)
			else
				self:__play_default_dormitory_bgm()
			end
		end

		if var_108_1.furniture_type == var_0_3.furniture_pos_type.move_forbid and var_108_1.type ~= var_0_3.furniture_kind_type.ceiling then
			if var_108_1.type == var_0_3.furniture_kind_type.wall and var_108_1.special_type == var_0_3.furniture_special_type.outdoor_wall then
				self:__clear_wall_furniture()
				self:__clear_celling_furniture()
			elseif var_108_1.type == var_0_3.furniture_kind_type.ground and arg_108_1.cid == var_0_3.dormitory_special_furniture_id.race_car_road then
				self:__clear_ground_furniture()
			end
		else
			local var_108_2 = false
			local var_108_3 = false
			local var_108_4 = false

			for iter_108_0, iter_108_1 in pairs(self._editing_room_bg_tb) do
				if var_108_1.furniture_type == var_0_3.furniture_pos_type.wall or var_108_1.furniture_type == var_0_3.furniture_pos_type.ceiling then
					if iter_108_1.config.furniture_type == var_0_3.furniture_pos_type.move_forbid and iter_108_1.config.type == var_0_3.furniture_kind_type.wall and iter_108_1.config.special_type == var_0_3.furniture_special_type.outdoor_wall then
						var_108_2 = var_108_1.furniture_type == var_0_3.furniture_pos_type.wall or var_108_1.furniture_type == var_0_3.furniture_pos_type.ceiling

						break
					end
				elseif var_108_1.type == var_0_3.furniture_kind_type.ceiling then
					if iter_108_1.config.furniture_type == var_0_3.furniture_pos_type.move_forbid and iter_108_1.config.type == var_0_3.furniture_kind_type.wall and iter_108_1.config.special_type == var_0_3.furniture_special_type.outdoor_wall then
						var_108_4 = true

						break
					end
				elseif (var_108_1.furniture_type == var_0_3.furniture_pos_type.ground or var_108_1.furniture_type == var_0_3.furniture_pos_type.floor or var_108_1.furniture_type == var_0_3.furniture_pos_type.lean_wall) and iter_108_1.config.cid == var_0_3.dormitory_special_furniture_id.race_car_road then
					var_108_3 = not self:__put_furniture_limit_condition(arg_108_1)

					break
				end
			end

			var_108_0 = not var_108_2 and not var_108_3 and not var_108_4
		end

		return var_108_0
	end

	function arg_1_0.__put_furniture_limit_condition(arg_109_0, arg_109_1)
		local var_109_0 = false
		local var_109_1 = var_0_2.find_object_by_cid(arg_109_1.cid)

		for iter_109_0, iter_109_1 in pairs(var_0_3.dormitory_room_limit_furniture_list) do
			if iter_109_1 == var_109_1.icon then
				var_109_0 = true

				break
			end
		end

		if not var_109_0 then
			var_0_21:show(var_0_22:getNowLang("limitedfurniture"))
		end

		return var_109_0
	end

	function arg_1_0:__clear_wall_furniture()
		for iter_110_0, iter_110_1 in pairs((self:__copy_furniture_data(self._editing_furniture_tb))) do
			if iter_110_1.config.furniture_type == var_0_3.furniture_pos_type.wall or iter_110_1.config.furniture_type == var_0_3.furniture_pos_type.ceiling then
				self._selecting_furniture_id = iter_110_1.data.id

				self:__on_click_furniture_deposit_btn()
			end
		end
	end

	function arg_1_0:__clear_celling_furniture()
		for iter_111_0, iter_111_1 in pairs((self:__copy_furniture_data(self._editing_room_bg_tb))) do
			if iter_111_1.config.type == var_0_3.furniture_kind_type.light then
				self:__remove_furniture(iter_111_1.data.id, 2)
			end
		end
	end

	function arg_1_0:__clear_ground_furniture()
		for iter_112_0, iter_112_1 in pairs((self:__copy_furniture_data(self._editing_furniture_tb))) do
			local var_112_0 = false

			for iter_112_2, iter_112_3 in pairs(var_0_3.dormitory_room_limit_furniture_list) do
				if iter_112_1.config.icon == iter_112_3 then
					var_112_0 = true

					break
				end
			end

			if not var_112_0 then
				self._selecting_furniture_id = iter_112_1.data.id

				self:__on_click_furniture_deposit_btn()
				var_0_21:show(var_0_22:getNowLang("limitedfurniture"))
			end
		end
	end

	function arg_1_0:__get_curr_room_swing_pool_data()
		local var_113_0 = false

		self._special_furniture_swing_pool = {}

		for iter_113_0, iter_113_1 in pairs(self._curr_furniture_tb) do
			if iter_113_1.config.cid == var_0_3.furniture_special_condition.on_water.swimming_pool_cid then
				var_113_0 = true

				var_0_13(self._special_furniture_swing_pool, iter_113_1)

				break
			end
		end

		return var_113_0
	end

	function arg_1_0:__check_ship_cover_furniture(arg_114_1, arg_114_2)
		local var_114_0 = false
		local var_114_1 = false

		self:__get_curr_room_swing_pool_data()

		for iter_114_0, iter_114_1 in pairs(self._special_furniture_swing_pool) do
			local var_114_2 = iter_114_1.control:get_foot_position()

			if arg_114_1.x >= var_114_2.x - var_0_3.dormitory_const.ship_move_x_num and arg_114_1.y >= var_114_2.y - var_0_3.dormitory_const.ship_move_y_num + 20 and arg_114_1.x <= var_114_2.x + var_0_3.dormitory_const.ship_move_x_num and arg_114_1.y <= var_114_2.y + var_0_3.dormitory_const.ship_move_y_num - 50 then
				var_114_0 = true
			end

			if arg_114_2 and (arg_114_1.x >= var_114_2.x + var_0_3.dormitory_const.ship_exit_x_num or arg_114_1.y >= var_114_2.y + var_0_3.dormitory_const.ship_exit_y_num - 50 or arg_114_1.x <= var_114_2.x - var_0_3.dormitory_const.ship_exit_x_num or arg_114_1.y <= var_114_2.y - var_0_3.dormitory_const.ship_exit_y_num + 20) then
				var_114_1 = true
			end
		end

		return var_114_0, var_114_1
	end

	function arg_1_0:__get_ship_enter_direction(arg_115_1)
		local var_115_0 = false
		local var_115_1 = false
		local var_115_2 = false
		local var_115_3 = false

		self:__get_curr_room_swing_pool_data()

		for iter_115_0, iter_115_1 in pairs(self._special_furniture_swing_pool) do
			local var_115_4 = iter_115_1.control:get_foot_position()

			if arg_115_1.x < var_115_4.x then
				var_115_0 = true
			elseif arg_115_1.x > var_115_4.x then
				var_115_1 = true
			elseif arg_115_1.y >= var_115_4.y + var_0_3.dormitory_const.ship_exit_y_num then
				var_115_2 = true
			elseif arg_115_1.y <= var_115_4.y - var_0_3.dormitory_const.ship_exit_y_num then
				var_115_3 = true
			end
		end

		return var_115_0, var_115_1, var_115_2, var_115_3
	end

	function arg_1_0:__get_ship_leave_direction(arg_116_1)
		local var_116_0 = false
		local var_116_1 = false
		local var_116_2 = false
		local var_116_3 = false

		self:__get_curr_room_swing_pool_data()

		for iter_116_0, iter_116_1 in pairs(self._special_furniture_swing_pool) do
			local var_116_4 = iter_116_1.control:get_foot_position()

			if arg_116_1.x >= var_116_4.x + var_0_3.dormitory_const.ship_exit_x_num - 30 then
				var_116_1 = true
			elseif arg_116_1.x <= var_116_4.x - var_0_3.dormitory_const.ship_exit_x_num then
				var_116_0 = true
			elseif arg_116_1.y >= var_116_4.y + var_0_3.dormitory_const.ship_exit_y_num - 50 then
				var_116_2 = true
			elseif arg_116_1.y <= var_116_4.y - var_0_3.dormitory_const.ship_exit_y_num + 20 then
				var_116_3 = true
			end
		end

		return var_116_0, var_116_1, var_116_2, var_116_3
	end

	function arg_1_0:__get_ship_beyond_condition(arg_117_1)
		local var_117_0 = false

		self:__get_curr_room_swing_pool_data()

		for iter_117_0, iter_117_1 in pairs(self._special_furniture_swing_pool) do
			local var_117_1 = iter_117_1.control:get_foot_position()

			if arg_117_1.x <= var_117_1.x - var_0_3.dormitory_const.ship_move_x_num - 53 or arg_117_1.y <= var_117_1.y - var_0_3.dormitory_const.ship_move_y_num - 20 or arg_117_1.x >= var_117_1.x + var_0_3.dormitory_const.ship_move_x_num + 53 or arg_117_1.y >= var_117_1.y + var_0_3.dormitory_const.ship_move_y_num + 5 then
				var_117_0 = true
			end
		end

		return var_117_0
	end

	function arg_1_0.__judge_role_count_condition(arg_118_0, arg_118_1)
		local var_118_0 = 0
		local var_118_1 = {}

		for iter_118_0, iter_118_1 in pairs((var_0_14:get_character_list())) do
			if not var_118_1[iter_118_1.cid] then
				var_118_0 = var_118_0 + 1
				var_118_1[iter_118_1.cid] = iter_118_1.cid
			end
		end

		if var_118_0 < arg_118_1 then
			return false
		else
			return true
		end
	end

	function arg_1_0:_play_into_se(arg_119_1)
		self:playSE(arg_119_1, false)
	end

	function arg_1_0:__put_furniture_limit_of_pet(arg_120_1)
		local var_120_1 = arg_120_1.type == var_0_3.furniture_kind_type.pet

		if arg_120_1.type ~= var_0_3.furniture_kind_type.pet then
			return not var_120_1
		end

		local var_120_2 = 0

		for iter_120_0, iter_120_1 in pairs(self._editing_furniture_tb) do
			if iter_120_1.config.type == var_0_3.furniture_kind_type.pet then
				var_120_2 = var_120_2 + 1
			end
		end

		return (var_120_2 == var_0_3.furntiure_const.max_pet_num and var_120_1 or nil) and false
	end

	function arg_1_0.__change_canvas_group_state(arg_121_0, arg_121_1, arg_121_2)
		arg_121_1.canvasGroup.alpha = arg_121_2 and 1 or 0
		arg_121_1.canvasGroup.interactable = arg_121_2
		arg_121_1.canvasGroup.blocksRaycasts = arg_121_2
	end

	function arg_1_0:_play_audio(arg_122_1)
		self:playBackgroundMusic(arg_122_1)
	end

	function arg_1_0.__judge_have_beautiful_vines(arg_123_0, arg_123_1)
		local var_123_0 = false

		for iter_123_0, iter_123_1 in pairs(arg_123_1) do
			if iter_123_1.config.cid == var_0_3.dormitory_special_furniture_id.beautiful_vines then
				var_123_0 = true

				break
			end
		end

		return var_123_0
	end

	function arg_1_0.__get_ship_furniture_layer(arg_124_0, arg_124_1)
		local var_124_0 = var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + math.ceil((1 - arg_124_1.y / var_0_3.dormitory_const.room_bg_wall_y) * (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain))

		var_124_0 = var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain) < var_124_0 and var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain) or var_124_0
		var_124_0 = var_124_0 <= var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain and var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain or var_124_0

		return var_124_0
	end

	function arg_1_0:__set_ceiling_mask_active(arg_125_1)
		self._control.ceiling_mask.canvasGroup.alpha = arg_125_1 and 1 or 0
	end

	function arg_1_0:__prevent_frequently_click()
		local var_126_0 = self:autoKillDOTween(var_0_25.Sequence())

		var_126_0:AppendInterval(0.4)
		var_126_0:Play()
	end

	function arg_1_0.__onReset(arg_127_0)
		arg_127_0._furniture_foot_grid_obj_tb = {}
		arg_127_0._curr_room_index = 0
		arg_127_0._furniture_load_queue = {}
		arg_127_0._on_furniture_load_complete_callback = nil
		arg_127_0._need_sort_furniture = false
		arg_127_0._need_sort_ship_members = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_128_0)
	local var_128_0 = var_0_1:class("dormitory")

	var_128_0._curr_furniture_tb = {}
	var_128_0._curr_room_bg_tb = {}
	var_128_0._furniture_foot_grid_obj_tb = {}
	var_128_0._furniture_foot_grid_root_rect = nil
	var_128_0._delta_vector = var_0_8(0, 0, 0)
	var_128_0._editing_furniture_tb = {}
	var_128_0._editing_furniture_ele = {}
	var_128_0._editing_furniture_begin_grid = {}
	var_128_0._old_checked_grid_x = 0
	var_128_0._old_checked_grid_y = 0
	var_128_0._time_execute_task_list = nil
	var_128_0._covered_grid_pos_list = {}
	var_128_0._using_foot_grid_obj_rect_list = {}
	var_128_0._cover_grid_green_color = var_0_9(0.549, 0.686, 0.302, 0.588)
	var_128_0._cover_grid_red_color = var_0_9(1, 0, 0, 0.588)
	var_128_0._rotate_btn_rect = nil
	var_128_0._deposit_btn_rect = nil
	var_128_0._selecting_furniture_id = 0
	var_128_0._remove_furniture_id_list = {}
	var_128_0._pause_sort_furniture = false
	var_128_0._ship_members_tb = {}
	var_128_0._is_editing = false
	var_128_0._uiroot_canvas_rect = nil
	var_128_0._curr_room_index = 0
	var_128_0._furniture_list_form_warehouse = {}
	var_128_0._furniture_list_to_warehouse = {}
	var_128_0._wall_type_furniture = nil
	var_128_0._ground_type_furniture = nil
	var_128_0._ceiling_type_furniture = nil
	var_128_0._editing_room_bg_tb = {}
	var_128_0._special_furniture_of_367 = nil
	var_128_0._special_furniture_swing_pool = {}
	var_128_0._bg_bgm = false
	var_128_0._furniture_have_bgm = nil
	var_128_0._has_overlap = false
	var_128_0._have_beautiful_vines = false
	var_128_0._record_overlap_id_list = {}
	var_128_0._exhibition_come_in_flag = 0
	var_128_0.game_machine_list = {}
	var_128_0._now_time = 0
	var_128_0._remain_time = 0
	var_128_0._time_txt = ""
	var_128_0._furniture_load_queue = {}
	var_128_0._on_furniture_load_complete_callback = nil
	var_128_0._need_sort_furniture = false
	var_128_0._need_sort_ship_members = false

	return var_128_0
end

return var_0_0
