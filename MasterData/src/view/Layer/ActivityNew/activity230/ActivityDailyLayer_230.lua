ActivityDailyLayer_230 = class("ActivityDailyLayer_230", (require("view.Layer.BaseUILayer")))
ErrorCodeManager = require("controller.error_code_manager")

local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_5 = "ActivityDailyLayer_230/"
local var_0_6 = 23003001
local var_0_7 = 230

function ActivityDailyLayer_230:ctor()
	ActivityDailyLayer_230.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.spring_daily_230_manager"):getInstance()
end

function ActivityDailyLayer_230.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityDailyLayer_230.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityDailyLayer_230.onEnter(arg_3_0)
	ActivityDailyLayer_230.super.onEnter(arg_3_0)
	activity_manager:registerEventListener("ActivityDailyLayer_230", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_4_0)
		if arg_4_0.showType == 1 and not arg_4_0.chapter then
			require("controller.spring_daily_230_manager"):getInstance():updateStoryInfo(arg_4_0)
		end
	end)
	activity_manager:get_activity_story_info(230, 1)
end

function ActivityDailyLayer_230.onExit(arg_5_0)
	ActivityDailyLayer_230.super.onExit(arg_5_0)
	activity_manager:releaseEventListenerByName("ActivityDailyLayer_230")
end

function ActivityDailyLayer_230:init(arg_6_1)
	self:initLayer()
	self:updateRed()
	self:nodeMove()
	self:initListener()
	activity_manager:get_activity_explore(230, function(arg_7_0)
		activity_manager:update_alert(230, "freeexplorer", arg_7_0)
		require("controller.spring_daily_230_manager"):getInstance():updateRed()
	end)

	return true
end

function ActivityDailyLayer_230.initLayer(arg_8_0)
	local var_8_0 = TempWidget:CreateTempLayout(arg_8_0)

	var_8_0:_setBack()
	var_8_0:setContentSize(GameDisplay.getUiScreenSize())

	arg_8_0._root = var_8_0

	TempWidget:CreateTempImg(var_0_5 .. "bg.png", var_8_0):center()
	TempWidget:CreateTempImg(var_0_5 .. "title.png", var_8_0):align(cc.p(0, 1), 10, var_8_0:size().h - 10)

	local var_8_1 = TempWidget:CreateTempBtn(var_0_5 .. "back.png", var_8_0)

	var_8_1:align(cc.p(0, 0), 10, 10)

	arg_8_0.backBtn = var_8_1

	local var_8_2 = TempWidget:CreateTempBtn(var_0_5 .. "boss.png", var_8_0)

	var_8_2:move(var_8_0:size().w / 2 + 150, var_8_0:size().h * 0.8)

	arg_8_0.bossBtn = var_8_2

	local var_8_3 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_8_2)

	var_8_3:align(cc.p(0, 1), 70, var_8_2:size().h / 2 + 50)
	var_8_3:setName("redImg")

	local var_8_4 = TempWidget:CreateTempBtn(var_0_5 .. "story.png", var_8_0)

	var_8_4:move(var_8_0:size().w / 2 - 150, var_8_0:size().h * 0.65)

	arg_8_0.storyBtn = var_8_4

	local var_8_5 = TempWidget:CreateTempBtn(var_0_5 .. "new_year.png", var_8_0)

	var_8_5:move(var_8_2:pos().x, var_8_0:size().h * 0.5)

	arg_8_0.newYearBtn = var_8_5

	local var_8_6 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_8_5)

	var_8_6:align(cc.p(0, 1), 70, var_8_5:size().h / 2 + 50)
	var_8_6:setName("redImg")

	local var_8_7 = TempWidget:CreateTempBtn(var_0_5 .. "explore.png", var_8_0)

	var_8_7:move(var_8_4:pos().x, var_8_0:size().h * 0.35)

	arg_8_0.exploreBtn = var_8_7

	local var_8_8 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_8_7)

	var_8_8:align(cc.p(0, 1), 70, var_8_7:size().h / 2 + 50)
	var_8_8:setName("redImg")

	local var_8_9 = TempWidget:CreateTempBtn(var_0_5 .. "daily.png", var_8_0)

	var_8_9:move(var_8_2:pos().x, var_8_0:size().h * 0.2)

	arg_8_0.dailyBtn = var_8_9

	local var_8_10 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_8_9)

	var_8_10:align(cc.p(0, 1), 70, var_8_9:size().h / 2 + 50)
	var_8_10:setName("redImg")

	local var_8_11 = TempWidget:CreateTempImg(var_0_5 .. "currency_bg.png", var_8_0)

	var_8_11:align(cc.p(1, 0), var_8_0:size().w - 10, 10)

	local var_8_12 = TempWidget:CreateTempLabel(item_manager:getItemNumber(var_0_6), FONT_NAME, 25, var_8_11)

	var_8_12:_setColor("b90f0f")
	var_8_12:move(var_8_11:size().w / 2 + 40, var_8_11:size().h / 2 - 7.5)
