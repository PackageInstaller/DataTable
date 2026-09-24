local var_0_0 = {}
local var_0_1 = next
local var_0_2 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_9 = gameconfig.ship_cg_config
local var_0_10 = table.insert
local var_0_11 = table.remove
local var_0_12 = gamecore.prompt

gamecore.UILoader:define("cinema_picture_book", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._book_pages = arg_2_1

		self:__wipe_all_labels()
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_cg_config(arg_3_1)
		self._index = arg_3_1
		self._control.page_1.txt.text.text = arg_3_1 + 1

		local var_3_0, var_3_1 = var_0_9:get_sequence()

		self._book_sum_pages = math.ceil(var_3_1 / 9)

		local var_3_2 = var_0_2:get_player_story_unlock_data()
		local var_3_3 = {}

		for iter_3_0 = 1, #var_3_2 do
			if var_3_2[iter_3_0].type == 3 then
				var_0_10(var_3_3, var_3_2[iter_3_0].id)
			end
		end

		local var_3_4 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}

		for iter_3_1 = 1, #var_3_4 do
			if var_3_0[9 * arg_3_1 + iter_3_1] then
				var_3_4[iter_3_1].btn:SetActive(false)
				var_3_4[iter_3_1].name_txt:SetActive(false)
				var_3_4[iter_3_1].sort_txt:SetActive(false)
				var_3_4[iter_3_1].unopen_txt:SetActive(false)
				var_3_4[iter_3_1].lock_txt:SetActive(true)

				var_3_4[iter_3_1].name_txt.text.text = var_3_0[9 * arg_3_1 + iter_3_1].title
				var_3_4[iter_3_1].sort_txt.text.text = "NO.00" .. var_3_0[9 * arg_3_1 + iter_3_1].sort

				if #tostring(var_3_0[9 * arg_3_1 + iter_3_1].sort) == 2 then
					var_3_4[iter_3_1].sort_txt.text.text = "NO.0" .. var_3_0[9 * arg_3_1 + iter_3_1].sort
				end

				var_3_4[iter_3_1].lock_txt.text.text = var_3_0[9 * arg_3_1 + iter_3_1].sort > 9 and "NO.0" .. var_3_0[9 * arg_3_1 + iter_3_1].sort or "NO.00" .. var_3_0[9 * arg_3_1 + iter_3_1].sort
				var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.cg_sprite[3], var_3_0[9 * arg_3_1 + iter_3_1].cid))

				var_3_4[iter_3_1].btn.button.onClick:RemoveAllListeners()
				var_3_4[iter_3_1].btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_4:createInstance("cinema_cg_info"):show(var_3_0[9 * arg_3_1 + iter_3_1].cid, self._book_pages, var_0_5.enter_icon_detail_type.cinema_picture_book)
				end)

				if #var_3_3 then
					for iter_3_2 = 1, #var_3_3 do
						if var_3_0[9 * arg_3_1 + iter_3_1].cid == var_3_3[iter_3_2] then
							var_3_4[iter_3_1].btn:SetActive(true)
							var_3_4[iter_3_1].name_txt:SetActive(true)
							var_3_4[iter_3_1].sort_txt:SetActive(true)
							var_3_4[iter_3_1].lock_txt:SetActive(false)

							var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.cg_sprite[2], var_3_0[9 * arg_3_1 + iter_3_1].cid))
						end
					end
				end
			else
				var_3_4[iter_3_1].btn:SetActive(false)
				var_3_4[iter_3_1].name_txt:SetActive(false)
				var_3_4[iter_3_1].sort_txt:SetActive(false)
				var_3_4[iter_3_1].unopen_txt:SetActive(true)
				var_3_4[iter_3_1].lock_txt:SetActive(false)

				var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_5.cg_sprite[4])
				var_3_4[iter_3_1].unopen_txt.text.text = var_0_3:getNowLang("shipnotopen")
			end
		end

		if not self._is_picking then
			self._selected_picture = var_0_2:get_selected_pic()
		end

		self:__refresh_num()
	end

	function arg_1_0:__select_mode(arg_5_1)
		local var_5_0, var_5_1 = var_0_9:get_sequence()
		local var_5_2 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}
		local var_5_3 = var_0_2:get_player_story_unlock_data()
		local var_5_4 = {}

		for iter_5_0 = 1, #var_5_3 do
			if var_5_3[iter_5_0].type == 3 then
				var_0_10(var_5_4, var_5_3[iter_5_0].id)
			end
		end

		for iter_5_1 = 1, #var_5_2 do
			if #var_5_4 then
				for iter_5_2 = 1, #var_5_4 do
					if var_5_0[9 * self._index + iter_5_1] and var_5_0[9 * self._index + iter_5_1].cid == var_5_4[iter_5_2] then
						var_5_2[iter_5_1].btn:SetActive(arg_5_1)
						var_5_2[iter_5_1].select_btn:SetActive(not arg_5_1)
					end
				end
			end
		end
	end

	function arg_1_0:__control_label(arg_6_1)
		local var_6_0, var_6_1 = var_0_9:get_sequence()
		local var_6_2 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}

		if arg_6_1 == "save" then
			for iter_6_0 = 1, #var_6_2 do
				for iter_6_1, iter_6_2 in pairs(self._selected_picture) do
					if var_6_0[9 * self._index + iter_6_0] and var_6_0[9 * self._index + iter_6_0].cid == iter_6_2 then
						var_6_2[iter_6_0].label_choose:SetActive(false)
						var_6_2[iter_6_0].label_save:SetActive(true)
					end
				end
			end
		end

		if arg_6_1 == "choose" then
			for iter_6_3 = 1, #var_6_2 do
				for iter_6_4, iter_6_5 in pairs(self._selected_picture) do
					if var_6_0[9 * self._index + iter_6_3] and var_6_0[9 * self._index + iter_6_3].cid == iter_6_5 then
						var_6_2[iter_6_3].label_choose:SetActive(true)
						var_6_2[iter_6_3].label_save:SetActive(false)

						var_6_2[iter_6_3].label_choose.Text.text.text = tostring(iter_6_4)
					end
				end
			end
		end

		if arg_6_1 == "change" then
			for iter_6_6 = 1, #var_6_2 do
				if var_6_0[9 * self._index + iter_6_6] and self._selected_picture and var_0_1(self._selected_picture) then
					for iter_6_7, iter_6_8 in pairs(self._selected_picture) do
						if var_6_0[9 * self._index + iter_6_6].cid == iter_6_8 then
							if self._is_picking then
								var_6_2[iter_6_6].label_choose:SetActive(true)
								var_6_2[iter_6_6].label_save:SetActive(false)

								break
							end

							var_6_2[iter_6_6].label_choose:SetActive(false)
							var_6_2[iter_6_6].label_save:SetActive(true)

							break
						end

						var_6_2[iter_6_6].label_choose:SetActive(false)
						var_6_2[iter_6_6].label_save:SetActive(false)
					end
				else
					var_6_2[iter_6_6].label_choose:SetActive(false)
					var_6_2[iter_6_6].label_save:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__check_picture(arg_7_1)
		local var_7_0, var_7_1 = var_0_9:get_sequence()
		local var_7_2 = var_0_2:get_player_story_unlock_data()
		local var_7_3 = {}
		local var_7_4 = false

		for iter_7_0 = 1, #var_7_2 do
			if var_7_2[iter_7_0].type == 3 then
				var_0_10(var_7_3, var_7_2[iter_7_0].id)
			end
		end

		for iter_7_1, iter_7_2 in pairs(var_7_3) do
			if var_7_0[self._index * 9 + arg_7_1] and iter_7_2 == var_7_0[self._index * 9 + arg_7_1].cid then
				var_7_4 = true

				break
			end
		end

		if var_7_4 then
			if self._selected_picture and var_0_1(self._selected_picture) then
				for iter_7_3, iter_7_4 in pairs(self._selected_picture) do
					if iter_7_4 == var_7_0[self._index * 9 + arg_7_1].cid then
						return 1
					end
				end

				return 2
			else
				return 2
			end
		end
	end

	function arg_1_0:__exit()
		if self._is_picking then
			self._selected_picture = var_0_2:get_selected_pic()

			local var_8_0, var_8_1 = var_0_9:get_sequence()
			local var_8_2 = {
				self._control.cg_1,
				self._control.cg_2,
				self._control.cg_3,
				self._control.cg_4,
				self._control.cg_5,
				self._control.cg_6,
				self._control.cg_7,
				self._control.cg_8,
				self._control.cg_9
			}

			for iter_8_0 = 1, #var_8_2 do
				if var_8_0[9 * self._index + iter_8_0] then
					var_8_2[iter_8_0].label_choose:SetActive(false)
					var_8_2[iter_8_0].label_save:SetActive(false)
				end
			end

			self._control.editor_btn:SetActive(true)
			self._control.save_btn:SetActive(false)
			self._control.reset_btn:SetActive(false)

			self._is_picking = false
		end
	end

	function arg_1_0:__insert_picture(arg_9_1, arg_9_2)
		local var_9_0, var_9_1 = var_0_9:get_sequence()

		if arg_9_2 then
			var_0_10(self._selected_picture, var_9_0[self._index * 9 + arg_9_1].cid)
		else
			for iter_9_0, iter_9_1 in pairs(self._selected_picture) do
				if iter_9_1 == var_9_0[self._index * 9 + arg_9_1].cid then
					var_0_11(self._selected_picture, iter_9_0)
				end
			end
		end
	end

	function arg_1_0:__press_select_btn(arg_10_1)
		local var_10_0 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}

		if self:__check_picture(arg_10_1) == 1 then
			var_10_0[arg_10_1].label_choose:SetActive(false)
			self:__insert_picture(arg_10_1, false)
			self:__refresh_num()
		elseif self:__check_picture(arg_10_1) == 2 and #self._selected_picture < 5 then
			var_10_0[arg_10_1].label_choose:SetActive(true)
			self:__insert_picture(arg_10_1, true)

			var_10_0[arg_10_1].label_choose.Text.text.text = tostring(#self._selected_picture)
		elseif self:__check_picture(arg_10_1) == 2 and #self._selected_picture >= 5 then
			var_0_12:show(var_0_3:getNowLang("cg_ceiling"))
		end
	end

	function arg_1_0:__refresh_num()
		local var_11_0, var_11_1 = var_0_9:get_sequence()
		local var_11_2 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}

		if self._selected_picture and var_0_1(self._selected_picture) then
			for iter_11_0 = 1, #var_11_2 do
				for iter_11_1, iter_11_2 in pairs(self._selected_picture) do
					if var_11_0[9 * self._index + iter_11_0] and var_11_0[9 * self._index + iter_11_0].cid == iter_11_2 then
						var_11_2[iter_11_0].label_choose.Text.text.text = tostring(iter_11_1)
					end
				end
			end
		end
	end

	function arg_1_0:__init_panel(arg_12_1)
		self._control.page_1.txt.text.text = arg_12_1

		self:__init_cg_config(arg_12_1 - 1)

		self._control.picture_book_text.text.text = var_0_3:getNowLang("ui_cgpack_title")
		self._control.tips_text.text.text = var_0_3:getNowLang("cg_desc")

		self._control.editor_btn:SetActive(true)
		self._control.save_btn:SetActive(false)
		self._control.reset_btn:SetActive(false)
		self:__select_mode(true)
		self:__control_label("save")
	end

	function arg_1_0:__save_req()
		var_0_2:set_selected_pic(self._selected_picture)
		var_0_2:req_SaveCustomCoverReq(self._selected_picture)
	end

	function arg_1_0:__wipe_all_labels()
		local var_14_0, var_14_1 = var_0_9:get_sequence()
		local var_14_2 = {
			self._control.cg_1,
			self._control.cg_2,
			self._control.cg_3,
			self._control.cg_4,
			self._control.cg_5,
			self._control.cg_6,
			self._control.cg_7,
			self._control.cg_8,
			self._control.cg_9
		}

		for iter_14_0 = 1, #var_14_2 do
			if var_14_0[9 * self._index + iter_14_0] then
				var_14_2[iter_14_0].label_choose:SetActive(false)
				var_14_2[iter_14_0].label_save:SetActive(false)
			end
		end
	end

	function arg_1_0.__onReset(arg_15_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_4:class("cinema_picture_book")

	var_16_0._book_pages = 1
	var_16_0._book_sum_pages = 1
	var_16_0._index = 1
	var_16_0._selected_picture = {}
	var_16_0._is_picking = false

	return var_16_0
end

return var_0_0
