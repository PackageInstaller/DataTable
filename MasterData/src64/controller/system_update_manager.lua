local var_0_0 = {
	quickfight = function()
		local level_manager = require("controller.level_manager")
	end,
	dailytask = function()
		require("controller.task_manager"):reset_on_daily_update(function()
			if LayerManager:getActiveLayerName() == "TaskLayer" then
				local var_3_0 = LayerManager:getActiveLayerObj()

				if var_3_0.updateDailyTaskList then
					var_3_0:updateDailyTaskList()
				end
			end
		end)
	end,
	weeklytask = function()
		require("controller.task_manager"):reset_on_weekly_update(function()
			return
		end)
	end,
	levelmode = function(arg_6_0, arg_6_1)
		return
	end,
	shoptype = function(arg_7_0, arg_7_1)
		return require("controller.shop_manager"):update_active_shoptype(arg_7_0, arg_7_1)
	end,
	markettype = function(arg_8_0, arg_8_1)
		return require("controller.market_manager"):update_active_markettype(markettype, arg_8_1)
	end,
	twisttype = function(...)
		return
	end,
	midas = function()
		AlertManager:register_alert(ALERT_MIDAS)
	end,
	dailytwist = function()
		AlertManager:register_alert(ALERT_TWISTEGG)
	end,
	dailyexpedition = function()
		require("controller.expedition_manager"):updatedaily()
	end,
	dailywarorder = function()
		require("controller.activity_manager"):warorder_daily_update(ACTIVITY_WARORDER_ID)
	end
}

return {
	update = function(arg_14_0, arg_14_1, ...)
		if not var_0_0[arg_14_1] then
			return
		end

		return var_0_0[arg_14_1](...)
	end
}