end

function ActivityDailyLayer_230:nodeMove()
	self:AniMove(self.bossBtn, "left")
	self:AniMove(self.storyBtn, "right")
	self:AniMove(self.newYearBtn, "left")
	self:AniMove(self.exploreBtn, "right")
	self:AniMove(self.dailyBtn, "left")
end

function ActivityDailyLayer_230:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.bossBtn:_addEvent(function()
		RoleDefault:getInstance():setBoolForKey("ActivityDailyLayer_230_Boss_Click", true)
	end)
	self.exploreBtn:_addEvent(function()
		ErrorCodeManager:check({
			systemname = "ActivityExploreLayer",
			id = var_0_7
		})

		if activity_manager:isHasExploreMapLayer(var_0_7) then
			LayerManager:switchShowLayer("ActivityExploreLayer_" .. var_0_7, {
				activityid = var_0_7
			})
		else
			activity_manager:get_activity_explore(var_0_7, function(arg_15_0)
				if arg_15_0.result == 1 then
					explore_manager:begin_explore({
						returnLayer = "ActivityDailyLayer_230",
						type = "activity",
						activityid = var_0_7,
						cancelCallback = function(arg_16_0)
							if arg_16_0 == 2 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
							elseif arg_16_0 == 3 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
							elseif arg_16_0 == 4 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
							elseif arg_16_0 == 5 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
							elseif arg_16_0 == 0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
							elseif arg_16_0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_16_0])
							end
						end,
						activity_explore_id = activity_manager:getCurExploreId(var_0_7)
					})
				end
			end)
		end
	end)
	self.dailyBtn:_addEvent(function()
		LayerManager:switchShowLayer("ActivityDailyLevelLayer", {
			activityid = var_0_7
		})
	end)
	self.storyBtn:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("ActivityStoryLayer_230")
	end)
	self.newYearBtn:_addEvent(function()
		RoleDefault:getInstance():setBoolForKey("ActivityDailyLayer_230_New_Year_Click", true)
		LayerManager:switchShowLayer("ActivityLevelBaseLayer", {
			activityid = var_0_7
		})
	end)
end

function ActivityDailyLayer_230:AniMove(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:pos()

	if arg_20_2 == "left" then
		arg_20_1:setPositionX(self._root:size().w + 100)
	elseif arg_20_2 == "right" then
		arg_20_1:setPositionX(-100)
	end

	arg_20_1:runAction(cc.EaseBackOut:create(cc.MoveTo:create(0.5, var_20_0)))
end

function ActivityDailyLayer_230.updateLayer(arg_21_0)
	return
end

function ActivityDailyLayer_230:updateRed()
	self.bossBtn:getChildByName("redImg"):setVisible(not RoleDefault:getInstance():getBoolForKey("ActivityDailyLayer_230_Boss_Click", false))
	self.exploreBtn:getChildByName("redImg"):setVisible(activity_manager:getAlertAllStatus(230, "freeexplorer"))
	self.dailyBtn:getChildByName("redImg"):setVisible(activity_manager:getAlertAllStatus(230, "daily_level"))
	self.newYearBtn:getChildByName("redImg"):setVisible(not RoleDefault:getInstance():getBoolForKey("ActivityDailyLayer_230_New_Year_Click", false))
end

function ActivityDailyLayer_230:updateStoryInfo()
	self:updateRed()
end

return ActivityDailyLayer_230
