local var_0_0 = {}
local var_0_1 = string.format
local var_0_2 = table.insert
local var_0_4 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.ship_pve_active_config

gamecore.UILoader:define("active_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:update_cell()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:__init_panel()
		self:__init_active_list()
	end

	function arg_1_0:__init_active_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.all_active.Viewport.edge_mask.Content.endlessScrollView, self._control.all_active.Viewport.edge_mask.Content, "active_cell", "active_info", true)

		self._reusable_cell:init()
		self:__init_active_data()
	end

	function arg_1_0:__init_active_data()
		self.acticity = {}

		for iter_6_0, iter_6_1 in pairs((var_0_6.get_sequence())) do
			if iter_6_1.type == 13 and iter_6_1.id == 47 then
				var_0_2(self.acticity, iter_6_1)
			end
		end

		self._reusable_cell:set_data(self.acticity)

		function self._reusable_cell:_set_func(arg_7_1)
			self._control.pic_icon.image.sprite = self:loadSprite(var_0_1(var_0_5.main_activity_image_list, self.acticity[arg_7_1 + 1].pic))
		end
	end

	function arg_1_0.get_acticity_time(arg_8_0, arg_8_1)
		if arg_8_1.start_time == 0 or arg_8_1.end_time == 0 then
			return false
		end

		if lx.Time:diffGMTDateString(lx.Time:getGMTDateString(arg_8_1.start_time)) > 0 and lx.Time:diffGMTDateString(lx.Time:getGMTDateString(arg_8_1.end_time)) < 0 then
			return true
		end

		return false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_4:class("active_info")

	var_9_0._reusable_cell = nil

	gamecore.extend_obj(var_9_0)

	return var_9_0
end

return var_0_0
