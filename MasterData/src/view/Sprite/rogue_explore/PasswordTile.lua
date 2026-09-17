local TileSprite = require("view.Sprite.explore.TileSprite")
local PasswordTile = class("PasswordTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
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

function PasswordTile:create(arg_2_1)
	local var_2_0 = PasswordTile.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PasswordTile:initother()
	return
end

function PasswordTile:checkTriggerPrecondition()
	local var_4_0

	if self.tileInfo.result1_type then
		local var_4_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

		var_4_0 = {
			type = self.tileInfo["result" .. var_4_1 .. "_type"],
			param = self.tileInfo["result" .. var_4_1 .. "_param"],
			des = self.tileInfo["result" .. var_4_1 .. "_des"],
			result_count = var_4_1
		}
	else
		var_4_0 = {}
	end

	if self:checkTriggerEvent() then
		self:runTriggerEvent(function()
			LayerManager:pushInLayer("PopPasswordLayer", {
				runTileEvent = function()
					self:runTileEvent(var_4_0)
				end,
				exitCallback = function()
					self.parent.root.touchLock = false
				end,
				tileInfo = self.tileInfo
			})
		end)
	else
		local var_4_2 = {}

		function var_4_2.runTileEvent()
			self:runTileEvent(var_4_0)
		end

		function var_4_2.exitCallback()
			self.parent.root.touchLock = false
		end

		var_4_2.tileInfo = self.tileInfo

		LayerManager:pushInLayer("PopPasswordLayer", var_4_2)
	end
end

function PasswordTile:checkTriggerEvent()
	return self.tileInfo.trigger_talk or self.tileInfo.trigger_theater
end

function PasswordTile:runTriggerEvent(arg_11_1)
	if self.tileInfo.trigger_talk then
		global_basic_scene:addChild(self.tileInfo.trigger_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_talk, nil, 1, "", arg_11_1) or ExploreTalkLayer:create({
			classification = self.tileInfo.trigger_talk,
			finishCallback = arg_11_1
		}), ZORDER_TALKLAYER)
	elseif self.tileInfo.trigger_theater then
		local var_11_1 = explore_manager:createDirectory(self.tileInfo.trigger_theater)

		var_11_1:registerExitEvent(arg_11_1)
		var_11_1:startPlay()
	end
end

function PasswordTile:runTileEvent(arg_12_1, arg_12_2)
	(function()
		local var_13_0
		local var_13_1
		local var_13_2

		if arg_12_1 then
			var_13_0 = arg_12_1.type
			var_13_1 = arg_12_1.param
			var_13_2 = arg_12_1.des
		end

		local var_13_5 = {
			room_order = self.parent.curRoomOrder,
			object_idx = self.idx,
			result_type = var_13_0,
			result_param = var_13_1,
			result_des = var_13_2,
			result_count = arg_12_1.result_count
		}

		explore_manager:trigger_event(var_13_5, function(arg_14_0)
			if arg_14_0.result > 0 then
				if not self:checkResultEvent() then
					self:updateState()

					if self.controller_idx then
						self:trigger_controller()
					end

					if self.finishCallback then
						self.finishCallback({
							tileInfo = self.tileInfo,
							msg = arg_14_0,
							eventconfig = var_13_5
						})
					end
				else
					local var_14_0 = self.finishCallback
					local var_14_1 = {
						tileInfo = self.tileInfo,
						msg = arg_14_0,
						eventconfig = var_13_5
					}

					self:runResultEvent(function()
						self:updateState()

						if self.controller_idx then
							self:trigger_controller()
						end

						if var_14_0 then
							var_14_0(var_14_1)
						end
					end)
				end
			elseif self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_14_0,
					eventconfig = var_13_5
				})
			end
		end)
	end)()
end

function PasswordTile:pop_password(arg_16_1)
	self.confirm = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_PasswordPanel.json" or "Pop_PasswordPanel.ExportJson")

	self:initUI(arg_16_1)
	ccui.Helper:seekWidgetByName(self.confirm, "Button_num"):setVisible(false)

	return self.confirm
end

function PasswordTile:initStrNum()
	self.lenPass = string.len(self.tileInfo.trigger_param1)

	local var_17_0 = ""

	for iter_17_0 = 1, self.lenPass do
		var_17_0 = var_17_0 .. " _"
	end

	ccui.Helper:seekWidgetByName(self.confirm, "Label_num"):setString(var_17_0)
end

function PasswordTile:initStackNum()
	self.stackNum = {}
end

