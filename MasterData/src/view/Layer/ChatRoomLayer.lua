ChatRoomLayer = class("ChatRoomLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")

ChatRoomLayer.UIText = nil
ChatRoomLayer.LeftPlayer = nil
ChatRoomLayer.RightPlayer = nil
ChatRoomLayer.lineNum = nil
ChatRoomLayer.dialogTabel = {}
ChatRoomLayer.finishCallBack = nil

function ChatRoomLayer.create(arg_2_0)
	local var_2_0 = ChatRoomLayer.new()

	var_2_0:init()

	return var_2_0
end

function ChatRoomLayer:init()
	local var_3_0 = ccs.GUIReader:getInstance():widgetFromJsonFile("CocosRes/ChatRoom.json")

	self:addChild(var_3_0)

	self.InputText = ccui.Helper:seekWidgetByName(var_3_0, "chatmsg")
	self.listview = ccui.Helper:seekWidgetByName(var_3_0, "chatlist")
	self.okButton = ccui.Helper:seekWidgetByName(var_3_0, "button_ok")
	buttonHide = ccui.Helper:seekWidgetByName(var_3_0, "button_hide")
	self.panelExp = ccui.Helper:seekWidgetByName(var_3_0, "panel_exp")

	self.panelExp:retain()
	self.listview:removeItem(0)

	local var_3_1 = {
		"小明",
		"佳俊小红",
		"陆地小黑",
		"小狗",
		"丹丹小青蛙",
		"陈睿小芝麻",
		"小飞机",
		"晶晶大白"
	}
	local var_3_2 = var_3_1[math.random(#var_3_1)] .. math.random(100) .. "  "

	function sendMeg(arg_4_0, arg_4_1)
		if arg_4_1 == ccui.TouchEventType.ended and self.InputText:getStringValue() ~= "" then
			network:rpc("chat", {
				msg = self.InputText:getStringValue(),
				name = var_3_2
			}, function()
				return
			end)
			self.InputText:setText("")
		end
	end

	self.okButton:addTouchEventListener(sendMeg)
	net_dispatcher:registerListener(function(arg_6_0)
		if self == nil then
			return
		end

		local var_6_0 = self.panelExp:clone()
		local playermodel = require("model.playermodel")

		var_6_0:getChildByName("username"):setString(arg_6_0.name .. string.sub(arg_6_0.time, 11, 19))
		var_6_0:getChildByName("msg"):setString(arg_6_0.msg)
		self.listview:pushBackCustomItem(var_6_0)

		if 10 < self.listview:getChildrenCount() then
			for iter_6_0 = 1, self.listview:getChildrenCount() - 10 do
				self.listview:removeItem(0)
			end
		end

		self.listview:refreshView()
		self.listview:getInnerContainer():setPosition(0, 0)
	end, "chatting")

	function hideOrShow(arg_7_0, arg_7_1)
		if arg_7_1 == ccui.TouchEventType.ended then
			local var_7_0 = ccui.Helper:seekWidgetByName(var_3_0, "chat_back")

			var_7_0:setPositionX(0 - var_7_0:getPositionX())
		end
	end

	buttonHide:addTouchEventListener(hideOrShow)

	return true
end
