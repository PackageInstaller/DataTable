local pop_layer_infos = require("controller.layerconfig.pop_layer_infos")

local function var_0_1(arg_1_0, arg_1_1)
	hx_print("层名:" .. arg_1_0, CONSOLE_COLOR_LIGHT_GOLD)

	arg_1_1 = arg_1_1 or ({
		FightLayer = {
			"FightLayer"
		}
	})[arg_1_0]

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			hx_print("UI文件夹:" .. "../CocosRes_source/" .. iter_1_1, CONSOLE_COLOR_LIGHT_GOLD)
		end
	end
end

local function var_0_2(arg_2_0)
	if not arg_2_0 then
		return nil
	end

	return pop_layer_infos[arg_2_0]
end

function SwitchManageLayer.loadPopLayerTexture(arg_3_0, arg_3_1)
	local var_3_0 = var_0_2(arg_3_1)

	if var_3_0 == nil then
		return
	end

	TextureManager:loadPopLayerTextures(var_3_0.textures)
end

function SwitchManageLayer:addPopLayer(arg_4_1, ...)
	local var_4_0 = var_0_2(arg_4_1)

	if var_4_0 == nil then
		return
	end

	self:loadPopLayerTexture(arg_4_1)

	local var_4_1 = var_4_0.createLayer(...)
	local var_4_2 = 1

	if #self._poplayer.queue > 0 then
		var_4_2 = self._poplayer.queue[#self._poplayer.queue]:getLocalZOrder() + 1
	end

	var_4_1:setName(arg_4_1)
	self._poplayer:addChild(var_4_1, var_4_2)
	var_0_1(arg_4_1, var_4_0.textures)

	return var_4_1
end

function SwitchManageLayer:deletePopLayer(arg_5_1)
	arg_5_1 = arg_5_1 or #self._poplayer.queue

	if arg_5_1 == 0 then
		return
	end

	local var_5_0 = self._poplayer.queue:remove(arg_5_1)

	GuideListener.swallowEvent(true)
	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()

	if var_5_0 then
		local LocalEvent = require("common.LocalEvent")

		LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, {
			name = var_5_0:getName()
		})
		var_5_0:runAction(cc.RemoveSelf:create())
	end

	if self:checkPopShowUI() then
		self:showUILayer()
		self:showPlotLayer()
	end

	self:updateTipsLayerZOrder()
end

function SwitchManageLayer:pushInLayer(arg_6_1, ...)
	if not arg_6_1 then
		return
	end

	if not pop_layer_infos[arg_6_1] then
		return
	end

	print("pushInLayer: ", arg_6_1)

	local var_6_0 = var_0_2(arg_6_1)

	self:checkResource(arg_6_1, var_6_0.checktextures or var_6_0.textures, "POPLAYER", ...)
end

function SwitchManageLayer:doPushInLayer(arg_7_1, ...)
	if not arg_7_1 then
		return
	end

	if not pop_layer_infos[arg_7_1] then
		return
	end

	local var_7_0 = self:addPopLayer(arg_7_1, ...)

	if not var_7_0 then
		return
	end

	if pop_layer_infos[arg_7_1].hideUI then
		for iter_7_0, iter_7_1 in pairs(self._poplayer.queue) do
			iter_7_1:setVisible(false)
		end
	end

	self._poplayer.queue:insert(var_7_0)

	var_7_0._poplayername = arg_7_1

	self:updateTipsLayerZOrder()
	self:hidePlotLayer()

	if pop_layer_infos[arg_7_1].hideUI then
		self:hideUILayer(pop_layer_infos[arg_7_1].bg)
	else
		self:showUnderLayerWithPop()
	end

	GuideListener.swallowEvent(true)
	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()

	if var_7_0.updateGuidesOnLayer then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			GuideListener.swallowEvent(false)
		end)))
	else
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			GuideListener.cleanCurGuides()
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(var_7_0)
		end)))
	end

	return var_7_0
end

function SwitchManageLayer:cleanPopLayer()
	local LocalEvent = require("common.LocalEvent")

	for iter_10_0, iter_10_1 in ipairs(self._poplayer.queue) do
		LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, {
			name = iter_10_1:getName()
		})
		iter_10_1:removeFromParent()

		self._poplayer.queue[iter_10_0] = nil
	end

	TextureManager:unloadPopLayerTextures()
end