function PasswordTile:pushStackNum(arg_19_1)
	self.stackNum[#self.stackNum + 1] = arg_19_1
end

function PasswordTile:popStackNum()
	if self.stackNum and next(self.stackNum) ~= nil then
		table.remove(self.stackNum, #self.stackNum)
	end
end

function PasswordTile:getStackNumSzie()
	if self.stackNum and next(self.stackNum) ~= nil then
		return #self.stackNum
	end

	return 0
end

function PasswordTile:clearStackNumSzie()
	self.stackNum = {}
end

function PasswordTile:updateStrNum()
	local var_23_0 = ccui.Helper:seekWidgetByName(self.confirm, "Label_num")

	if var_23_0:getString() == "ERROR" then
		var_23_0:setString("")
	end

	local var_23_1 = ""

	for iter_23_0 = 1, self.lenPass - self:getStackNumSzie() do
		var_23_1 = var_23_1 .. " _"
	end

	local var_23_2 = ""

	for iter_23_1 = 1, self:getStackNumSzie() do
		var_23_2 = var_23_2 .. " " .. self.stackNum[iter_23_1]
	end

	var_23_0:setString(var_23_1 .. var_23_2)
end

function PasswordTile:getStrNum()
	local var_24_0 = ccui.Helper:seekWidgetByName(self.confirm, "Label_num"):getString()
	local var_24_1 = ""

	for iter_24_0 = 1, string.len(var_24_0) do
		local var_24_2 = string.sub(var_24_0, iter_24_0, iter_24_0)

		if string.byte(var_24_2) >= 48 and string.byte(var_24_2) <= 57 then
			var_24_1 = var_24_1 .. var_24_2
		end
	end

	return var_24_1
end

function PasswordTile:initUI(arg_25_1)
	self:initStrNum()
	self:initStackNum()

	local var_25_0 = ccui.Helper:seekWidgetByName(self.confirm, "Button_num")
	local var_25_1 = ccui.Helper:seekWidgetByName(self.confirm, "Image_bottom")
	local var_25_2 = ccui.Helper:seekWidgetByName(self.confirm, "Label_num")

	self.strNum = var_25_2:getString()

	local var_25_3 = var_25_0:getPositionX()
	local var_25_4 = var_25_0:getPositionY()

	originX = var_25_3

	for iter_25_0 = 1, 9 do
		local var_25_5 = var_25_0:clone()

		var_25_5:setName(iter_25_0)
		var_25_5:getChildByName("Label_1"):setString(iter_25_0)
		var_25_5:setPosition(cc.p(var_25_3, var_25_4))

		var_25_3 = var_25_3 + var_25_0:getContentSize().width + 8

		if iter_25_0 % 3 == 0 then
			var_25_4 = var_25_4 - var_25_0:getContentSize().height - 4
			var_25_3 = originX
		end

		var_25_1:addChild(var_25_5, 99)
		var_25_5:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not string.find(var_25_2:getString(), "_") and var_25_2:getString() ~= "ERROR" then
				return
			end

			self:pushStackNum(arg_26_0:getName())
			self:updateStrNum()
		end)
	end

	local var_25_6 = ccui.Helper:seekWidgetByName(self.confirm, "Button_0")

	var_25_6:setName("0")
	var_25_6:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not string.find(var_25_2:getString(), "_") and var_25_2:getString() ~= "ERROR" then
			return
		end

		self:pushStackNum(arg_27_0:getName())
		self:updateStrNum()
	end)
	ccui.Helper:seekWidgetByName(self.confirm, "Button_delete"):addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if string.len(self.strNum) <= 1 then
			self:initStrNum()
		else
			self:popStackNum()
			self:updateStrNum()
		end
	end)
	ccui.Helper:seekWidgetByName(self.confirm, "Button_sure"):addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getStrNum() == tostring(self.tileInfo.trigger_param1) then
			self:runTileEvent(arg_25_1)
			self.confirm:runAction(cc.RemoveSelf:create())

			self.parent.root.touchLock = false
		else
			audio_manager:playeffectMusicTest("sound/invalid")
			global_ShowBlockWords("密码输入错误！")
			var_25_2:setString("ERROR")
			self:clearStackNumSzie()
		end
	end)

	local var_25_7 = ccui.Helper:seekWidgetByName(self.confirm, "Panel_back")

	var_25_7:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.confirm:runAction(cc.RemoveSelf:create())

		self.parent.root.touchLock = false
	end)
	var_25_7:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_7:setPositionY(-GameDisplay.fix_y)
end

return PasswordTile
