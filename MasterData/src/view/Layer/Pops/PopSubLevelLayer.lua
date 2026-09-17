PopSubLevelLayer = class("PopSubLevelLayer", function()
	return PopBaseLayer:create()
end)

function PopSubLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSubLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")

function PopSubLevelLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSubLevelLayer.json" or "PopSubLevelLayer.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	self.msg = arg_3_1
	self.sureCallback = arg_3_1.sureCallback

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self.showActions.extendVertical(self)
	self:initData()
	self:initSureBtn()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

local var_0_5 = {
	"等级100",
	"等级150",
	"等级200",
	"等级250",
	"等级300",
	"等级350",
	"等级400",
	"等级450",
	"等级500",
	"等级600",
	"等级650",
	"等级700",
	"等级750",
	"等级800",
	"等级850",
	"等级900"
}

function PopSubLevelLayer:initData()
	self.level = self.msg.level or 1
	self.levelTable = {}

	for iter_7_0, iter_7_1 in pairs(ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_12"):getChildren()) do
		self.levelTable[#self.levelTable + 1] = iter_7_1
	end

	self.middle = math.ceil(#self.levelTable / 2)

	for iter_7_2, iter_7_3 in pairs(self.levelTable) do
		local var_7_0 = string.split(iter_7_3:getName(), "_")[2]

		iter_7_3:setOpacity(255 * (1 - math.abs(self.middle - tonumber(var_7_0)) / self.middle))
		iter_7_3:setFontSize(20 - math.abs(self.middle - tonumber(var_7_0)))
	end

	self:updateLevel()
	self:panelMove()
end

function PopSubLevelLayer:updateLevel()
	for iter_8_0, iter_8_1 in pairs(self.levelTable) do
		local var_8_0 = tonumber(string.split(iter_8_1:getName(), "_")[2])

		if var_0_5[var_8_0 - self.middle + self.level] then
			iter_8_1:setString(var_0_5[var_8_0 - self.middle + self.level])
		else
			iter_8_1:setString("")
		end
	end
end

function PopSubLevelLayer:panelMove()
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_12")
	local var_9_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_select"):getContentSize().height
	local var_9_2 = var_9_0:getPositionY()
	local var_9_3
	local var_9_4
	local var_9_5 = false
	local var_9_6

	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 == ccui.TouchEventType.began then
			var_9_3 = arg_10_0:getTouchBeganPosition()
			var_9_5 = true
		elseif arg_10_1 == ccui.TouchEventType.moved then
			if var_9_5 == true then
				var_9_4 = arg_10_0:getTouchMovePosition()
				var_9_6 = var_9_4.y - var_9_3.y
				var_9_3 = var_9_4

				arg_10_0:setPositionY(arg_10_0:getPositionY() + var_9_6)

				if math.abs(var_9_2 - arg_10_0:getPositionY()) >= var_9_1 then
					self.level = var_9_2 - arg_10_0:getPositionY() < 0 and self.level + 1 or self.level - 1

					if self.level > 0 and self.level <= #var_0_5 then
						self:updateLevel()
					end

					if self.level <= 1 then
						self.level = 1
					end

					if self.level > #var_0_5 then
						self.level = #var_0_5
					end

					arg_10_0:setPositionY(var_9_2)
				end
			end
		elseif arg_10_1 == ccui.TouchEventType.canceled then
			var_9_5 = false

			arg_10_0:setPositionY(var_9_2)
		elseif arg_10_1 == ccui.TouchEventType.ended then
			var_9_5 = false

			arg_10_0:setPositionY(var_9_2)
		end
	end)
end

function PopSubLevelLayer:initSureBtn()
	ccui.Helper:seekWidgetByName(self.rootlayer, "Button_sure"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.msg and self.msg.sureCallback then
				self.msg.sureCallback(self.level)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopSubLevelLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.msg and self.msg.callback then
			self.msg.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
