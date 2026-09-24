local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_8 = string.format

gamecore.UILoader:define("single_supportcell", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._index = arg_2_2

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:_play_into_se(arg_3_1)
		self:playSE(arg_3_1, false)
	end

	function arg_1_0:__init_panel(arg_4_1)
		self._data = arg_4_1

		self:__update_info_cell(arg_4_1)
	end

	function arg_1_0:__update_info_cell(arg_5_1)
		local var_5_0 = var_0_1:get_support_rank_read(arg_5_1.id) or false
		local var_5_1, var_5_2, var_5_3 = var_0_1:get_support_notify()
		local var_5_4 = var_5_3 >= arg_5_1.need_achievement
		local var_5_5 = var_0_3:getInstance("supportlist")

		self._control.new_icon.new_text.text.text = var_0_2:getNowLang("new")

		self._control.new_icon:SetActive(var_5_4 and not var_5_0)
		self._control.select_bg:SetActive(arg_5_1.select_status)

		if var_5_1 and var_5_1 == arg_5_1.id then
			self._control.battle_image:SetActive(true)
			self._control.battle_text:SetActive(true)
		else
			self._control.battle_image:SetActive(false)
			self._control.battle_text:SetActive(false)
		end

		self._control.bg.image.sprite = self:loadSprite(var_0_8(var_0_4.s_card_bg, arg_5_1.quality))
		self._control.bg.image.material = not var_5_4 and self:loadMaterial(var_0_4.common_icon.furniture_gray_material) or nil
		self._control.icon.image.material = not var_5_4 and self:loadMaterial(var_0_4.common_icon.furniture_gray_material) or nil
		self._control.info_text.text.text = arg_5_1.title
		self._control.icon.image.sprite = self:loadSprite(var_0_8(var_0_4.support_icon_list.support_s_icon, arg_5_1.id))
		self._control.battle_text.text.text = var_0_2:getNowLang("ui_support_card_status_3")
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_3:class("single_supportcell")

	var_6_0._data = nil
	var_6_0._select_index = nil

	return var_6_0
end

return var_0_0
