local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.util_func
local var_0_5 = gameconfig.pve_ocean_cia_config

gamecore.UILoader:define("ocean_buff_cell", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._index = arg_2_1

		self:__init_panel(arg_2_2)
	end

	function arg_1_0:__init_panel(arg_3_1)
		if not arg_3_1.config then
			self._data = var_0_5.find_object_by_id(arg_3_1.id)

			print("可能那边除了点问题")
		else
			self._data = arg_3_1.config
		end

		if self._data then
			self._control.detail_txt.text.text = var_0_4.convert_rich_text(self._data.desc)
			self._control.sign_bg.image.sprite = not arg_3_1.is_debuff and self:loadSprite("data/ui/4th_event/main/icon_info_" .. "1.png") or arg_3_1.is_unlocked_debuff and self:loadSprite("data/ui/4th_event/main/icon_info_" .. "2.png") or self:loadSprite("data/ui/4th_event/main/icon_info_" .. "3.png")
		else
			self._control.detail_txt.text.text = "？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？此时胡德打出了小问号"
		end
	end

	function arg_1_0:__show_detailed_info()
		local var_4_0 = var_0_3:getInstance("fight_prepare")

		if var_4_0 then
			var_4_0:show_ocean_buff_cell_detailed_info({
				pos = self._panel.transform.position,
				config = self._data
			})
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_3:class("ocean_buff_cell"))
end

return var_0_0
