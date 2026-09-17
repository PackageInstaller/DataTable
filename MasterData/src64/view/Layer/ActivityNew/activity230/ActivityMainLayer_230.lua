require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_230 = class("ActivityMainLayer_230", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")

function ActivityMainLayer_230:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_230.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_230:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_230:initOther(arg_4_1)
	local var_4_0 = arg_4_1.activityid

	if activity_main_conf[arg_4_1.activityid].bgm then
		SwitchManageLayer:switchLayerBGM(activity_main_conf[arg_4_1.activityid].bgm)
	end

	if self.btnExplore then
		self.btnExplore:addTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			ErrorCodeManager:check({
				systemname = "ActivityExploreLayer",
				id = var_4_0
			})

			if activity_manager:isHasExploreMapLayer(var_4_0) then
				LayerManager:switchShowLayer("ActivityExploreLayer_" .. var_4_0, {
					activityid = var_4_0
				})
			else
				activity_manager:get_activity_explore(var_4_0, function(arg_6_0)
					if arg_6_0.result == 1 then
						explore_manager:begin_explore({
							returnLayer = "ActivityMainLayer_230",
							type = "activity",
							activityid = var_4_0,
							cancelCallback = function(arg_7_0)
								if arg_7_0 == 2 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
								elseif arg_7_0 == 3 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
								elseif arg_7_0 == 4 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
								elseif arg_7_0 == 5 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
								elseif arg_7_0 == 0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
								elseif arg_7_0 then
									global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_7_0])
								end
							end,
							activity_explore_id = activity_manager:getCurExploreId(var_4_0)
						})
					end
				end)
			end
		end)
	end

	if activity_main_conf[arg_4_1.activityid].talk then
		if not RoleDefault:getInstance():getBoolForKey("act_" .. arg_4_1.activityid .. "_story", false) then
			RoleDefault:getInstance():setBoolForKey("act_" .. arg_4_1.activityid .. "_story", true)
			global_basic_scene:addChild(TalkLayer:create(activity_main_conf[arg_4_1.activityid].talk, nil, 1, "", nil))
		end
	end

	self.btnClothes:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSkinAccessLayer")
		AnalyticManager.activityJumpTo({
			module = "PopSkinAccessLayer",
			activityid = 230
		})
	end)
	self.btnDailyLevel:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityDailyLayer_230")
		AnalyticManager.activityJumpTo({
			module = "PopSkinAccessLayer",
			activityid = 230
		})
	end)
	self:addSwitchBtn()
end

local function var_0_13()
	return global_get_time_by_date("2022-01-26 00:00:00") - time_check_manager:getCurTime() >= 0
end

local var_0_14
local var_0_15 = 1
local var_0_16 = 2

