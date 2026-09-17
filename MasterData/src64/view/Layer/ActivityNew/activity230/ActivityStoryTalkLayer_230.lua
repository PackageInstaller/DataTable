ActivityStoryTalkLayer_230 = class("ActivityStoryTalkLayer_230", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "ActivityStoryLayer_230/"
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local QuickCell = require("view.Sprite.QuickCell")
local var_0_6 = 23003001
local var_0_7 = 200

function ActivityStoryTalkLayer_230:ctor()
	ActivityStoryTalkLayer_230.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.spring_story_talk_230_manager"):getInstance()
end

function ActivityStoryTalkLayer_230.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityStoryTalkLayer_230.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityStoryTalkLayer_230.onEnter(arg_3_0)
	ActivityStoryTalkLayer_230.super.onEnter(arg_3_0)
	activity_manager:registerEventListener("ActivityStoryTalkLayer_230", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_4_0)
		if arg_4_0.showType == 1 and not arg_4_0.chapter then
			require("controller.spring_story_talk_230_manager"):getInstance():updateStoryInfo(arg_4_0)
		end
	end)
	activity_manager:get_activity_story_info(230, 1)
end

function ActivityStoryTalkLayer_230.onExit(arg_5_0)
	ActivityStoryTalkLayer_230.super.onExit(arg_5_0)
	activity_manager:releaseEventListenerByName("ActivityStoryTalkLayer_230")
end

function ActivityStoryTalkLayer_230:init(arg_6_1)
	self.data = arg_6_1 or {}
	self.data.type = self.data.type or 3

	self:initLayer()
	self:initListener()

	return true
end

function ActivityStoryTalkLayer_230:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_7_0):center()

	local var_7_1 = TempWidget:CreateTempImg(var_0_2 .. "bg1.png", var_7_0)

	var_7_1:move(var_7_0:size().w / 2, var_7_0:size().h * 0.46)

	self.bg1 = var_7_1

	self:setBg1Scale()
	TempWidget:CreateTempImg(var_0_2 .. string.format("story_bg%d.png", self.data.type), var_7_1):align(cc.p(0.5, 1), var_7_1:size().w / 2, var_7_1:size().h + 220)
	TempWidget:CreateTempImg(var_0_2 .. "title.png", var_7_0):align(cc.p(0, 1), 10, var_7_0:size().h - 10)

	local var_7_2 = TempWidget:CreateTempBtn(var_0_2 .. "back.png", var_7_0)

	var_7_2:align(cc.p(0, 0), 10, 10)

	self.backBtn = var_7_2

	local var_7_3 = TempWidget:CreateTempImg(var_0_2 .. "currency_bg.png", var_7_0)

	var_7_3:align(cc.p(1, 0), var_7_0:size().w - 10, 10)

	local var_7_4 = TempWidget:CreateTempLabel(item_manager:getItemNumber(var_0_6), FONT_NAME, 25, var_7_3)

	var_7_4:_setColor("b90f0f")
	var_7_4:move(var_7_3:size().w / 2 + 40, var_7_3:size().h / 2 - 7.5)
	self:initListView()
end

function ActivityStoryTalkLayer_230:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.backBtn:_addEvent(function()
		LayerManager:removePopLayer()
		LayerManager:pushInLayer("ActivityStoryLayer_230")
	end)
end

function ActivityStoryTalkLayer_230:setBg1Scale()
	local var_11_0 = 2.1
	local var_11_1 = 1.775
	local var_11_2 = self._root:size().h / self._root:size().w

	self.bg1:setScale(2.1 <= var_11_2 and 1 or var_11_2 <= var_11_1 and 0.85 or 1 - (var_11_0 - var_11_2) / (var_11_0 - var_11_1) * 0.15)
end

