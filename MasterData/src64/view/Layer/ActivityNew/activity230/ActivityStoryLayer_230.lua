ActivityStoryLayer_230 = class("ActivityStoryLayer_230", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "ActivityStoryLayer_230/"
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local var_0_5 = 23003001

function ActivityStoryLayer_230:ctor()
	ActivityStoryLayer_230.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.spring_story_230_manager"):getInstance()
end

function ActivityStoryLayer_230.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityStoryLayer_230.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityStoryLayer_230.onEnter(arg_3_0)
	ActivityStoryLayer_230.super.onEnter(arg_3_0)
	activity_manager:registerEventListener("ActivityStoryLayer_230", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_4_0)
		if arg_4_0.showType == 1 and not arg_4_0.chapter then
			require("controller.spring_story_230_manager"):getInstance():updateStoryInfo(arg_4_0)
		end
	end)
	activity_manager:get_activity_story_info(230, 1)
end

function ActivityStoryLayer_230.onExit(arg_5_0)
	ActivityStoryLayer_230.super.onExit(arg_5_0)
	activity_manager:releaseEventListenerByName("ActivityStoryLayer_230")
end

function ActivityStoryLayer_230:init(arg_6_1)
	self:initLayer()
	self:initListener()

	return true
end

function ActivityStoryLayer_230:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_7_0):center()

	local var_7_1 = TempWidget:CreateTempImg(var_0_2 .. "bg1.png", var_7_0)

	var_7_1:move(var_7_0:size().w / 2, var_7_0:size().h * 0.46)

	self.bg1 = var_7_1

	self:setBg1Scale()

	local var_7_2 = TempWidget:CreateTempImg(var_0_2 .. "title1.png", var_7_1)

	var_7_2:align(cc.p(0.5, 1), var_7_1:size().w / 2, var_7_1:size().h - 37)

	local var_7_3 = TempWidget:CreateTempBtn(var_0_2 .. "story_btn1.png", var_7_1)

	var_7_3:align(cc.p(0.5, 1), var_7_2:pos().x, var_7_2:pos().y - var_7_2:size().h)
	var_7_3:setOpacity(0)
	var_7_3:runAction(cc.FadeIn:create(0.2))

	self.storyBtn1 = var_7_3

	local var_7_4 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_7_3)

	var_7_4:align(cc.p(0, 1), 0, var_7_3:size().h)
	var_7_4:hide()
	var_7_4:setName("redImg")

	local var_7_5 = TempWidget:CreateTempBtn(var_0_2 .. "story_btn2.png", var_7_1)

	var_7_5:align(cc.p(0, 1), 5, var_7_3:pos().y - var_7_3:size().h)
	var_7_5:setOpacity(0)
	var_7_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.2)))

	self.storyBtn2 = var_7_5

	local var_7_6 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_7_5)

	var_7_6:align(cc.p(0, 1), 0, var_7_5:size().h)
	var_7_6:hide()
	var_7_6:setName("redImg")

	local var_7_7 = TempWidget:CreateTempBtn(var_0_2 .. "story_btn3.png", var_7_1)

	var_7_7:align(cc.p(1, 1), var_7_1:size().w + 5, var_7_5:pos().y)
	var_7_7:setOpacity(0)
	var_7_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.2)))

	self.storyBtn3 = var_7_7

	local var_7_8 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_7_7)

	var_7_8:align(cc.p(0, 1), 0, var_7_7:size().h)
	var_7_8:hide()
	var_7_8:setName("redImg")

	local var_7_9 = TempWidget:CreateTempImg(var_0_2 .. "tips.png", var_7_1)

	var_7_9:align(cc.p(0, 0), 15, 40)

	local var_7_10 = TempWidget:CreateTempBtn(var_0_2 .. "story_btn4.png", var_7_1)

	var_7_10:align(cc.p(1, 0), var_7_1:size().w, var_7_9:pos().y)

	self.storyBtn4 = var_7_10

	local var_7_11 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_7_10)

	var_7_11:align(cc.p(0, 1), 0, var_7_10:size().h)
	var_7_11:hide()
	var_7_11:setName("redImg")

	local var_7_12 = TempWidget:CreateTempImg(var_0_2 .. "title.png", var_7_0)

	var_7_12:align(cc.p(0, 1), 10, var_7_0:size().h - 10)
	var_7_12:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_story_layer_230"
		})
	end)

	local var_7_13 = TempWidget:CreateTempBtn(var_0_2 .. "back.png", var_7_0)

	var_7_13:align(cc.p(0, 0), 10, 10)

	self.backBtn = var_7_13

	local var_7_14 = TempWidget:CreateTempImg(var_0_2 .. "currency_bg.png", var_7_0)

	var_7_14:align(cc.p(1, 0), var_7_0:size().w - 10, 10)

	local var_7_15 = TempWidget:CreateTempLabel(item_manager:getItemNumber(var_0_5), FONT_NAME, 25, var_7_14)

	var_7_15:_setColor("b90f0f")
	var_7_15:move(var_7_14:size().w / 2 + 40, var_7_14:size().h / 2 - 7.5)
end

function ActivityStoryLayer_230:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:switchShowLayer("ActivityDailyLayer_230")
	end)
	self.storyBtn1:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("ActivityStoryTalkLayer_230", {
			type = 1
		})
	end)
	self.storyBtn2:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("ActivityStoryTalkLayer_230", {
			type = 2
		})
	end)
	self.storyBtn3:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("ActivityStoryTalkLayer_230", {
			type = 3
		})
	end)
	self.storyBtn4:_addEvent(function()
		local var_15_0 = require("controller.spring_story_talk_230_manager"):getInstance():getInfo(4)

		if var_15_0 and var_15_0[1] then
			if var_15_0[1].stat == 1 or var_15_0.stat == 3 then
				self._root:addChild((TalkLayer:create(var_15_0[1].talkid, nil, TALK_TYPE_FAVOR, "", function(arg_16_0, arg_16_1)
					activity_manager:get_activity_story_reward(230, var_15_0[1].id, 1, nil, arg_16_1)
				end)))
			elseif var_15_0[1].stat == 4 then
				self._root:addChild((TalkLayer:create(var_15_0[1].talkid, nil, TALK_TYPE_FAVOR, "", function(arg_17_0, arg_17_1)
					activity_manager:get_activity_story_reward(230, var_15_0[1].id, 1, nil, arg_17_1)
				end)))
			elseif var_15_0[1].tips then
				global_ShowBlockWords(var_15_0[1].tips)
			else
				global_ShowBlockWords("暂未解锁")
			end
		end
	end)
end

function ActivityStoryLayer_230:setBg1Scale()
	local var_18_0 = 2.1
	local var_18_1 = 1.775
	local var_18_2 = self._root:size().h / self._root:size().w

	self.bg1:setScale(2.1 <= var_18_2 and 1 or var_18_2 <= var_18_1 and 0.85 or 1 - (var_18_0 - var_18_2) / (var_18_0 - var_18_1) * 0.15)
end

function ActivityStoryLayer_230.updateLayer(arg_19_0)
	return
end

function ActivityStoryLayer_230:updateRed()
	for iter_20_0 = 1, 4 do
		self["storyBtn" .. iter_20_0]:getChildByName("redImg"):setVisible(self.manager:haveNewStory(iter_20_0))
	end
end

function ActivityStoryLayer_230:updateStoryInfo()
	self:updateRed()
end

return ActivityStoryLayer_230
