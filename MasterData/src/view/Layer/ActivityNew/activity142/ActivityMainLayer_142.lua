local ActivityMainLayer_142 = class("ActivityMainLayer_142", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")

function ActivityMainLayer_142:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_142.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_142:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_142:initOther()
	self:initExploreBnt()
end

function ActivityMainLayer_142:playOutEffect(arg_5_1)
	if arg_5_1 then
		arg_5_1()
	end
end

function ActivityMainLayer_142:playInEffect(arg_6_1)
	if arg_6_1 then
		arg_6_1()
	end
end

function ActivityMainLayer_142:initExploreBnt()
	self.btnExplore:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self:is_open_entrance(k, arg_8_0.activitymodule) then
			return
		end
	end)
	activity_manager:get_activity_explore(self.id, function(arg_9_0)
		print("get_activity_explore>>>>>>>>", dump(arg_9_0))

		if arg_9_0.result == 1 then
			if arg_9_0.finish_step == 0 then
				self.btnExplore:addTouchEventListener(function(arg_10_0, arg_10_1)
					if arg_10_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self:is_open_entrance("btnExplore", arg_10_0.activitymodule) then
						return
					end

					self:gotoExplore(1)
				end)
			else
				self.btnExplore:addTouchEventListener(function(arg_11_0, arg_11_1)
					if arg_11_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self:is_open_entrance("btnExplore", arg_11_0.activitymodule) then
						return
					end

					self:gotoExplore(2)
				end)

				if arg_9_0.total_daily_times == 0 then
					self.btnExplore:getChildByName("reddot"):setVisible(true)
				end
			end
		end
	end)
end

function ActivityMainLayer_142:gotoExplore(arg_12_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityMainLayer_142",
		activity_explore_id = arg_12_1,
		activityid = self.id,
		cancelCallback = function(arg_13_0)
			if arg_13_0 == 2 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
			elseif arg_13_0 == 3 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
			elseif arg_13_0 == 4 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
			elseif arg_13_0 == 5 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
			elseif arg_13_0 == 0 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
			elseif arg_13_0 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_13_0])
			end
		end
	})
end

return ActivityMainLayer_142