function ActivityStoryTalkLayer_230:initListView()
	local var_12_0 = self.bg1:size().w
	local var_12_1 = TempWidget:CreateTempListView(self.bg1)

	var_12_1:setDirection(ccui.ListViewDirection.vertical)
	var_12_1:setContentSize(cc.size(var_12_0, self.bg1:size().h - 170))
	var_12_1:align(cc.p(0.5, 0), self.bg1:size().w / 2, 50)

	self.listView = var_12_1

	for iter_12_0 = 1, #self.manager:getInfo(self.data.type) do
		local var_12_2 = QuickCell:Create({
			wid = var_12_0,
			hei = var_0_7,
			createCell = function()
				return self:createCell(iter_12_0)
			end
		})

		var_12_2:setOpacity(0)
		var_12_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 + (iter_12_0 - 1) * 0.05), cc.FadeIn:create(0.05)))
		var_12_1:pushBackCustomItem(var_12_2)
	end
end

function ActivityStoryTalkLayer_230:createCell(arg_14_1)
	local var_14_0 = self.manager:getInfo(self.data.type)
	local var_14_1 = TempWidget:CreateTempLayout()

	var_14_1:setContentSize(cc.size(self.listView:size().w, var_0_7))
	var_14_1:setClippingEnabled(true)

	local var_14_2 = TempWidget:CreateTempImg(var_0_2 .. "line_off.png", var_14_1)

	var_14_2:align(cc.p(0.5, 1), 15, var_14_1:size().h / 2)

	if arg_14_1 ~= 1 then
		TempWidget:CreateTempImg(var_0_2 .. "line_off.png", var_14_1):align(cc.p(0.5, 0), var_14_2:pos().x, var_14_1:size().h / 2)
	end

	local var_14_3 = TempWidget:CreateTempImg(var_0_2 .. "line_on.png", var_14_1)

	var_14_3:align(cc.p(0.5, 1), var_14_2:pos().x, var_14_1:size().h / 2)
	var_14_3:setName("lineOn")
	var_14_3:setVisible(var_14_0[arg_14_1].stat == 1 or var_14_0[arg_14_1].stat == 4)

	if arg_14_1 ~= 1 then
		local var_14_4 = TempWidget:CreateTempImg(var_0_2 .. "line_on.png", var_14_1)

		var_14_4:align(cc.p(0.5, 0), var_14_2:pos().x, var_14_1:size().h / 2)
		var_14_4:setName("lineUpOn")
		var_14_4:setVisible(var_14_0[arg_14_1].stat == 1 or var_14_0[arg_14_1].stat == 4)
	end

	local var_14_5 = TempWidget:CreateTempImg(var_0_2 .. "dian_off.png", var_14_1)

	var_14_5:align(cc.p(0.5, 0.5), var_14_2:pos().x, var_14_1:size().h / 2)
	var_14_5:setName("dianOff")
	var_14_5:setVisible(var_14_0[arg_14_1].stat ~= 1 and var_14_0[arg_14_1].stat ~= 4)

	local var_14_6 = TempWidget:CreateTempImg(var_0_2 .. "dian_on.png", var_14_1)

	var_14_6:align(cc.p(0.5, 0.5), var_14_2:pos().x, var_14_1:size().h / 2)
	var_14_6:setName("dianOn")
	var_14_6:setVisible(var_14_0[arg_14_1].stat == 1 or var_14_0[arg_14_1].stat == 4)

	local var_14_7 = TempWidget:CreateTempImg(var_0_2 .. string.format("role%d.png", self.data.type), var_14_1)

	var_14_7:align(cc.p(0, 0.5), 40, var_14_1:size().h / 2)
	var_14_7:setName("role")

	local var_14_8 = TempWidget:CreateTempImg("public/reddot/reddot2.png", var_14_7)

	var_14_8:align(cc.p(0, 1), -10, var_14_7:size().h + 10)
	var_14_8:setName("redImg")
	var_14_8:setVisible(self.manager:haveNewStory(self.data.type, arg_14_1))

	local var_14_9 = TempWidget:CreateTempBtn(var_0_2 .. "play.png", var_14_7)

	var_14_9:center()
	var_14_9:setName("playBtn")
	var_14_9:setVisible(var_14_0[arg_14_1].stat == 1 or var_14_0[arg_14_1].stat == 4)
	var_14_9:_addEvent(function()
		if var_14_0[arg_14_1].stat == 1 or var_14_0[arg_14_1].stat == 4 then
			self._root:addChild((TalkLayer:create(var_14_0[arg_14_1].talkid, nil, TALK_TYPE_FAVOR, "", function(arg_16_0, arg_16_1)
				activity_manager:get_activity_story_reward(230, var_14_0[arg_14_1].id, 1, nil, arg_16_1)
			end)))
		else
			global_ShowBlockWords(var_14_0[arg_14_1].tips)
		end
	end)

	local var_14_10 = TempWidget:CreateTempBtn(var_0_2 .. "lock.png", var_14_7)

	var_14_10:center()
	var_14_10:setName("lockBtn")
	var_14_10:setVisible(var_14_0[arg_14_1].stat ~= 1 and var_14_0[arg_14_1].stat ~= 4)
	var_14_10:_addEvent(function()
		if var_14_0[arg_14_1].tips then
			global_ShowBlockWords(var_14_0[arg_14_1].tips)
		else
			global_ShowBlockWords("暂未解锁")
		end
	end)
	TempWidget:CreateTempLabel(arg_14_1, FONT_NAME, 26, var_14_7):align(cc.p(0, 1), 17, var_14_7:size().h - 17)

	local var_14_11 = TempWidget:CreateTempImg(var_0_2 .. "split_line.png", var_14_1)

	var_14_11:align(cc.p(0, 0.5), var_14_1:size().w / 2 - 80, var_14_1:size().h * 0.5)

	local var_14_12 = TempWidget:CreateTempImg(var_0_2 .. "title_symbol.png", var_14_1)

	var_14_12:align(cc.p(0, 0.5), var_14_11:pos().x, var_14_11:pos().y + 25)

	local var_14_13 = TempWidget:CreateTempLabel(var_14_0[arg_14_1].nmae, FONT_NAME, 32, var_14_1)

	var_14_13:align(cc.p(0, 0.5), var_14_12:pos().x + var_14_12:size().w + 15, var_14_12:pos().y)
	var_14_13:_setColor("97311b")

	local var_14_14 = TempWidget:CreateTempLabel(var_14_0[arg_14_1].desc, FONT_NAME, 23, var_14_1)

	var_14_14:align(cc.p(0, 0.5), var_14_12:pos().x, var_14_11:pos().y - 25)
	var_14_14:_setColor("97311b")

	return var_14_1
