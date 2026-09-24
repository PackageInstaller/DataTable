local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = string.format
local var_0_4 = gameenum.common_type

gamecore.UILoader:define("tactics_detail", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		self:__init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1, arg_3_2)
		if not next(self.is_have_card_list) then
			self._tactics_collection = var_0_2:getInstance("tactics_collection")
			self.is_have_card_list = self._tactics_collection._card_data
		end

		self._max_card_index = #self.is_have_card_list

		self:__init_title_name()

		if arg_3_1 == nil then
			arg_3_1 = self._tactics_collection:get_buff_card_by_buff_id(self.is_have_card_list[arg_3_2])
		end

		self._now_sort = self:get_now_sort(arg_3_1.buff_id)

		self:__set_data(arg_3_1)

		self._data = arg_3_1
	end

	function arg_1_0:__init_title_name()
		if self._already_init then
			return
		end

		self._control.tactics_bg.title.title_txt.text.text = var_0_1:getNowLang("card_detail")
		self._control.tactics_bg.center.card_lable.text.text = var_0_1:getNowLang("card_name")
		self._control.tactics_bg.center.attr_lable.text.text = var_0_1:getNowLang("card_attribute")
		self._control.tactics_bg.center.desc_lable.text.text = var_0_1:getNowLang("shipdesctitle")
		self._already_init = true
	end

	function arg_1_0:__set_data(arg_5_1)
		self._control.tactics_bg.center.card_lable.card_title.text.text = arg_5_1.title
		self._control.tactics_bg.center.attr_lable.attr_txt.text.text = var_0_1:convert_rich_text(arg_5_1.effect_desc)
		self._control.tactics_bg.center.desc_lable.desc_txt.text.text = var_0_1:convert_rich_text(arg_5_1.desc)

		self._control.tactics_bg.left_btn:SetActive(self._now_sort ~= 1)
		self._control.tactics_bg.right_btn:SetActive(self._now_sort < self._max_card_index)

		local var_5_0 = var_0_3(var_0_4.tactics_buff, arg_5_1.buff_id)

		self._control.tactics_bg.center.card_border.card_image.image.sprite = self:findPath(var_5_0) and self:loadSprite(var_5_0) or self:loadSprite(var_0_3(var_0_4.tactics_buff, "1"))
	end

	function arg_1_0:get_now_sort(arg_6_1)
		for iter_6_0 = 1, #self.is_have_card_list do
			if self.is_have_card_list[iter_6_0] == arg_6_1 then
				return iter_6_0
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("tactics_detail")

	var_7_0._already_init = false
	var_7_0._data = {}
	var_7_0.is_have_card_list = {}
	var_7_0._max_card_index = 0
	var_7_0._now_sort = 1

	return var_7_0
end

return var_0_0
