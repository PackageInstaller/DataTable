local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = gameenum.common_type
local var_0_8 = lx.Time
local var_0_9 = gameconfig.ship_medal_config
local var_0_10 = UnityEngine.Vector3
local var_0_11 = table.sort
local var_0_12 = {
	tog_medal = "tog_medal",
	tog_detail = "tog_detail",
	tog_record = "tog_record"
}

gamecore.UILoader:define("achievement", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel()
		self:__show_infos(arg_2_1)
	end

	function arg_1_0:__init_panel()
		self:__init_title_name()
		self:__init_select()

		local var_3_0 = var_0_2:getInstance("ship_detail")

		if var_3_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_3_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		var_0_6:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_title_name()
		if self._already_init then
			return
		end

		self._control.content.title.text.text = var_0_1:getNowLang("servicerecord")
		self._control.content.record_layer.left.title.text.text = var_0_1:getNowLang("fightrecord")
		self._control.content.record_layer.left.item_1.title.text.text = var_0_1:getNowLang("hurtshipnum")
		self._control.content.record_layer.left.item_2.title.text.text = var_0_1:getNowLang("sinkshipnum")
		self._control.content.record_layer.left.item_3.title.text.text = var_0_1:getNowLang("fightnum")
		self._control.content.record_layer.left.item_4.title.text.text = var_0_1:getNowLang("missnum")
		self._control.content.record_layer.left.item_5.title.text.text = var_0_1:getNowLang("pvpwinnum")
		self._control.content.record_layer.right.title.text.text = var_0_1:getNowLang("repairrecord")
		self._control.content.record_layer.right.item_1.title.text.text = var_0_1:getNowLang("repairnum")
		self._control.content.record_layer.right.item_2.title.text.text = var_0_1:getNowLang("ammonum")
		self._control.content.record_layer.right.item_3.title.text.text = var_0_1:getNowLang("steelnum")
		self._control.content.record_layer.right.item_4.title.text.text = var_0_1:getNowLang("oilnum")
		self._control.content.record_layer.right.item_5.title.text.text = var_0_1:getNowLang("aluminiumnum")
		self._control.content.other_layer.left.title.text.text = var_0_1:getNowLang("gettime")
		self._control.content.other_layer.right.title.text.text = var_0_1:getNowLang("marrytime")
		self._control.content.medal_layer.no_medal.title.text.text = var_0_1:getNowLang("havenomedal")
		self._control.content.toggle_group.tog_detail.title.text.text = var_0_1:getNowLang("logdetail")
		self._control.content.toggle_group.tog_record.title.text.text = var_0_1:getNowLang("logrecord")
		self._control.content.toggle_group.tog_medal.title.text.text = var_0_1:getNowLang("logmedal")
		self._already_init = true
	end

	function arg_1_0:__show_infos(arg_5_1)
		self._control.content.record_layer.left.item_1.num.text.text = arg_5_1.damage
		self._control.content.record_layer.left.item_2.num.text.text = arg_5_1.kills
		self._control.content.record_layer.left.item_3.num.text.text = arg_5_1.battle_count
		self._control.content.record_layer.left.item_4.num.text.text = arg_5_1.miss_attack
		self._control.content.record_layer.left.item_5.num.text.text = arg_5_1.maneuver_win
		self._control.content.record_layer.right.item_1.num.text.text = arg_5_1.repair_count
		self._control.content.record_layer.right.item_2.num.text.text = arg_5_1.consume_bullet
		self._control.content.record_layer.right.item_3.num.text.text = arg_5_1.consume_fe
		self._control.content.record_layer.right.item_4.num.text.text = arg_5_1.consume_oil
		self._control.content.record_layer.right.item_5.num.text.text = arg_5_1.consume_al
		self._control.content.other_layer.left.date.text.text = var_0_8:getDateString(arg_5_1.create_time)
		self._control.content.other_layer.left.item_title.text.text = var_0_4(var_0_1:getNowLang("buildboatnum", true), arg_5_1.build_rare_ship)
		self._control.content.other_layer.right.date.text.text = arg_5_1.marry_time == 0 and "-------" or var_0_8:getDateString(arg_5_1.marry_time)
		self._control.content.medal_layer.title.text.text = ""
		self._control.content.medal_layer.desc.text.text = ""

		self:__destroy_medal_list()
		self:__load_medal_list(arg_5_1.medal or {})
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one("tog_detail")

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_7_1)
		if self._now_label == arg_7_1 then
			return
		end

		self._now_label = arg_7_1

		self:__set_current_content(arg_7_1)
		self:__set_content_active()
	end

	function arg_1_0:__set_current_content(arg_8_1)
		if arg_8_1 == var_0_12.tog_detail then
			self._now_content = self._control.content.toggle_group.tog_detail
		elseif arg_8_1 == var_0_12.tog_record then
			self._now_content = self._control.content.toggle_group.tog_record
		elseif arg_8_1 == var_0_12.tog_medal then
			self._now_content = self._control.content.toggle_group.tog_medal
		end
	end

	function arg_1_0:__set_content_active()
		self._control.content.record_layer:SetActive(self._now_label == var_0_12.tog_detail)
		self._control.content.other_layer:SetActive(self._now_label == var_0_12.tog_record)
		self._control.content.medal_layer:SetActive(self._now_label == var_0_12.tog_medal)
		self._control.content.toggle_group.tog_detail.page:SetActive(self._now_label == var_0_12.tog_detail)
		self._control.content.toggle_group.tog_record.page:SetActive(self._now_label == var_0_12.tog_record)
		self._control.content.toggle_group.tog_medal.page:SetActive(self._now_label == var_0_12.tog_medal)
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:__load_medal_list(arg_11_1)
		local var_11_0 = #arg_11_1 > 0

		self._control.content.medal_layer.scroll:SetActive(#arg_11_1 > 0)
		self._control.content.medal_layer.no_medal:SetActive(not var_11_0)
		var_0_11(arg_11_1, function(arg_12_0, arg_12_1)
			return arg_12_0 < arg_12_1
		end)

		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			local var_11_1 = var_0_9.find_object_by_id(iter_11_1)
			local var_11_2

			if self._medal_list[iter_11_0] then
				var_11_2 = self._medal_list[iter_11_0].control or nil

				local var_11_3

				if self._medal_list[iter_11_0] then
					var_11_3 = self._medal_list[iter_11_0].obj or nil

					if not var_11_2 then
						var_11_3, var_11_2 = self:loadUIPrefab("achievement_cell", self._control.content.medal_layer.scroll.viewport.content.transform)

						var_0_5(self._medal_list, {
							obj = var_11_3,
							control = var_11_2
						})
					end
				end
			end

			var_11_3._panel.transform:GetComponent("RectTransform").localScale = var_0_10.one
			var_11_2.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.achieve_medal_icon.medal_icon, var_11_1.icon))

			var_11_2.select:SetActive(false)
			var_11_3:setVisible(true)
			var_11_2.button.button.onClick:RemoveAllListeners()
			var_11_2.button.button.onClick:AddListener(function()
				self:__select_medal(var_11_2, var_11_1)
			end)
		end
	end

	function arg_1_0:__select_medal(arg_14_1, arg_14_2)
		self._control.content.medal_layer.title.text.text = arg_14_2.title
		self._control.content.medal_layer.desc.text.text = arg_14_2.desc

		if self._last_medal then
			self._last_medal.select:SetActive(false)
		end

		arg_14_1.select.gameObject:SetActive(true)

		self._last_medal = arg_14_1
	end

	function arg_1_0:__destroy_medal_list()
		for iter_15_0, iter_15_1 in pairs(self._medal_list) do
			iter_15_1.control.select:SetActive(false)
			iter_15_1.obj:setVisible(false)
		end
	end

	function arg_1_0:_play_into_se(arg_16_1)
		self:playSE(arg_16_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_17_0)
	local var_17_0 = var_0_2:class("achievement")

	var_17_0._already_init = false
	var_17_0._medal_list = {}
	var_17_0._now_label = nil
	var_17_0._now_content = nil
	var_17_0._last_medal = nil
	var_17_0._data = {}

	return var_17_0
end

return var_0_0
