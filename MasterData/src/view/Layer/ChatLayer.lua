ChatLayer = class("ChatLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local social_data = require("data.social_data")
local var_0_2 = 0

function ChatLayer.create(arg_2_0)
	local var_2_0 = ChatLayer.new()

	if playermodel.playerid == 50007 or playermodel.playerid == 50004 or playermodel.playerid == 50008 then
		var_2_0:initChatRoom()
	else
		var_2_0:initLimitRoom()
	end

	return var_2_0
end

local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = "Map/chatbg2.png"
local var_0_6 = "Map/chatbg1.png"
local var_0_7 = 70
local var_0_8 = 80
local var_0_9 = 640 - 70
local var_0_10 = 410 - 80
local var_0_11 = 570

local function var_0_12(arg_3_0, arg_3_1)
	local var_3_0 = cc.Scale9Sprite:create(var_0_6)

	var_3_0:setCapInsets(cc.rect(10, 30, 30, 10))
	var_3_0:setAnchorPoint(cc.p(0, 1))

	local var_3_1 = cc.Label:createWithTTF(arg_3_0, "fonts/new1.ttf", 20)

	var_3_1:setColor(cc.c3b(10, 10, 10))
	var_3_1:setAnchorPoint(cc.p(0, 0))
	var_3_1:setMaxLineWidth(400)
	var_3_1:setVerticalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_3_1:setPosition(cc.p(15, 5))

	local var_3_2 = var_3_1:getContentSize()

	var_3_0:setPreferredSize(cc.size(var_3_2.width + 20, var_3_2.height + 10))
	var_3_0:addChild(var_3_1, 2)

	local var_3_3 = cc.Label:createWithTTF(arg_3_1, "fonts/new1.ttf", 20)

	var_3_3:setAnchorPoint(cc.p(0, 1))

	local var_3_4 = cc.Scale9Sprite:create("Map/whiteline.png")

	var_3_4:setCapInsets(cc.rect(1, 1, 1, 1))
	var_3_4:setAnchorPoint(cc.p(0, 1))
	var_3_4:setPreferredSize(cc.size(var_3_3:getContentSize().width, 2))

	local var_3_5 = ccui.Layout:create()

	var_3_5:setContentSize(cc.size(var_0_11, var_3_2.height + 20))
	var_3_3:setPosition(cc.p(10, var_3_5:getContentSize().height - 10))
	var_3_4:setPosition(cc.p(10, var_3_5:getContentSize().height - 30))
	var_3_0:setPosition(cc.p(10 + var_3_3:getContentSize().width + 5, var_3_5:getContentSize().height - 10))
	var_3_5:addChild(var_3_3)
	var_3_5:addChild(var_3_4)
	var_3_5:addChild(var_3_0)

	return var_3_5
end

local function var_0_13(arg_4_0, arg_4_1)
	local var_4_0 = cc.Scale9Sprite:create(var_0_5)

	var_4_0:setCapInsets(cc.rect(10, 30, 30, 10))
	var_4_0:setAnchorPoint(cc.p(1, 1))

	local var_4_1 = cc.Label:createWithTTF(arg_4_0, "fonts/new1.ttf", 20)

	var_4_1:setColor(cc.c3b(10, 10, 10))
	var_4_1:setAnchorPoint(cc.p(0, 0))
	var_4_1:setMaxLineWidth(400)
	var_4_1:setVerticalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_4_1:setPosition(cc.p(5, 5))

	local var_4_2 = var_4_1:getContentSize()

	var_4_0:setPreferredSize(cc.size(var_4_2.width + 20, var_4_2.height + 10))
	var_4_0:addChild(var_4_1, 2)

	local var_4_3 = cc.Label:createWithTTF(arg_4_1, "fonts/new1.ttf", 20)

	var_4_3:setAnchorPoint(cc.p(1, 1))

	local var_4_4 = cc.Scale9Sprite:create("Map/whiteline.png")

	var_4_4:setCapInsets(cc.rect(1, 1, 1, 1))
	var_4_4:setAnchorPoint(cc.p(1, 1))
	var_4_4:setPreferredSize(cc.size(var_4_3:getContentSize().width, 2))

	local var_4_5 = ccui.Layout:create()

	var_4_5:setContentSize(cc.size(var_0_11, var_4_2.height + 20))
	var_4_3:setPosition(cc.p(var_0_11 - 10, var_4_5:getContentSize().height - 10))
	var_4_4:setPosition(cc.p(var_0_11 - 10, var_4_5:getContentSize().height - 30))
	var_4_0:setPosition(var_0_11 - 10 - var_4_3:getContentSize().width, var_4_5:getContentSize().height - 10)
	var_4_5:addChild(var_4_3)
	var_4_5:addChild(var_4_4)
	var_4_5:addChild(var_4_0)

	return var_4_5
end

local var_0_14 = {
	1,
	1,
	1
}
local var_0_15 = {
	require("data.chat_data1"),
	require("data.chat_data2"),
	(require("data.chat_data3"))
}
local var_0_16 = {
	{},
	{},
	{}
}
local var_0_17 = L_CHAT_MSG.asname

function ChatLayer:initChatRoom()
	self.bg = ccui.ImageView:create("Map/jiesuo_bg2.png", var_0_2)

	self.bg:setScale9Enabled(true)
	self.bg:setCapInsets(cc.rect(20, 20, 10, 10))
	self.bg:setContentSize(cc.size(640, 327))
	self.bg:setAnchorPoint(cc.p(0.5, 0))
	self.bg:setPosition(cc.p(320, 50))
	self:addChild(self.bg, 1)

	for iter_5_0 = 1, 3 do
		if #var_0_16[iter_5_0] <= 0 then
			for iter_5_1 = 1, 10 do
				table.insert(var_0_16[iter_5_0], {
					rolt = var_0_4,
					talk = var_0_15[iter_5_0][iter_5_1].talk,
					name = var_0_15[iter_5_0][iter_5_1].name
				})
			end

			var_0_14[iter_5_0] = 11
		end
	end

	self.totalHeight = 0
	self.sps = {}
	self.list = {}
	self.currentIndex = nil
	self.chatRoomLayer = ccui.ScrollView:create()

	self.chatRoomLayer:setDirection(ccui.ScrollViewDir.vertical)
	self.chatRoomLayer:setContentSize(cc.size(var_0_9, var_0_10))
	self.chatRoomLayer:setInnerContainerSize(cc.size(var_0_9, var_0_10))
	self.chatRoomLayer:setPosition(cc.p(var_0_7, var_0_8))
	self.bg:addChild(self.chatRoomLayer)

	local var_5_0 = cc.Sprite:create("Map/associationbg2.png")

	var_5_0:setAnchorPoint(cc.p(0, 1))
	var_5_0:setPosition(cc.p(-27, var_0_10 + var_0_8))
	self.bg:addChild(var_5_0, 5)

	local var_5_1 = ccui.ListView:create()

	var_5_1:setContentSize(cc.size(97, var_0_10 + var_0_8))
	var_5_1:setDirection(ccui.ListViewDirection.vertical)
	self.bg:addChild(var_5_1, 6)

	self.asbuttons = {}

	for iter_5_2 = 1, 3 do
		local var_5_2 = ccui.Button:create("Map/associationbg3.png", "Map/associationbg3_on.png", "Map/associationbg3.png", var_0_2)
		local var_5_3 = cc.Label:createWithTTF(var_0_17[iter_5_2], "fonts/new.ttf", 30)

		var_5_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_3:setMaxLineWidth(30)
		var_5_3:setPosition(cc.p(var_5_2:getContentSize().width / 2, var_5_2:getContentSize().height / 2))
		var_5_2:addChild(var_5_3)
		var_5_1:pushBackCustomItem(var_5_2)

		self.asbuttons[iter_5_2] = var_5_2

		var_5_2:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_5_2 == self.currentIndex then
				return
			end

			self:switchList(iter_5_2)
		end)
	end

	self:initInputPanel()
	self:switchList(1)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		self.chatRoomLayer:scrollToBottom(0, false)
	end)))
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			self:unschedule()
		end
	end)