end

function ActivityStoryTalkLayer_230.updateLayer(arg_18_0)
	return
end

function ActivityStoryTalkLayer_230:updateRed()
	local var_19_0 = self.manager:getInfo(self.data.type)
	local var_19_1 = self.listView:getItems()

	for iter_19_0 = 1, #var_19_1 do
		if var_19_1[iter_19_0]:IsEnter() then
			local var_19_2 = ui_delegate(var_19_1[iter_19_0])

			var_19_2.redImg:setVisible(self.manager:haveNewStory(self.data.type, iter_19_0))
			var_19_2.playBtn:setVisible(var_19_0[iter_19_0].stat == 1 or var_19_0[iter_19_0].stat == 4)
			var_19_2.lockBtn:setVisible(var_19_0[iter_19_0].stat ~= 1 and var_19_0[iter_19_0].stat ~= 4)
			var_19_2.lineOn:setVisible(var_19_0[iter_19_0].stat == 1 or var_19_0[iter_19_0].stat == 4)

			if var_19_2.lineUpOn then
				var_19_2.lineUpOn:setVisible(var_19_0[iter_19_0].stat == 1 or var_19_0[iter_19_0].stat == 4)
			end

			var_19_2.dianOff:setVisible(var_19_0[iter_19_0].stat ~= 1 and var_19_0[iter_19_0].stat ~= 4)
			var_19_2.dianOn:setVisible(var_19_0[iter_19_0].stat == 1 or var_19_0[iter_19_0].stat == 4)
		end
	end
end

function ActivityStoryTalkLayer_230:updateStoryInfo()
	self:updateRed()
end

return ActivityStoryTalkLayer_230
