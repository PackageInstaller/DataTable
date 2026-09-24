local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gamecore.util_func

gamecore.UILoader:define("single_buff_cell", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._data = arg_2_1
		self._index = arg_2_2

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._control.buff_name.text.text = arg_3_1.title
		self._control.buff_info.text.text = var_0_6.convert_rich_text(self._data.desc2)
		self._control.buff_icon.image.sprite = self:loadSprite(var_0_5(var_0_4.tactical_buff_icon, arg_3_1.icon))
		self._control.buff_icon_bg.image.sprite = self:loadSprite(var_0_5(var_0_4.tower_buff_optimize_icon, (arg_3_1.quality == 4 or nil) and "2"))

		if arg_3_1.buff_state then
			if arg_3_1.buff_state == var_0_4.buffmap_buff_state.have then
				self._control.get_buff_btn:SetActive(false)

				self._control.has_buff_bg.has_buff_txt.text.text = var_0_1:getNowLang("ui_tower_buff_status_2")
			elseif arg_3_1.buff_state == var_0_4.buffmap_buff_state.not_have then
				self._control.get_buff_btn:SetActive(true)

				self._control.get_buff_btn.get_buff_txt.text.text = arg_3_1.price
			elseif arg_3_1.buff_state == var_0_4.buffmap_buff_state.cant_have then
				self._control.get_buff_btn:SetActive(false)

				self._control.has_buff_bg.has_buff_txt.text.text = var_0_1:getNowLang("ui_tower_buff_status_2")
			end
		else
			print("此处传递的参数没有设置buff状态！id-->" .. arg_3_1.id)
		end
	end

	function arg_1_0:__purchange_btn_click()
		self._data.is_buff_map = true

		var_0_2:getInstance("buffmap"):__purchange_msg_box(self._data)
	end

	function arg_1_0:__update_info(arg_5_1)
		self._control.info_transform:SetActive(true)
	end

	function arg_1_0:__select_cur_buff()
		self._control.select_bg:SetActive(true)

		self._data.select_status = true

		local var_6_0 = var_0_2:getInstance("buffmap")

		if var_6_0 then
			var_6_0:close_map_select(self._index + 1)
			var_6_0:show_mask(true, self._panel.transform)
		end

		self:__update_info()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("single_buff_cell")

	var_7_0._data = nil
	var_7_0._index = nil

	return var_7_0
end

return var_0_0