end

function ChatLayer:initInputPanel()
	self.inputControl = cc.EditBox:create(cc.size(320, 40), (cc.Scale9Sprite:create("Map/inputbox.png")))

	self.inputControl:setPosition(cc.p(270, 50))
	self.inputControl:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.inputControl:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	self.inputControl:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
	self.inputControl:setFont("fonts/new1.ttf")
	self.inputControl:setFontSize(20)
	self.bg:addChild(self.inputControl, 10)

	local var_9_0 = ccui.Button:create("Map/chat_button2.png", "Map/chat_button2_on.png", "Map/chat_button2.png", var_0_2)

	var_9_0:setPosition(cc.p(480, 50))
	self.bg:addChild(var_9_0, 10)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_10_0 = self.inputControl:getText()

		if not var_10_0 then
			global_ShowBlockWords(L_CHAT_MSG.Send_Nil, RISE_WORDS_FAIL)

			return
		end

		if string.len(var_10_0) <= 0 then
			global_ShowBlockWords(L_CHAT_MSG.Send_Nil, RISE_WORDS_FAIL)

			return
		end

		self:sendMsg(var_10_0)
		self.inputControl:setText("")
	end)

	local var_9_1 = ccui.Button:create("Map/shetuan.png", "Map/shetuan_on.png", "Map/shetuan.png")

	var_9_1:setPosition(cc.p(600, 50))
	self.bg:addChild(var_9_1)
	var_9_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showAssociationRoom(true)
	end)