function ActivityMainLayer_230:addSwitchBtn()
	var_0_14 = {
		[var_0_15] = {
			modelid = "104090",
			btns = {
				self.btnShop,
				self.btnDailyLevel,
				self.btnTotalTask,
				self.btnFlop,
				self.btnMultipt,
				self.btnBp,
				self.btnRoulette,
				self.btnRecharge,
				self.btnTwist
			}
		},
		[var_0_16] = {
			modelid = "104290",
			btns = {
				self.btnShop,
				self.btnDailyLevel,
				self.btnCollect,
				self.btnArt,
				self.btnPt,
				self.btnRecharge,
				self.btnTwist2
			}
		}
	}
	self.switchType = RoleDefault:getInstance():getIntegerForKey("activitymain230", var_0_16)

	local var_11_0 = self._path .. "btn_switch_%d_%s.png"

	self.btnSwitch1 = ccui.Button:create(string.format(self._path .. "btn_switch_%d_%s.png", 1, self.switchType == var_0_15 and "on" or "off"), nil, string.format(self._path .. "btn_switch_%d_%s.png", 1, self.switchType == var_0_15 and "on" or "off"))

	self.btnSwitch1:setPosition(cc.p(398, 35 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.btnSwitch1)

	self.btnSwitch2 = ccui.Button:create(string.format(var_11_0, 2, self.switchType ~= var_0_15 and "on" or "off"), nil, string.format(var_11_0, 2, self.switchType ~= var_0_15 and "on" or "off"))

	if var_0_13() then
		self.btnSwitch2:loadTextures(self._path .. "btn_switch_lock.png", nil, self._path .. "btn_switch_lock.png")
	end

	self.btnSwitch2:setPosition(cc.p(550, 74 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.btnSwitch2)
	self.btnSwitch1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.switchType == var_0_15 then
			return
		end

		self:switchToType(var_0_15)

		self.switchType = var_0_15

		self.btnSwitch1:loadTextures(string.format(var_11_0, 1, "on"), nil, string.format(var_11_0, 1, "on"))
		self.btnSwitch2:loadTextures(string.format(var_11_0, 2, "off"), nil, string.format(var_11_0, 2, "off"))
		self.btnDetail:loadTextures(self._path .. "btn_detail_1.png", nil, self._path .. "btn_detail_1.png")
		RoleDefault:getInstance():setIntegerForKey("activitymain230", var_0_15)
	end)
	self.btnSwitch2:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.switchType == var_0_16 then
			return
		end

		if var_0_13() then
			return
		end

		self:switchToType(var_0_16)

		self.switchType = var_0_16

		self.btnSwitch1:loadTextures(string.format(var_11_0, 1, "off"), nil, string.format(var_11_0, 1, "off"))
		self.btnSwitch2:loadTextures(string.format(var_11_0, 2, "on"), nil, string.format(var_11_0, 2, "on"))
		self.btnDetail:loadTextures(self._path .. "btn_detail_2.png", nil, self._path .. "btn_detail_2.png")
		RoleDefault:getInstance():setIntegerForKey("activitymain230", var_0_16)
	end)

	self.btnSpringInFo = ccui.Button:create(self._path .. "btn_info.png", nil, self._path .. "btn_info.png")

	self.btnSpringInFo:setPosition(cc.p(590, 850 + GameDisplay.fix_y))
	self.rootLayer:addChild(self.btnSpringInFo)
	self.btnSpringInFo:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSpringInfoLayer")
	end)

	self.btnDailyRecharge = ccui.Button:create(self._path .. "btn_dailyrecharge.png", nil, self._path .. "btn_dailyrecharge.png")

	self.btnDailyRecharge:setPosition(cc.p(590, 230 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.btnDailyRecharge)
	table.insert(var_0_14[var_0_16].btns, self.btnDailyRecharge)
	self.btnDailyRecharge:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDailyRechargeLayer", {
			activityid = 230
		})
	end)

	for iter_11_0, iter_11_1 in pairs(var_0_14[(self.switchType == var_0_15 or nil) and (var_0_16 or var_0_15)].btns) do
		iter_11_1:setOpacity(0)
		iter_11_1:setVisible(false)
	end

	for iter_11_2, iter_11_3 in pairs(var_0_14[self.switchType].btns) do
		iter_11_3:setOpacity(255)
		iter_11_3:setVisible(true)
	end

	self:runAction(cc.CallFunc:create(function()
		self.showgirlLayer:getChildByName("showgirlLayer"):update(var_0_14[self.switchType].modelid)
	end))
	self.btnDetail:loadTextures(self._path .. "btn_detail_" .. self.switchType .. ".png", nil, self._path .. "btn_detail_" .. self.switchType .. ".png")
end

function ActivityMainLayer_230:switchToType(arg_17_1)
	self.showgirlLayer:getChildByName("showgirlLayer"):update(var_0_14[arg_17_1].modelid)

	for iter_17_0, iter_17_1 in pairs(var_0_14[self.switchType].btns) do
		iter_17_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			iter_17_1:setVisible(false)
		end)))
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		for iter_19_0, iter_19_1 in pairs(var_0_14[arg_17_1].btns) do
			iter_19_1:setVisible(true)
			iter_19_1:runAction(cc.FadeIn:create(0.2))
		end
	end)))
end

function ActivityMainLayer_230:playInEffect()
	return
end

return ActivityMainLayer_230
