local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_6 = gameconfig.equip_config
local var_0_7 = table.insert
local var_0_8 = {
	gamecore.Language:getNowLang("range1"),
	gamecore.Language:getNowLang("range2"),
	gamecore.Language:getNowLang("range3"),
	gamecore.Language:getNowLang("range4")
}

gamecore.UILoader:define("equip_datail", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._goto_type = arg_2_1

		self:__init_panel(arg_2_2)
	end

	function arg_1_0:set_attr(arg_3_1, arg_3_2)
		for iter_3_0 = 1, arg_3_1.transform.childCount do
			arg_3_1.transform:GetChild(iter_3_0 - 1).gameObject:SetActive(false)
		end

		for iter_3_1, iter_3_2 in ipairs((self:get_equip_attr(arg_3_2.cid))) do
			if iter_3_1 > 8 then
				return
			end

			arg_3_1.transform:GetChild(iter_3_1 - 1):Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.equip_attr, iter_3_2.type))
			arg_3_1.transform:GetChild(iter_3_1 - 1):Find("type"):GetComponent("Text").text = var_0_1:getNowLang(iter_3_2.type)
			arg_3_1.transform:GetChild(iter_3_1 - 1):Find("num"):GetComponent("Text").text = self:get_attr_str(iter_3_2.type, iter_3_2.sum, false)

			arg_3_1.transform:GetChild(iter_3_1 - 1).gameObject:SetActive(true)
		end
	end

	function arg_1_0:show_equip_detail(arg_4_1)
		local var_4_0 = var_0_6.find_object_by_cid(arg_4_1)

		self._control.bg.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.cardbook_const.equip_bg, var_4_0.star))
		self._control.equip_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.equip_icon.equip, var_4_0.pic_id))
		self._control.equip_info.attr_bg.id_txt.text.text = "NO." .. var_4_0.pic_id
		self._control.equip_info.attr_bg.type_txt.text.text = var_4_0.equip_desc
		self._control.equip_info.attr_bg.name_bg.name_txt.text.text = var_4_0.title

		self:set_attr(self._control.equip_info.attr_bg.attr_list, var_4_0)

		self._control.equip_info.attr_bg.scrollview.content.info_txt.text.text = var_4_0.desc
		self._control.equip_info.intro_bg.desc.text.text = var_0_1:getNowLang("equipdesc")
		self._control.equip_info.intro_bg.scrollview.content.info_txt.text.text = var_4_0.desc2
	end

	function arg_1_0.get_equip_attr(arg_5_0, arg_5_1)
		local var_5_0 = {}
		local var_5_1 = var_0_6.find_object_by_cid(arg_5_1)

		if var_5_1.hp ~= 0 then
			var_0_7(var_5_0, {
				type = "hp",
				sum = var_5_1.hp
			})
		end

		if var_5_1.atk ~= 0 then
			var_0_7(var_5_0, {
				type = "atk",
				sum = var_5_1.atk
			})
		end

		if var_5_1.torpedo ~= 0 then
			var_0_7(var_5_0, {
				type = "torpedo",
				sum = var_5_1.torpedo
			})
		end

		if var_5_1.def ~= 0 then
			var_0_7(var_5_0, {
				type = "def",
				sum = var_5_1.def
			})
		end

		if var_5_1.air_def ~= 0 then
			var_0_7(var_5_0, {
				type = "airdef",
				sum = var_5_1.air_def
			})
		end

		if var_5_1.aircraft_atk ~= 0 then
			var_0_7(var_5_0, {
				type = "aircraftatk",
				sum = var_5_1.aircraft_atk
			})
		end

		if var_5_1.radar ~= 0 then
			var_0_7(var_5_0, {
				type = "radar",
				sum = var_5_1.radar
			})
		end

		if var_5_1.antisub ~= 0 then
			var_0_7(var_5_0, {
				type = "antisub",
				sum = var_5_1.antisub
			})
		end

		if var_5_1.hit ~= 0 then
			var_0_7(var_5_0, {
				type = "hit",
				sum = var_5_1.hit
			})
		end

		if var_5_1.miss ~= 0 then
			var_0_7(var_5_0, {
				type = "miss",
				sum = var_5_1.miss
			})
		end

		if var_5_1.luck ~= 0 then
			var_0_7(var_5_0, {
				type = "luck",
				sum = var_5_1.luck
			})
		end

		if var_5_1.range ~= 0 then
			var_0_7(var_5_0, {
				type = "range",
				sum = var_5_1.range
			})
		end

		if var_5_1.missile_hit ~= 0 then
			var_0_7(var_5_0, {
				type = "missilehit",
				sum = var_5_1.missile_hit
			})
		end

		if var_5_1.missile_tmd ~= 0 then
			var_0_7(var_5_0, {
				type = "missiletmd",
				sum = var_5_1.missile_tmd
			})
		end

		return var_5_0
	end

	function arg_1_0.get_attr_str(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		return arg_6_1 == "range" and var_0_8[arg_6_2] or arg_6_3 and (arg_6_2 > 0 and "+" .. arg_6_2 or arg_6_2) or arg_6_2
	end

	function arg_1_0:get_new_equip_list(arg_7_1)
		if arg_7_1 and next(arg_7_1) then
			for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
				if var_0_6.find_object_by_cid(iter_7_1).handbook_type == 1 then
					var_0_7(self._new_equip_list, var_0_6.find_object_by_cid(iter_7_1))
				end
			end
		else
			for iter_7_2, iter_7_3 in ipairs((var_0_3:get_cardbook_equip_list())) do
				if var_0_6.find_object_by_cid(iter_7_3).handbook_type == 1 then
					var_0_7(self._new_equip_list, var_0_6.find_object_by_cid(iter_7_3))
				end
			end
		end
	end

	function arg_1_0:show_btns(arg_8_1)
		local var_8_0 = #self._sort_new_equip_list
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in ipairs(self._sort_new_equip_list) do
			if iter_8_1.cid == arg_8_1 then
				var_8_1 = iter_8_0
			end
		end

		self._control.last_btn:SetActive(var_8_1 > 1)
		self._control.next_btn:SetActive(var_8_1 < var_8_0)

		self._now_equip_index = var_8_1
	end

	function arg_1_0:__init_panel(arg_9_1)
		local var_9_0 = var_0_2:getInstance("equip_map")

		if var_9_0 then
			self._new_equip_list = {}
			self._sort_new_equip_list = {}

			self:get_new_equip_list()

			self._sort_new_equip_list = var_9_0._filter_name and var_9_0:get_filter_table_name() or var_9_0:get_new_equip_list(self._new_equip_list)

			self:show_equip_detail(var_9_0._now_click_equip_data.cid)
			self:show_btns(var_9_0._now_click_equip_data.cid)

			self._is_already_init = true
		else
			self._new_equip_list = {}
			self._sort_new_equip_list = {}

			self:show_equip_detail(arg_9_1.cid)
			self:show_btns(arg_9_1.cid)

			self._is_already_init = true
		end
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	function arg_1_0.__onReset(arg_11_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("equip_datail")

	var_12_0._is_already_init = false
	var_12_0._new_equip_list = {}
	var_12_0._sort_new_equip_list = {}
	var_12_0._now_equip_index = 0
	var_12_0._goto_type = 0

	gamecore.extend_obj(var_12_0)

	return var_12_0
end

return var_0_0
