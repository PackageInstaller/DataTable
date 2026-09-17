PopGoBuyDiamond = class("PopGoBuyDiamond", function()
	return PopBaseLayer:create()
end)

function PopGoBuyDiamond.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGoBuyDiamond.new()

	var_2_0:judgeTargetlayer(arg_2_1)

	return var_2_0
end

function PopGoBuyDiamond:judgeTargetlayer(arg_3_1)
	if arg_3_1.is_need_pop_layer == 1 then
		arg_3_1.targetlayer = "PopSupermarketLayer"
	elseif arg_3_1.is_need_pop_layer == 0 then
		arg_3_1.targetlayer = "SupermarketLayer"
	end

	self:init(arg_3_1)
end

function PopGoBuyDiamond:init(arg_4_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Cost_confirm_New.json" or "Cost_confirm_New.ExportJson")

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

		self:switchLayer(arg_4_1)
	end)
end

function PopGoBuyDiamond:switchLayer(arg_8_1)
	if arg_8_1.targetlayer ~= nil then
		LayerManager:removePopLayer(self.__queueindex)

		local var_8_0 = cc.EventCustom:new("switchShowLayer")

		var_8_0.layerName = arg_8_1.targetlayer

		if arg_8_1.targetlayer == "PopSupermarketLayer" then
			LayerManager:pushInLayer("PopSupermarketLayer", {
				initSelectPage = 2,
				callback = arg_8_1.callback
			})
		else
			var_8_0.initparam = LayerManager:getActiveLayerName()
			var_8_0.returnLayer = TopcostLayer.runninglayer

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_8_0)
		end
	end

	if arg_8_1.releaselayer then
		arg_8_1.releaselayer:removeSelf()

		arg_8_1.releaselayer = nil
	end

	if arg_8_1.releaseCallback then
		arg_8_1.releaseCallback()
	end
end

function PopGoBuyDiamond:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
