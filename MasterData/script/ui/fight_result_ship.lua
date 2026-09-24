local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_8 = gamecore.util_func

gamecore.UILoader:define("fight_result_ship", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		local var_3_0 = var_0_3:find_character_by_id(arg_3_1.ship_id)
		local var_3_1 = var_0_6.find_object_by_cid(var_3_0.cid)

		self._control.ship_flag.image.enabled = false

		if arg_3_1.index == 1 then
			self._control.ship_flag.image.enabled = true
		end

		self._control.ship_name.ship_name_1.text.text = var_3_0.name

		self._control.ship_name:GetComponent("TextHorizonScroller"):SetText(var_3_0.name)

		self._control.ship.ship_bg.image.sprite = self:loadSprite(var_0_4.ship_attrib_bg[var_3_0.star])

		local var_3_2
		local var_3_3 = var_0_8:use_big_break_painting(var_3_0, var_0_4.ship_icon_type.model_s, true)

		if var_3_0.skin ~= 0 then
			local var_3_4 = var_0_7.find_object_by_cid(var_3_0.skin).icon

			var_3_2 = var_0_4:get_ship_icon(var_3_3, var_3_4, var_3_4)
		else
			var_3_2 = var_0_4:get_ship_icon(var_3_3, var_3_1.pic_id, tostring(var_3_1.pic_id))
		end

		self._control.ship.ship_icon.image.sprite = self:loadSprite(var_3_2)
		self._control.ship_level.level_num.text.text = var_0_5("Lv.%d", var_3_0.level)
		self._control.ship_type.type_name.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_3_1.type, 1))
		self._control.ship_hp.hp_bar.image.fillAmount = var_3_0.now_hp / var_3_0.hp
		self._control.ship_hp.hp_bar.image.sprite = var_3_0.now_hp / var_3_0.hp >= 0.5 and self:loadSprite(var_0_4.battle_settlement_hp_normal) or var_3_0.now_hp / var_3_0.hp < 0.5 and var_3_0.now_hp / var_3_0.hp >= 0.25 and self:loadSprite(var_0_4.battle_settlement_hp_mid) or self:loadSprite(var_0_4.battle_settlement_hp_low)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_4_0)
	return (var_0_2:class("fight_result_ship"))
end

return var_0_0
