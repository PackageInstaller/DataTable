PopPasswordLayer = class("PopPasswordLayer", function()
	return PopBaseLayer:create()
end)

local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")

function PopPasswordLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPasswordLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPasswordLayer:init(arg_3_1)
	print("1111111111111111111111111111111111111")

	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_PasswordPanel.json" or "Pop_PasswordPanel.ExportJson")

	self:addChild(self.rootlayer, 99)

	self.runTileEvent = arg_3_1.runTileEvent
	self.exitCallback = arg_3_1.exitCallback
	self.tileInfo = arg_3_1.tileInfo

	self:initUI()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Button_num"):setVisible(false)
end

function PopPasswordLayer:initStrNum()
	self.lenPass = string.len(self.tileInfo.trigger_param1)

	local var_4_0 = ""

	for iter_4_0 = 1, self.lenPass do
		var_4_0 = var_4_0 .. " _"
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_num"):setString(var_4_0)
end

function PopPasswordLayer.initStackNum(arg_5_0)
	arg_5_0.stackNum = {}
end

function PopPasswordLayer:pushStackNum(arg_6_1)
	self.stackNum[#self.stackNum + 1] = arg_6_1
end

function PopPasswordLayer:popStackNum()
	if self.stackNum and next(self.stackNum) ~= nil then
		table.remove(self.stackNum, #self.stackNum)
	end
end

function PopPasswordLayer:getStackNumSzie()
	if self.stackNum and next(self.stackNum) ~= nil then
		return #self.stackNum
	end

	return 0
end

function PopPasswordLayer.clearStackNumSzie(arg_9_0)
	arg_9_0.stackNum = {}
end

function PopPasswordLayer:updateStrNum()
	local var_10_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_num")

	if var_10_0:getString() == "ERROR" then
		var_10_0:setString("")
	end

	local var_10_1 = ""

	for iter_10_0 = 1, self.lenPass - self:getStackNumSzie() do
		var_10_1 = var_10_1 .. " _"
	end

	local var_10_2 = ""

	for iter_10_1 = 1, self:getStackNumSzie() do
		var_10_2 = var_10_2 .. " " .. self.stackNum[iter_10_1]
	end

	var_10_0:setString(var_10_1 .. var_10_2)
end

function PopPasswordLayer:getStrNum()
	local var_11_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_num"):getString()
	local var_11_1 = ""

	for iter_11_0 = 1, string.len(var_11_0) do
		local var_11_2 = string.sub(var_11_0, iter_11_0, iter_11_0)

		if string.byte(var_11_2) >= 48 and string.byte(var_11_2) <= 57 then
			var_11_1 = var_11_1 .. var_11_2
		end
	end

	return var_11_1
end

function PopPasswordLayer:initUI()
	self:initStrNum()
	self:initStackNum()

	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_num")
	local var_12_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")
	local var_12_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_num")

	self.strNum = var_12_2:getString()

	local var_12_3 = var_12_0:getPositionX()
	local var_12_4 = var_12_0:getPositionY()

	originX = var_12_3

	for iter_12_0 = 1, 9 do
		local var_12_5 = var_12_0:clone()

		var_12_5:setName(iter_12_0)
		var_12_5:getChildByName("Label_1"):setString(iter_12_0)
		var_12_5:setPosition(cc.p(var_12_3, var_12_4))

		var_12_3 = var_12_3 + var_12_0:getContentSize().width + 8

		if iter_12_0 % 3 == 0 then
			var_12_4 = var_12_4 - var_12_0:getContentSize().height - 4
			var_12_3 = originX
		end

		var_12_1:addChild(var_12_5, 99)
		var_12_5:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not string.find(var_12_2:getString(), "_") and var_12_2:getString() ~= "ERROR" then
				return
			end

			self:pushStackNum(arg_13_0:getName())
			self:updateStrNum()
		end)
	end

	local var_12_6 = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_0")

	var_12_6:setName("0")
	var_12_6:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not string.find(var_12_2:getString(), "_") and var_12_2:getString() ~= "ERROR" then
			return
		end

		self:pushStackNum(arg_14_0:getName())
		self:updateStrNum()
	end)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Button_delete"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if string.len(self.strNum) <= 1 then
			self:initStrNum()
		else
			self:popStackNum()
			self:updateStrNum()
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Button_sure"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getStrNum() == tostring(self.tileInfo.trigger_param1) then
			if self.exitCallback then
				self.exitCallback()
			end

			if self.runTileEvent then
				self.runTileEvent()
			end

			LayerManager:removePopLayer()
		else
			audio_manager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords("密码输入错误！")
			var_12_2:setString("ERROR")
			self:clearStackNumSzie()
		end
	end)

	local var_12_7 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	var_12_7:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		end

		LayerManager:removePopLayer()
	end)
	var_12_7:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_7:setPositionY(-GameDisplay.fix_y)
end
