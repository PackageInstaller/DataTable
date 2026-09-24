local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_4 = table.sort
local var_0_5 = gamecore.UILoader
local var_0_6 = UnityEngine.Time
local var_0_7 = gameconfig.ship_cg_config
local var_0_8 = gameenum.common_type
local var_0_9 = math.abs
local var_0_10 = 1

gamecore.UILoader:define("cinema_cg_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_3 then
			self._panel_type = arg_2_3
		end

		if arg_2_4 then
			self._call_fun = arg_2_4
		end

		self:set_layer()
		self:setVisible(true)

		self._back_pages = arg_2_2
		self._now_page_cid = arg_2_1

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:colliection_move_in_animation(arg_3_1, arg_3_2)
		var_0_8:play_in_out_animation(self._control.move_sequence.uITweenSequence, arg_3_1, arg_3_2)
	end

	function arg_1_0.set_layer(arg_4_0)
		local var_4_0 = var_0_5:getInstance("strike_awardbox")

		if var_4_0 then
			var_4_0:setVisible(false)
		end
	end

	function arg_1_0:__onUpdate()
		if self._is_already_init then
			self.time = var_0_6.deltaTime + self.time

			if UnityEngine.Input.GetMouseButtonDown(0) then
				self._start_pos = UnityEngine.Input.mousePosition
			end

			if UnityEngine.Input.GetMouseButtonUp(0) then
				self._end_pos = UnityEngine.Input.mousePosition

				if self._start_pos and self._end_pos then
					self:__mouse_drag_event()
				end
			end
		end

		if self.time >= 5 and var_0_10 == 1 then
			self:colliection_move_in_animation(true)

			var_0_10 = 2
		end
	end

	function arg_1_0.sort_rule(arg_6_0, arg_6_1)
		var_0_4(arg_6_1, function(arg_7_0, arg_7_1)
			return arg_7_0 < arg_7_1
		end)

		return arg_6_1
	end

	function arg_1_0:activation_ui()
		if var_0_10 == 1 then
			self.time = 0
		else
			self:colliection_move_in_animation(false)

			var_0_10 = 1
			self.time = 0
		end
	end

	function arg_1_0:_init_cg_config(arg_9_1)
		local var_9_0 = var_0_7.find_object_by_cid(arg_9_1)

		self._now_sort = self:get_now_sort(arg_9_1)

		self._control.next_page_btn:SetActive(true)
		self._control.last_page_btn:SetActive(true)

		if self._now_sort == 1 then
			self._control.last_page_btn:SetActive(false)
		end

		if #self.is_have_cg_list <= self._now_sort then
			self._control.next_page_btn:SetActive(false)
		end

		self._control.cg.image.sprite = self:loadSprite(var_0_8:get_ship_icon(var_0_8.cg_sprite[1], arg_9_1))
		self._control.cg_completely.image.sprite = self:loadSprite(var_0_8:get_ship_icon(var_0_8.cg_sprite[1], arg_9_1))

		if #tostring(var_9_0.sort) == 1 then
			self._control.move_group.mash_desc.sort_txt.text.text = "NO.00" .. var_9_0.sort
		elseif #tostring(var_9_0.sort) == 2 then
			self._control.move_group.mash_desc.sort_txt.text.text = "NO.0" .. var_9_0.sort
		end

		self._control.move_group.mash_desc.desc_txt.text.text = var_9_0.desc
		self._control.move_group.mash_title.txt.text.text = var_9_0.title
	end

	function arg_1_0:shrink_extend_event(arg_10_1)
		self.time = 0

		self._control.shrink_btn:SetActive(arg_10_1)
		self._control.extend_btn:SetActive(not arg_10_1)
		self._control.cg:SetActive(arg_10_1)
		self._control.cg_completely:SetActive(not arg_10_1)
	end

	function arg_1_0:__mouse_drag_event()
		if var_0_9(self._end_pos.x - self._start_pos.x) > 10 then
			if self._end_pos.x - self._start_pos.x > 0 then
				if self.is_have_cg_list[self._now_sort - 1] == nil then
					return
				end

				self:_init_cg_config(self._now_page_cid)
			else
				if self.is_have_cg_list[self._now_sort + 1] == nil then
					return
				end

				self:_init_cg_config(self._now_page_cid)
			end
		end
	end

	function arg_1_0:__init_panel(arg_12_1)
		local var_12_0 = var_0_1:get_player_story_unlock_data()

		self.is_have_cg_list = {}

		for iter_12_0 = 1, #var_12_0 do
			if var_12_0[iter_12_0].type == 3 then
				var_0_2(self.is_have_cg_list, var_12_0[iter_12_0].id)
			end
		end

		self.is_have_cg_list = self:sort_rule(self.is_have_cg_list)

		self:activation_ui()
		self._control.shrink_btn:SetActive(true)
		self._control.extend_btn:SetActive(false)
		self._control.cg:SetActive(true)
		self._control.cg_completely:SetActive(false)

		self._is_already_init = true

		if UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.44 then
			self._control.shrink_btn:SetActive(false)
			self._control.extend_btn:SetActive(false)
		end

		self:_init_cg_config(arg_12_1)

		if self._panel_type and self._panel_type ~= var_0_8.enter_icon_detail_type.cinema_picture_book then
			self._control.cover.gameObject:SetActive(false)
			self._control.get_cover_btn.gameObject:SetActive(true)
			self._control.return_btn:SetActive(false)
			self._control.shrink_btn:SetActive(false)
			self._control.last_page_btn:SetActive(false)
			self._control.next_page_btn:SetActive(false)
		end
	end

	function arg_1_0:get_now_sort(arg_13_1)
		for iter_13_0 = 1, #self.is_have_cg_list do
			if self.is_have_cg_list[iter_13_0] == arg_13_1 then
				return iter_13_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_14_0)
	local var_14_0 = var_0_5:class("cinema_cg_info")

	var_14_0._is_already_init = false
	var_14_0._start_pos = nil
	var_14_0._end_pos = nil
	var_14_0._now_sort = nil
	var_14_0._back_pages = nil
	var_14_0.time = 0
	var_14_0._now_page_cid = nil
	var_14_0._panel_type = nil

	return var_14_0
end

return var_0_0
