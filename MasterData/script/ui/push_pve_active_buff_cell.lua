local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = string.format
local var_0_3 = gameenum.common_type
local var_0_4 = gameconfig.pve_active_buff_config

gamecore.UILoader:define("push_pve_active_buff_cell", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._data = arg_2_1.data
		self._config = arg_2_1.config

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.buff_desc:SetActive(false)
		self._control.buff_button:SetActive(false)
		self._control.buff_image.buff_lv:SetActive(false)
		self:__update_buff_info()
	end

	function arg_1_0:__update_buff_info()
		if self._data and next(self._data) then
			local var_4_0 = var_0_4.find_object_by_id(self._data.id).buff_icon

			self._control.buff_bg.image.sprite = self:loadSprite((var_0_2(var_0_3.pve_active_buff_bg_image, self._data.level)))

			self._control.buff_image.buff_lv:SetActive(true)

			self._control.buff_image.buff_lv.text.text = "Lv" .. self._data.level
			self._control.buff_image.image.sprite = self:loadSprite((var_0_2(var_0_3.pve_active_buff_image, self._data.level)))
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_1:class("push_pve_active_buff_cell")

	var_5_0._data = {}
	var_5_0._config = {}

	return var_5_0
end

return var_0_0
