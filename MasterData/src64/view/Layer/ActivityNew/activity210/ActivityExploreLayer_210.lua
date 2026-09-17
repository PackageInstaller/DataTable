ActivityExploreLayer_210 = class("ActivityExploreLayer_210", function()
	return cc.Layer:create()
end)

local activity_anniversary_manager = require("controller.activity_anniversary_manager")
local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local var_0_4 = config._DEBUG and 0 or 1

function ActivityExploreLayer_210.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityExploreLayer_210.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityExploreLayer_210:init(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self.finishtime = arg_3_1.finishtime or global_get_time_by_date("2021-11-01 00:00:00")
	self.activityid = arg_3_1.activityid or 132
	self.activityExploreData = activity_manager:getActivityExploreConfData(self.activityid)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityExplore_210.json" or "ActivityExplore_210.ExportJson")

	self:addChild(self.rootLayer)
	self:initBaseUI()
	self:fullScreen()
	self:playEntranceAni()
	activity_manager:get_activity_explore(self.activityid, function(arg_4_0)
		if arg_4_0.result == 1 then
			self.step_level = arg_4_0.finish_step
		end

		self:updateUI()
	end)
end

function ActivityExploreLayer_210:initBaseUI()
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "time")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return")
	self.chapterNodes = {}

	for iter_5_0 = 1, 4 do
		self.chapterNodes[iter_5_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "explore_" .. iter_5_0)
		self.chapterNodes[iter_5_0].updateNode = function(arg_6_0, arg_6_1)
			local var_6_0, var_6_1 = self:isChapterUnlock(iter_5_0)
			local var_6_3 = self.chapterNodes[iter_5_0]:getChildByName("des")

			var_6_3:setVisible(false)

			if var_6_0 then
				self.chapterNodes[iter_5_0]:loadTexture("ActivityExplore_210/stage_bg_on.png", var_0_4)
			else
				self.chapterNodes[iter_5_0]:loadTexture("ActivityExplore_210/stage_bg_off.png", var_0_4)
				var_6_3:setVisible(true)

				if var_6_1 == "time" then
					var_6_3:setString(self.activityExploreData[iter_5_0].starttime .. "开启")
				elseif var_6_1 == "level" then
					var_6_3:setString(ANNIVERSARY_EXPLORE_ERROR[var_6_1])
				end
			end
		end
	end

	self.timeLabel:setString(self:getLeftTimeStr())
	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_explore_210"
		})
	end)
	self:registerBtnsTouchEvent()
end

function ActivityExploreLayer_210:fullScreen()
	self.title:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.title:getPositionY(), TRANSFORM_UNIT.PX))
	self.timeLabel:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.timeLabel:getPositionY(), TRANSFORM_UNIT.PX))
	self.returnBtn:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.returnBtn:getPositionY(), TRANSFORM_UNIT.PX))
end

function ActivityExploreLayer_210:playEntranceAni()
	self.returnBtn:setPositionX(700)
	self.returnBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-20, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(115, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(105, self.returnBtn:getPositionY()))))

	for iter_9_0 = 1, #self.chapterNodes - 1 do
		self.rootLayer:getChildByName("line_" .. iter_9_0):setOpacity(0)
	end

	self.chapterNodes[1]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[2]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[3]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[4]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[1]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(153, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(133, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(143, self.chapterNodes[1]:getPositionY()))))
	self.chapterNodes[2]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(500, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(480, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(490, self.chapterNodes[2]:getPositionY()))))
	self.chapterNodes[3]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(165, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(145, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(155, self.chapterNodes[3]:getPositionY()))))
	self.chapterNodes[4]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(500, self.chapterNodes[4]:getPositionY())), cc.MoveTo:create(0.1, cc.p(480, self.chapterNodes[4]:getPositionY())), cc.MoveTo:create(0.1, cc.p(490, self.chapterNodes[4]:getPositionY()))))

	for iter_9_1 = 1, #self.chapterNodes - 1 do
		self.rootLayer:getChildByName("line_" .. iter_9_1):runAction(cc.Sequence:create(cc.DelayTime:create(0.6 + (iter_9_1 - 1) * 0.2), cc.FadeIn:create(0.2)))
	end
end

function ActivityExploreLayer_210:registerBtnsTouchEvent()
	self.title:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityExploreLayer_210"
		})
	end)
	self.returnBtn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playExitAni(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	for iter_10_0 = 1, 4 do
		self.chapterNodes[iter_10_0]:setTouchEnabled(true)
		self.chapterNodes[iter_10_0]:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_14_0, var_14_1 = self:isChapterUnlock(iter_10_0)

			if var_14_0 then
				self:gotoExplore(iter_10_0, touchcallback)
			else
				global_ShowBlockWords(ANNIVERSARY_EXPLORE_ERROR[var_14_1])
			end
		end)
	end
end

function ActivityExploreLayer_210:getLeftTimeStr()
	local var_15_0 = self.finishtime - time_check_manager:getCurTime()

	if var_15_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(var_15_0 / 86400), math.floor(var_15_0 % 86400 / 3600))
	elseif var_15_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(var_15_0 / 3600), math.floor(var_15_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(var_15_0 / 60), math.floor(var_15_0 % 60))
	end
end

function ActivityExploreLayer_210:updateUI()
	for iter_16_0 = 1, 4 do
		self.chapterNodes[iter_16_0]:updateNode(msg)
	end
end

function ActivityExploreLayer_210:isChapterUnlock(arg_17_1)
	if self.activityExploreData[arg_17_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(self.activityExploreData[arg_17_1].starttime) then
		return false, "time"
	end

	if self.activityExploreData[arg_17_1].id > self.step_level + 1 then
		return false, "level"
	end

	return true
end

function ActivityExploreLayer_210:gotoExplore(arg_18_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityExploreLayer_210",
		activity_explore_id = self.activityExploreData[arg_18_1].id,
		activityid = self.activityid,
		cancelCallback = function(arg_19_0)
			print(dump(arg_19_0))

			if arg_19_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_19_0 == 3 then
				global_ShowBlockWords("活动关卡已全部完成!")
			elseif arg_19_0 == 4 then
				global_ShowBlockWords("该活动关卡已完成")
			elseif arg_19_0 == 5 then
				global_ShowBlockWords("服务端客户端数据不同步！")
			elseif arg_19_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function ActivityExploreLayer_210:playExitAni(arg_20_1)
	self.isShowEffect = true

	self.returnBtn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_20_1 then
			arg_20_1()
		end

		self.isShowEffect = nil
	end)))
end
