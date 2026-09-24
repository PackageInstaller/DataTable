local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.tower_buff_stone_config
local var_0_6 = string.format
local var_0_7 = gamecore.util_func

gamecore.UILoader:define("machine_buff", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self:setVisible(true)

		self._cur_index = arg_2_2
		self._card_status = arg_2_3

		self:__init_panel(arg_2_1, arg_2_4, arg_2_5, arg_2_6)
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self._buff_id = arg_3_1

		self:set_buff_info(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	end

	function arg_1_0:set_buff_info(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		local var_4_0 = var_0_5.find_object_by_id(arg_4_1)

		if arg_4_1 and arg_4_1 ~= 0 then
			self._cur_buff_config = var_4_0
			self._control.bg.buff_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.tactical_buff_icon, var_4_0.icon))
			self._control.bg.buff_name.text.text = var_4_0.title
			self._control.bg.buff_info.text.text = var_0_7.convert_rich_text(var_4_0.desc1)

			self._control.bg:SetActive(true)

			self._control.bg.image.sprite = self:loadSprite(var_0_6(var_0_4.tactical_buff_icon, "bg_3_" .. ((var_4_0.quality and var_4_0.quality == 4 or nil) and "2")))

			if not arg_4_3 and not arg_4_2 then
				self._control.bg.replace_btn:SetActive(false)
			else
				self._control.bg.replace_btn:SetActive(true)
			end
		else
			local var_4_2

			if self._card_status == var_0_4.card_status.card_none_new then
				self._control.single_bg.equip_btn:SetActive(true)

				var_4_2 = var_0_1:getNowLang("card_get")
			elseif self._card_status == var_0_4.card_status.card_equips or self._card_status == var_0_4.card_status.card_give_up then
				self._control.single_bg.equip_btn:SetActive(true)

				var_4_2 = var_0_1:getNowLang("ui_tower_buff_equip")
			else
				self._control.single_bg.equip_btn:SetActive(false)

				var_4_2 = ""
			end

			self._control.single_bg.equip_text.text.text = var_4_2

			self._control.bg:SetActive(false)
		end

		if self._card_status == var_0_4.card_status.card_replace and var_4_0 and var_4_0.base_id then
			self._control.bg.replace_btn:SetActive(arg_4_4 == var_4_0.base_id)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_2:class("machine_buff")

	var_5_0._buff_id = nil
	var_5_0._cur_index = nil
	var_5_0._card_status = nil

	return var_5_0
end

return var_0_0
