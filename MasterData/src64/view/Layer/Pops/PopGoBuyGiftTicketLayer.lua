PopGoBuyGiftTicketLayer = class("PopGoBuyGiftTicketLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

function PopGoBuyGiftTicketLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGoBuyGiftTicketLayer.new()

	var_2_0:judgeTargetlayer(arg_2_1)

	return var_2_0
end

function PopGoBuyGiftTicketLayer:judgeTargetlayer(arg_3_1)
	arg_3_1.targetlayer = arg_3_1.targetlayer or "SupermarketLayer"

	self:init(arg_3_1)
end

function PopGoBuyGiftTicketLayer:init(arg_4_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopGoBuyGiftTicketLayer.json" or "PopGoBuyGiftTicketLayer.ExportJson")

	self.rootLayer:setLocalZOrder(99)
	self:addChild(self.rootLayer)

	self.msg = arg_4_1
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom")
	self.confirm_button = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")

	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		arg_5_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.confirm_button:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchLayer()
	end)
	self.confirm_button:setPositionX(180)

	self.giftBtn = ccui.Button:create("public/button/btn_recharge_by_gift.png", nil, "public/button/btn_recharge_by_gift.png", var_0_0)

	self.giftBtn:setPosition(460, self.confirm_button:getPositionY())
	self.confirm_button:getParent():addChild(self.giftBtn)
	self.giftBtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)

		if require("model.playermodel").class < 4 then
			LayerManager:pushInLayer("PopSupermarketLayer")

			return
		elseif self.msg.jumpto then
			require("controller.goto_system_manager")
			goto_complete_system({
				jump_to_system = self.msg.jumpto
			})

			return
		end

		LayerManager:pushInLayer("PopSupermarketLayer", {
			tab = GO_BUY_TICKET_TAB
		})
	end)
end

function PopGoBuyGiftTicketLayer:switchLayer()
	LayerManager:removePopLayer(self.__queueindex)

	local var_9_0 = cc.EventCustom:new("switchShowLayer")

	var_9_0.layerName = self.msg.targetlayer

	if self.msg.targetlayer == "PopSupermarketLayer" then
		LayerManager:pushInLayer("PopSupermarketLayer", {
			initSelectPage = 15,
			callback = self.msg.callback
		})
	else
		var_9_0.initparam = LayerManager:getActiveLayerName()
		var_9_0.returnLayer = TopcostLayer.runninglayer

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_9_0)
	end
end

function PopGoBuyGiftTicketLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
