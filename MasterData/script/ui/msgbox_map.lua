local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gameconfig.ship_config
local var_0_5 = gamecore.util_func

gamecore.UILoader:define("msgbox_map", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2)
		self:setVisible(true)
		self:__init_ship_list()
		self:__init_panel(arg_3_1, arg_3_2)
	end

	function arg_1_0:__init_ship_list()
		self._item_list = {
			self._control.reduce_cd.item_1,
			self._control.reduce_cd.item_2,
			self._control.reduce_cd.item_3,
			self._control.reduce_cd.item_4
		}
	end

	function arg_1_0:__init_panel(arg_5_1, arg_5_2)
		self._data = arg_5_1
		self._now_label = arg_5_2

		local var_5_0 = var_0_4.find_object_by_cid(self._data.cid).access

		self._control.main.confirm.ship_detail_txt.text.text = var_0_2:getNowLang("leaderboardship") .. var_0_2:getNowLang("pvpdetailbtn")
		self._control.main.name_dd.name_dd_1.text.text = self._data.title

		self._control.main.name_dd:GetComponent("TextHorizonScroller"):SetText(self._data.title)

		self._control.top.ship_headpic_area.ship_headpic.image.sprite = self:loadSprite(var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_s, self._data.pic_id))

		if var_5_0 then
			self._data_access = var_0_5.little_clone(var_5_0)

			for iter_5_0 = 1, 4 do
				self._item_list[iter_5_0]:SetActive(false)
			end

			if #var_5_0 == 1 then
				self._item_list[1].next_btn_1:SetActive(true)
				self._item_list[1]:SetActive(true)

				self._item_list[1].title_1.text.text = self:__init_access_language(var_5_0[1])
				self._control.txt_1.text.text = var_0_2:getNowLang("questgo")

				if var_5_0[1] == 5 then
					self._item_list[1].next_btn_1:SetActive(false)
				end
			elseif #var_5_0 == 2 then
				self._item_list[1].next_btn_1:SetActive(true)
				self._item_list[2].next_btn_2:SetActive(true)

				self._control.txt_1.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_2.text.text = var_0_2:getNowLang("questgo")

				self._item_list[1]:SetActive(true)
				self._item_list[2]:SetActive(true)

				self._item_list[1].title_1.text.text = self:__init_access_language(var_5_0[1])
				self._item_list[2].title_2.text.text = self:__init_access_language(var_5_0[2])

				if var_5_0[1] == 5 then
					self._item_list[1].next_btn_1:SetActive(false)
				elseif var_5_0[2] == 5 then
					self._item_list[2].next_btn_2:SetActive(false)
				end
			elseif #var_5_0 == 3 then
				self._item_list[1].next_btn_1:SetActive(true)
				self._item_list[2].next_btn_2:SetActive(true)
				self._item_list[3].next_btn_3:SetActive(true)

				self._control.txt_1.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_2.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_3.text.text = var_0_2:getNowLang("questgo")

				self._item_list[1]:SetActive(true)
				self._item_list[2]:SetActive(true)
				self._item_list[3]:SetActive(true)

				self._item_list[1].title_1.text.text = self:__init_access_language(var_5_0[1])
				self._item_list[2].title_2.text.text = self:__init_access_language(var_5_0[2])
				self._item_list[3].title_3.text.text = self:__init_access_language(var_5_0[3])

				if var_5_0[1] == 5 then
					self._item_list[1].next_btn_1:SetActive(false)
				elseif var_5_0[2] == 5 then
					self._item_list[2].next_btn_2:SetActive(false)
				elseif var_5_0[3] == 5 then
					self._item_list[3].next_btn_3:SetActive(false)
				end
			elseif #var_5_0 == 4 then
				self._item_list[1].next_btn_1:SetActive(true)
				self._item_list[2].next_btn_2:SetActive(true)
				self._item_list[3].next_btn_3:SetActive(true)
				self._item_list[4].next_btn_4:SetActive(true)

				self._control.txt_1.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_2.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_3.text.text = var_0_2:getNowLang("questgo")
				self._control.txt_4.text.text = var_0_2:getNowLang("questgo")

				self._item_list[1]:SetActive(true)
				self._item_list[2]:SetActive(true)
				self._item_list[3]:SetActive(true)
				self._item_list[4]:SetActive(true)

				self._item_list[1].title_1.text.text = self:__init_access_language(var_5_0[1])
				self._item_list[2].title_2.text.text = self:__init_access_language(var_5_0[2])
				self._item_list[3].title_3.text.text = self:__init_access_language(var_5_0[3])
				self._item_list[4].title_4.text.text = self:__init_access_language(var_5_0[4])

				if var_5_0[1] == 5 then
					self._item_list[1].next_btn_1:SetActive(false)
				elseif var_5_0[2] == 5 then
					self._item_list[2].next_btn_2:SetActive(false)
				elseif var_5_0[3] == 5 then
					self._item_list[3].next_btn_3:SetActive(false)
				elseif var_5_0[4] == 5 then
					self._item_list[4].next_btn_4:SetActive(false)
				end
			end
		end
	end

	function arg_1_0.__init_access_language(arg_6_0, arg_6_1)
		if not arg_6_1 then
			return
		end

		local var_6_0

		if arg_6_1 == 1 then
			var_6_0 = var_0_2:getNowLang("access_1")
		elseif arg_6_1 == 2 then
			var_6_0 = var_0_2:getNowLang("access_2")
		elseif arg_6_1 == 3 then
			var_6_0 = var_0_2:getNowLang("access_3")
		elseif arg_6_1 == 4 then
			var_6_0 = var_0_2:getNowLang("access_4")
		elseif arg_6_1 == 5 then
			var_6_0 = var_0_2:getNowLang("access_5")
		elseif arg_6_1 == 6 then
			var_6_0 = var_0_2:getNowLang("access_6")
		elseif arg_6_1 == 7 then
			var_6_0 = var_0_2:getNowLang("access_7")
		elseif arg_6_1 == 8 then
			var_6_0 = var_0_2:getNowLang("access_8")
		elseif arg_6_1 == 9 then
			var_6_0 = var_0_2:getNowLang("access_9")
		elseif arg_6_1 == 10 then
			var_6_0 = var_0_2:getNowLang("access_10")
		elseif arg_6_1 == 11 then
			var_6_0 = var_0_2:getNowLang("access_11")
		end

		return var_6_0
	end

	function arg_1_0.__init_click_data(arg_7_0, arg_7_1)
		if not arg_7_1 then
			return
		end

		if arg_7_1 == 1 then
			var_0_1:createInstance("dock"):show(true)
		elseif arg_7_1 == 2 then
			var_0_1:createInstance("gotofight"):show({
				init_map_index = 1,
				is_open_init = true,
				init_chapter_index = 1,
				toggle_index = var_0_3.fight_type.gotofight
			})
		elseif arg_7_1 == 3 then
			var_0_1:createInstance("six_year_main_interface"):show()
		elseif arg_7_1 == 4 then
			var_0_1:createInstance("task"):show()
		elseif arg_7_1 == 5 then
			-- block empty
		elseif arg_7_1 == 6 then
			var_0_1:createInstance("firsttopup"):show()
		elseif arg_7_1 == 7 then
			var_0_1:createInstance("research_bureau"):show()
		elseif arg_7_1 == 8 then
			var_0_1:createInstance("bootyshop"):show()
		elseif arg_7_1 == 9 then
			var_0_1:createInstance("upgradeawards"):show()
		elseif arg_7_1 == 10 then
			var_0_1:createInstance("gotofight"):show({
				init_map_index = 1,
				is_open_init = true,
				init_chapter_index = 1,
				toggle_index = var_0_3.fight_type.gotofight
			})
		elseif arg_7_1 == 11 then
			local var_7_0 = var_0_1:createInstance("remake")

			var_7_0:show(true)
			var_7_0:__select_one("evo")

			var_7_0._control.top.toggle_control.evo.toggle.isOn = true
			var_7_0._cur_type = var_0_3.enter_select_member_type.evo
		end
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_10_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_11_0)
	local var_11_0 = var_0_1:class("msgbox_map")

	var_11_0._data_access = nil
	var_11_0._item_list_1 = nil
	var_11_0._item_list_2 = nil
	var_11_0._item_list_3 = nil
	arg_11_0._now_label = nil

	var_11_0:__initia_lize()

	return var_11_0
end

return var_0_0