function SwitchManageLayer:checkPopShowUI()
	if #self._poplayer.queue > 0 then
		KeyCodeManager:setLock(true)

		local var_11_0 = self._poplayer.queue[#self._poplayer.queue]

		self._poplayer.queue[#self._poplayer.queue]:setVisible(true)

		if pop_layer_infos[self._poplayer.queue[#self._poplayer.queue]._poplayername].hideUI then
			self:hideUILayer(pop_layer_infos[self._poplayer.queue[#self._poplayer.queue]._poplayername].bg)
		else
			self:showUnderLayerWithPop()
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			GuideListener.cleanCurGuides()
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(var_11_0)
			KeyCodeManager:setLock(false)
		end)))

		return false
	end

	return true
end

function SwitchManageLayer:hideUILayer(arg_13_1)
	self._uilayer:setVisible(false)
	self:switchBg(arg_13_1)
end

function SwitchManageLayer:showUILayerWithPop()
	self._uilayer:setVisible(true)
	self:switchBg(self:getActiveLayerBg())
end

function SwitchManageLayer:showUnderLayerWithPop()
	local var_15_0 = true

	for iter_15_0 = #self._poplayer.queue, 1, -1 do
		self._poplayer.queue[iter_15_0]:setVisible(true)

		if pop_layer_infos[self._poplayer.queue[iter_15_0]._poplayername].hideUI then
			self:hideUILayer(pop_layer_infos[self._poplayer.queue[iter_15_0]._poplayername].bg)

			var_15_0 = false

			break
		end
	end

	if var_15_0 then
		self:showUILayerWithPop()
	end
end

function SwitchManageLayer:showUILayer()
	KeyCodeManager:setLock(true)
	self._uilayer:setVisible(true)
	self:switchBg(self:getActiveLayerBg())
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		GuideListener.swallowEvent(false)

		if LayerManager:getActiveLayerName() ~= "TwisteggLayer" then
			GuideListener.cleanCurGuides()
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(LayerManager:getCurrentLayerObj())
		end

		KeyCodeManager:setLock(false)
	end)))
end

function SwitchManageLayer:hidePlotLayer()
	self._plotlayer:setVisible(false)
end

function SwitchManageLayer:showPlotLayer()
	self._plotlayer:setVisible(true)
end

function SwitchManageLayer:getTopPopLayer()
	return self._poplayer.queue[#self._poplayer.queue]
end

function SwitchManageLayer:isShowPopLayer()
	return #self._poplayer.queue > 0
end

function SwitchManageLayer:getTipsLayer()
	return self._tipslayer
end

function SwitchManageLayer:getTopFullPopLayerZOrder()
	local var_23_0

	for iter_23_0, iter_23_1 in pairs(self._poplayer.queue) do
		var_23_0 = var_23_0 and math.max(var_23_0, iter_23_1:getLocalZOrder() + 1) or iter_23_1:getLocalZOrder()
	end

	return var_23_0
end

function SwitchManageLayer:updateTipsLayerZOrder()
	local var_24_0 = self:getTopFullPopLayerZOrder()

	if var_24_0 then
		self._tipslayer:setLocalZOrder(var_24_0 + 1)
	else
		self._tipslayer:setLocalZOrder(1)
	end
end

function SwitchManageLayer.createFullScreenMask(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_2 = arg_25_2 or 200

	local var_25_0 = ccui.Layout:create()

	var_25_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_0:setName("fullScreenMask")
	var_25_0:setBackGroundColorType(arg_25_4 or ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_25_0:setBackGroundColorOpacity(arg_25_2)

	if arg_25_4 == ccui.LayoutBackGroundColorType.none then
		var_25_0:setBackGroundColorOpacity(255)
	end

	var_25_0:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	var_25_0:setTouchEnabled(true)
	var_25_0:addTouchEventListener(arg_25_3)
	arg_25_1:addChild(var_25_0)
end

function SwitchManageLayer:isShowPopLayerWithLayerName(arg_26_1)
	if self._poplayer.queue and next(self._poplayer.queue) then
		for iter_26_0, iter_26_1 in pairs(self._poplayer.queue) do
			if iter_26_1:getName() == arg_26_1 then
				return true
			end
		end
	end

	return false
end

function SwitchManageLayer:getPopLayerWithLayerName(arg_27_1)
	if self._poplayer.queue and next(self._poplayer.queue) then
		for iter_27_0, iter_27_1 in pairs(self._poplayer.queue) do
			if iter_27_1:getName() == arg_27_1 then
				return iter_27_1
			end
		end
	end

	return nil
end