end

function ChatLayer:sendMsg(arg_12_1)
	table.insert(var_0_16[self.currentIndex], {
		role = var_0_3,
		talk = arg_12_1,
		name = L_CHAT_MSG.Me
	})
	self:pushBackTalkSP((var_0_13(arg_12_1, L_CHAT_MSG.Me)))
end

function ChatLayer:pushBackTalkSP(arg_13_1)
	local var_13_0 = arg_13_1:getContentSize().height

	if #self.sps >= 50 then
		self.totalHeight = self.totalHeight - self.sps[1]:getContentSize().height - 10

		self.sps[1]:runAction(cc.RemoveSelf:create())
		table.remove(self.sps, 1)
	end

	for iter_13_0, iter_13_1 in pairs(self.sps) do
		iter_13_1:setPosition(cc.p(iter_13_1:getPositionX(), iter_13_1:getPositionY() + var_13_0 + 10))
	end

	self.totalHeight = self.totalHeight + var_13_0 + 10

	if self.totalHeight > var_0_10 then
		self.chatRoomLayer:setInnerContainerSize(cc.size(var_0_9, self.totalHeight))
	end

	table.insert(self.sps, arg_13_1)
	arg_13_1:setPosition(cc.p(0, 0))
	self.chatRoomLayer:addChild(arg_13_1)

	if self.chatRoomLayer:getInnerContainer():getPositionY() >= -100 then
		local var_13_1 = self.chatRoomLayer:getInnerContainer()

		var_13_1:setPosition(cc.p(var_13_1:getPositionX(), 0))
	end
end

function ChatLayer:switchList(arg_14_1)
	self:unschedule()
	self.chatRoomLayer:removeAllChildren()

	self.sps = {}
	self.totalHeight = 0
	self.currentIndex = arg_14_1
	self.list = var_0_16[arg_14_1]

	self:initCurrentlist(arg_14_1)
	self.inputControl:setText("")

	for iter_14_0, iter_14_1 in pairs(self.asbuttons) do
		if iter_14_0 == arg_14_1 then
			iter_14_1:loadTextures("Map/associationbg3_on.png", "Map/associationbg3_on.png", "Map/associationbg3.png", var_0_2)
		else
			iter_14_1:loadTextures("Map/associationbg3.png", "Map/associationbg3_on.png", "Map/associationbg3.png", var_0_2)
		end
	end

	self:schedule()
end

function ChatLayer:initCurrentlist(arg_15_1)
	for iter_15_0 = 1, #self.list do
		self:pushBackTalkSP(self.list[iter_15_0].role == var_0_3 and var_0_13(self.list[iter_15_0].talk, self.list[iter_15_0].name) or var_0_12(self.list[iter_15_0].talk, self.list[iter_15_0].name))
	end
end

function ChatLayer:schedule()
	local var_16_0 = var_0_14[self.currentIndex]
	local var_16_1 = var_0_15[self.currentIndex][var_0_14[self.currentIndex]].gap

	local function var_16_2(arg_17_0)
		if #var_0_16[self.currentIndex] >= 50 then
			table.remove(var_0_16[self.currentIndex], 1)
		end

		local var_17_0 = {
			role = var_0_4,
			talk = var_0_15[self.currentIndex][var_16_0].talk,
			name = var_0_15[self.currentIndex][var_16_0].name
		}

		table.insert(var_0_16[self.currentIndex], var_17_0)
		self:pushBackTalkSP((var_0_12(var_17_0.talk, var_17_0.name)))

		var_0_14[self.currentIndex] = var_0_14[self.currentIndex] + 1

		if var_0_14[self.currentIndex] <= #var_0_15[self.currentIndex] then
			var_0_14[self.currentIndex] = var_0_14[self.currentIndex] or 1
		end

		var_16_0 = var_0_14[self.currentIndex]
		var_16_1 = var_0_15[self.currentIndex][var_16_0].gap

		if self.scheduleid then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
		end

		self.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_16_2, var_16_1, false)
	end

	self.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_16_2, var_0_15[self.currentIndex][var_0_14[self.currentIndex]].gap, false)
