ActivityExploreLayer_209 = class("ActivityExploreLayer_209", function()
	return cc.Layer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local var_0_4

function ActivityExploreLayer_209.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityExploreLayer_209.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityExploreLayer_209.getInstance()
	return var_0_4
end

function ActivityExploreLayer_209:init(arg_4_1)
	var_0_4 = self
	arg_4_1 = arg_4_1 or {}
	self.finishtime = arg_4_1.finishtime or global_get_time_by_date("2021-09-30 00:00:00")
	self.activityid = arg_4_1.activityid or 209
	self.activityExploreData = ActivityAnniversaryManager:getActivityExploreConfData()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityAnniversaryExploreLayer.json" or "ActivityAnniversaryExploreLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initBaseUI()
	self:fullScreen()
	self:playEntranceAni()
	activity_manager:get_activity_explore(self.activityid, function(arg_5_0)
		if not ActivityExploreLayer_209.getInstance() then
			return
		end

		if arg_5_0.result == 1 then
			self.step_level = arg_5_0.finish_step
		end

		self:updateUI()
	end)
end

function ActivityExploreLayer_209:initBaseUI()
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_title")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.chapterNodes = {}

	for iter_6_0 = 1, 3 do
		self.chapterNodes[iter_6_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter" .. iter_6_0)
		self.chapterNodes[iter_6_0].updateNode = function(self, arg_7_1)
			local var_7_0, var_7_1 = self:isChapterUnlock(iter_6_0)
			local var_7_2 = self.activityExploreData[iter_6_0].id <= self.step_level
			local var_7_3 = self:getChildByName("mark")
			local var_7_4 = var_7_3:getChildByName("passed")
			local var_7_5 = var_7_3:getChildByName("lock")
			local var_7_6 = var_7_3:getChildByName("Label_des")

			var_7_3:setVisible(false)
			var_7_4:setVisible(false)
			var_7_5:setVisible(false)
			var_7_6:setVisible(false)

			if var_7_0 then
				if var_7_2 then
					var_7_3:setVisible(true)
					var_7_4:setVisible(true)
				end
			else
				var_7_3:setVisible(true)
				var_7_5:setVisible(true)
				var_7_6:setVisible(true)

				if var_7_1 == "time" then
					var_7_6:setString(self.activityExploreData[iter_6_0].starttime .. "开启")
				elseif var_7_1 == "level" then
					var_7_6:setString(ANNIVERSARY_EXPLORE_ERROR[var_7_1])
				end

				if iter_6_0 == 1 or iter_6_0 == 3 then
					var_7_5:setPositionX(var_7_6:getPositionX() - var_7_6:getContentSize().width)
				end
			end
		end
	end

	self.timeLabel:setString(self:getLeftTimeStr())
	self:registerBtnsTouchEvent()
end

function ActivityExploreLayer_209:fullScreen()
	self.title:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.title:getPositionY(), TRANSFORM_UNIT.PX))
	self.timeLabel:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - self.timeLabel:getPositionY(), TRANSFORM_UNIT.PX))
	self.returnBtn:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.returnBtn:getPositionY(), TRANSFORM_UNIT.PX))
end

function ActivityExploreLayer_209:playEntranceAni()
	self.returnBtn:setPositionX(700)
	self.returnBtn:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(-10, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(10, self.returnBtn:getPositionY())), cc.MoveTo:create(0.1, cc.p(0, self.returnBtn:getPositionY()))))
	self.chapterNodes[1]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[2]:setPositionX(640 + self.chapterNodes[1]:getPositionY())
	self.chapterNodes[3]:setPositionX(0 - self.chapterNodes[1]:getPositionY())
	self.chapterNodes[1]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(288, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(268, self.chapterNodes[1]:getPositionY())), cc.MoveTo:create(0.1, cc.p(278, self.chapterNodes[1]:getPositionY()))))
	self.chapterNodes[2]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(372, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(352, self.chapterNodes[2]:getPositionY())), cc.MoveTo:create(0.1, cc.p(362, self.chapterNodes[2]:getPositionY()))))
	self.chapterNodes[3]:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(288, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(268, self.chapterNodes[3]:getPositionY())), cc.MoveTo:create(0.1, cc.p(278, self.chapterNodes[3]:getPositionY()))))

	local var_9_0 = self.rootLayer:getChildByName("Image_8")

	var_9_0:setPositionY(2000)
	var_9_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.3, cc.p(var_9_0:getPositionX(), 510))))
end

function ActivityExploreLayer_209:registerBtnsTouchEvent()
	self.title:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "Activity_anniversary_explore"
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

	for iter_10_0 = 1, 3 do
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

function ActivityExploreLayer_209:getLeftTimeStr()
	local var_15_0 = self.finishtime - time_check_manager:getCurTime()

	if var_15_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(var_15_0 / 86400), math.floor(var_15_0 % 86400 / 3600))
	elseif var_15_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(var_15_0 / 3600), math.floor(var_15_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(var_15_0 / 60), math.floor(var_15_0 % 60))
	end
end

function ActivityExploreLayer_209:updateUI()
	for iter_16_0 = 1, 3 do
		self.chapterNodes[iter_16_0]:updateNode(msg)
	end
end

function ActivityExploreLayer_209:isChapterUnlock(arg_17_1)
	if self.activityExploreData[arg_17_1].starttime and time_check_manager:getCurTime() < global_get_time_by_date(self.activityExploreData[arg_17_1].starttime) then
		return false, "time"
	end

	if self.activityExploreData[arg_17_1].id > self.step_level + 1 then
		return false, "level"
	end

	return true
end

function ActivityExploreLayer_209:gotoExplore(arg_18_1)
	explore_manager:begin_explore({
		type = "activity",
		returnLayer = "ActivityExploreLayer_209",
		activity_explore_id = self.activityExploreData[arg_18_1].id,
		activityid = self.activityid,
		cancelCallback = function(arg_19_0)
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

function ActivityExploreLayer_209:playExitAni(arg_20_1)
	self.isShowEffect = true

	self.returnBtn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_20_1 then
			arg_20_1()
		end

		self.isShowEffect = nil
	end)))
end
