local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = table.remove
local var_0_6 = gameenum.common_type
local var_0_8 = gameconfig.ship_config
local var_0_10 = gameconfig.equip_config
local var_0_11 = gameconfig.chat_head_config

gamecore.UILoader:define("mail_box", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)

		self._reward_data = arg_2_1

		if arg_2_2 then
			self._enter_type = arg_2_2
		end

		if arg_2_3 then
			self._func = arg_2_3
		end

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		if not self._already_init then
			self._control.main.title.text.text = var_0_1:getNowLang("logget")
			self._control.main.confirm.text.text.text = var_0_1:getNowLang("ui_cbtn1")

			self:__init_item_reward_list()

			self._already_init = true
		end

		self:__reset_item_cell_state()
		self:__init_mail_data_list()
		self:check_show_way()
		self:__check_layer()
	end

	function arg_1_0:check_show_way()
		self:setVisible(self._is_have_normal_item)

		if not self._is_have_normal_item then
			self:__show_special_item_detail()
		end
	end

	function arg_1_0:__check_layer()
		local var_5_0 = var_0_2:getInstance("strike_awardbox")
		local var_5_1 = var_0_2:getInstance("mist_awardbox")

		if var_5_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_5_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		if var_5_1 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_5_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:__init_item_reward_list()
		for iter_6_0 = 1, #self._reward_data do
			local var_6_0, var_6_1 = self:loadUIPrefab("mail_reward_item", self._control.main_item.scrollview.viewport.content.transform)

			self._reward_control_list[#self._reward_control_list + 1] = {
				obj = var_6_0,
				control = var_6_1
			}
		end
	end

	function arg_1_0:__init_mail_data_list()
		local var_7_0 = var_0_2:getInstance("mail")

		if var_7_0 then
			self:__init_reward_data_list((var_7_0:get_curr_select_mail_award()))
		else
			self:__init_reward_data_list(self._reward_data)
		end
	end

	function arg_1_0:show_awards_enter_from_other_ways(arg_8_1, arg_8_2)
		self._reward_data = arg_8_1

		if arg_8_2 then
			self._enter_type = arg_8_2
		end

		self._control.main.title.text.text = var_0_1:getNowLang("logget")
		self._control.main.confirm.text.text.text = var_0_1:getNowLang("ui_cbtn1")

		self:__init_item_reward_list()
		self:__reset_item_cell_state()
		self:__init_reward_data_list(arg_8_1)
		self:check_show_way()
	end

	function arg_1_0:__init_reward_data_list(arg_9_1)
		if not arg_9_1 then
			return
		end

		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			var_9_0 = var_9_0 + 1

			if self._enter_type ~= var_0_6.enter_get_ship_type.present_exchange and var_9_0 > var_0_6.mail_const.mail_show_props_max_num then
				return
			end

			if iter_9_1.type ~= var_0_6.reward_type.equipment and iter_9_1.type ~= var_0_6.reward_type.ship_skin and iter_9_1.type ~= var_0_6.reward_type.ship and iter_9_1.type ~= var_0_6.reward_type.head_icon and self._reward_control_list[iter_9_0] then
				local var_9_1 = self._reward_control_list[iter_9_0].control

				self._reward_control_list[iter_9_0].obj:setVisible(true)

				local var_9_2, var_9_3, var_9_4 = var_0_6:get_image_path_by_type(iter_9_1.id, iter_9_1.type, iter_9_1.count, true)

				var_9_1.mask.reward.image.sprite = self:loadSprite((var_9_4 or nil) and var_9_4)

				var_9_1.mask.reward.image:SetNativeSize()

				var_9_1.rewardbg.image.sprite = iter_9_1.type == var_0_6.reward_type.abyss_ship and self:loadSprite(tonumber(var_0_8.find_abyss_object_by_cid(iter_9_1.id).boss) == 0 and var_0_6.abyss_mail_ground_1 or var_0_6.abyss_mail_ground_2) or self:loadSprite(var_0_6.normal_mail_ground)
				var_9_1.number.text.text = ""

				if iter_9_1.count ~= 1 then
					var_9_1.number.text.text = iter_9_1.count
				end

				local var_9_6 = var_9_1.reward_des:GetComponent("TextHorizonScroller")

				var_9_6:SetText(var_9_3)

				var_9_6.deltaLength = var_0_6.mail_const.text_interval
				var_9_6.scrollSpeed = var_0_6.mail_const.text_move_speed
				self._is_have_normal_item = true
			end
		end
	end

	function arg_1_0:__reset_item_cell_state()
		for iter_10_0, iter_10_1 in pairs(self._reward_control_list) do
			iter_10_1.obj:setVisible(false)
		end

		self._is_have_normal_item = false
	end

	function arg_1_0:__show_special_item_detail()
		if self._reward_data and next(self._reward_data) then
			for iter_11_0, iter_11_1 in pairs(self._reward_data) do
				if iter_11_1.type == var_0_6.reward_type.equipment then
					self:__show_equip_detail_info(iter_11_1)
					var_0_4(self._reward_data, iter_11_0)

					return
				elseif iter_11_1.type == var_0_6.reward_type.ship_skin then
					self:__show_ship_skin_detail_info(iter_11_1)
					var_0_4(self._reward_data, iter_11_0)

					return
				elseif iter_11_1.type == var_0_6.reward_type.ship then
					self:__show_ship_detail_info(iter_11_1)
					var_0_4(self._reward_data, iter_11_0)

					return
				elseif iter_11_1.type == var_0_6.reward_type.head_icon then
					self:__show_new_head_detail_info(iter_11_1)
					var_0_4(self._reward_data, iter_11_0)

					return
				end
			end
		end
	end

	function arg_1_0.__show_equip_detail_info(arg_12_0, arg_12_1)
		var_0_2:createInstance("new_ship_or_equip"):show(true, {
			type = arg_12_1.type,
			count = arg_12_1.count,
			id = var_0_10.find_object_by_cid(arg_12_1.id).cid,
			is_new = arg_12_1.is_new
		}, var_0_6.enter_get_ship_type.spoils_shop, function()
			arg_12_0:__show_special_item_detail()
		end)
	end

	function arg_1_0:__show_ship_skin_detail_info(arg_14_1)
		local var_14_0 = var_0_2:createInstance("reward_tip")

		if self._enter_type == var_0_6.enter_get_ship_type.present_exchange then
			var_14_0:show_by_enter_type(arg_14_1.id, var_0_6.enter_get_ship_type.mail_skin_award, function()
				self:__show_special_item_detail()
			end)
		else
			var_14_0:show_by_enter_type(arg_14_1.id, var_0_6.enter_get_ship_type.mail_skin_award, function()
				self:__show_special_item_detail()
			end)
		end
	end

	function arg_1_0.__show_ship_detail_info(arg_17_0, arg_17_1)
		var_0_2:createInstance("new_ship_or_equip"):show(true, {
			type = arg_17_1.type,
			count = arg_17_1.count,
			id = arg_17_1.id,
			is_new = arg_17_1.is_new
		}, var_0_6.enter_get_ship_type.mail_ship_award, function()
			arg_17_0:__show_special_item_detail()
		end)
	end

	function arg_1_0.__show_new_head_detail_info(arg_19_0, arg_19_1)
		var_0_2:createInstance("reward_tip"):show_by_enter_type(var_0_11.find_object_by_cid(arg_19_1.id).icon, var_0_6.enter_get_ship_type.mail_new_head_award, function()
			arg_19_0:__show_special_item_detail()
		end)
	end

	function arg_1_0:_play_into_se(arg_21_1)
		self:playSE(arg_21_1, false)
	end

	function arg_1_0.__onReset(arg_22_0)
		arg_22_0._already_init = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_23_0)
	local var_23_0 = var_0_2:class("mail_box")

	var_23_0._already_init = false
	var_23_0._reward_data = {}
	var_23_0._reward_control_list = {}
	var_23_0._is_have_normal_item = false

	return var_23_0
end

return var_0_0