end

function ChatLayer:unschedule()
	if self.scheduleid then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
	end
end

function ChatLayer:initLimitRoom()
	self.bg = ccui.ImageView:create("Map/jiesuo_bg2.png", var_0_2)

	self.bg:setScale9Enabled(true)
	self.bg:setCapInsets(cc.rect(20, 20, 10, 10))
	self.bg:setContentSize(cc.size(640, 410))
	self.bg:setAnchorPoint(cc.p(0.5, 0))
	self.bg:setPosition(cc.p(320, 50))
	self:addChild(self.bg, 1)

	local var_19_0 = cc.Label:createWithTTF(L_CHAT_MSG.Shetuan_Nil, "fonts/new1.ttf", 40)

	var_19_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_19_0:setPosition(cc.p(320, 230))
	self.bg:addChild(var_19_0)

	local var_19_1 = ccui.Button:create("Map/shetuan.png", "Map/shetuan_on.png", "Map/shetuan.png")

	var_19_1:setPosition(cc.p(320, 120))
	self.bg:addChild(var_19_1)
	var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showAssociationRoom(false)
	end)
end

local function var_0_18(arg_21_0, arg_21_1)
	local var_21_0 = ccui.ImageView:create("Map/popupbg2.png", var_0_2)

	var_21_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_21_1 = cc.Label:createWithTTF(social_data[arg_21_0].name, "fonts/new1.ttf", 30)

	var_21_1:setAnchorPoint(cc.p(0, 0))
	var_21_1:setPosition(cc.p(60, 50))
	var_21_0:addChild(var_21_1)

	local var_21_2 = cc.Label:createWithTTF("(" .. social_data[arg_21_0].nums_init .. "/" .. social_data[arg_21_0].nums_limit .. ")", "fonts/new1.ttf", 20)

	var_21_2:setAnchorPoint(cc.p(0, 0))
	var_21_2:setPosition(cc.p(70 + var_21_1:getContentSize().width, 50))
	var_21_0:addChild(var_21_2)

	local var_21_3 = cc.Label:createWithTTF(social_data[arg_21_0].talk, "fonts/new1.ttf", 20)

	var_21_3:setAnchorPoint(cc.p(0, 0))
	var_21_3:setPosition(cc.p(60, 20))
	var_21_0:addChild(var_21_3)

	if social_data[arg_21_0].nums_limit > social_data[arg_21_0].nums_init then
		local var_21_4 = ccui.Button:create("Map/join.png", "Map/join_on.png", "Map/join.png", var_0_2)

		var_21_4:setPosition(cc.p(400, 60))
		var_21_4:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_21_1 then
				global_ShowBlockWords(L_CHAT_MSG.Send_Application)
			else
				global_ShowBlockWords(L_CHAT_MSG.Cannot_Send_Application, RISE_WORDS_FAIL)
			end
		end)
		var_21_0:addChild(var_21_4)
	end

	return var_21_0
end

function ChatLayer:showAssociationRoom(arg_23_1)
	local var_23_0 = ccui.Layout:create()

	var_23_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_23_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_23_0:setContentSize(cc.size(640, 1136))
	var_23_0:setTouchEnabled(true)
	var_23_0:setCascadeOpacityEnabled(false)
	var_23_0:setBackGroundColorOpacity(240)
	self:addChild(var_23_0, 10)
	var_23_0:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_23_0:runAction(cc.RemoveSelf:create())
	end)

	local var_23_1 = cc.Scale9Sprite:create("Map/popupbg.png")

	var_23_1:setCapInsets(cc.rect(100, 32, 10, 10))
	var_23_1:setPreferredSize(cc.size(538, 835))
	var_23_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_1:setPosition(cc.p(320, 568))
	var_23_0:addChild(var_23_1, 5)

	local var_23_2 = ccui.ListView:create()

	var_23_2:setContentSize(cc.size(538, 835))
	var_23_2:setDirection(ccui.ListViewDirection.vertical)
	var_23_2:setPosition(cc.p(0, 0))
	var_23_1:addChild(var_23_2, 1)

	for iter_23_0 = 1, 23 do
		var_23_2:pushBackCustomItem((var_0_18(iter_23_0, arg_23_1)))
	end
end
