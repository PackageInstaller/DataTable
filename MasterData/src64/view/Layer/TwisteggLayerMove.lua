local time_check_manager = require("controller.time_check_manager")
local tween = require("fight.tween")
local var_0_2 = {
	4,
	6,
	8
}
local var_0_3 = 4
local var_0_4 = {
	btn_detail = 3,
	image_rarity = 3,
	image_bg = 1,
	image_title = 3,
	image_main = 2
}
local var_0_5 = 0.796875
local var_0_7 = 640 + 150
local var_0_8 = 0.5

function TwisteggLayer:initCachePanelPosList()
	self.cachePanelOrigPos = {}

	for iter_1_0, iter_1_1 in pairs(self.clipPanel:getChildren()) do
		self.cachePanelOrigPos[iter_1_1:getName()] = iter_1_1:getPositionX()
	end

	self:initCachePanelDefaultPos()
	self:setCachePanelDefault()
end

function TwisteggLayer:initCachePanelDefaultPos()
	self.cachePanelFinalPos = {}

	for iter_2_0 = -1, 1 do
		local var_2_0 = {}

		for iter_2_1, iter_2_2 in pairs(var_0_4) do
			var_2_0[iter_2_1] = iter_2_0 * (var_0_2[iter_2_2] / var_0_3) * var_0_7 + self.cachePanelOrigPos[iter_2_1]
		end

		table.insert(self.cachePanelFinalPos, var_2_0)
	end
end

function TwisteggLayer:setCachePanelDefault()
	for iter_3_0, iter_3_1 in pairs({
		1,
		3
	}) do
		for iter_3_2, iter_3_3 in pairs(self.cachePanelFinalPos[iter_3_1]) do
			self.cachePanelList[iter_3_1]:getChildByName(iter_3_2):setPositionX(iter_3_3 - self.cachePanelList[iter_3_1]:getPositionX())
		end

		if self.cachePanelList[iter_3_1]:getChildByName("rightBtnListPanel") then
			self.cachePanelList[iter_3_1]:getChildByName("rightBtnListPanel"):setVisible(false)
			self.cachePanelList[iter_3_1]:getChildByName("rightBtnListPanel"):setOpacity(0)
			self.cachePanelList[iter_3_1]:getChildByName("rightBtnListPanel"):setPositionX(640 - self.cachePanelList[iter_3_1]:getPositionX())
		end

		if self.cachePanelList[iter_3_1]:getChildByName("overclock") then
			self.cachePanelList[iter_3_1]:getChildByName("overclock"):setVisible(false)
			self.cachePanelList[iter_3_1]:getChildByName("overclock"):setPositionX(-self.cachePanelList[iter_3_1]:getPositionX())
		end
	end

	self.oneBtn:setOpacity(255)
	self.tenBtn:setOpacity(255)

	if self.cachePanelList[2]:getChildByName("rightBtnListPanel") then
		self.cachePanelList[2]:getChildByName("rightBtnListPanel"):setVisible(true)
		self.cachePanelList[2]:getChildByName("rightBtnListPanel"):setOpacity(255)
		self.cachePanelList[2]:getChildByName("rightBtnListPanel"):setPositionX(640 - self.cachePanelList[2]:getPositionX())
	end

	if self.cachePanelList[2]:getChildByName("overclock") then
		self.cachePanelList[2]:getChildByName("overclock"):setVisible(true)
		self.cachePanelList[2]:getChildByName("overclock"):setOpacity(255)
		self.cachePanelList[2]:getChildByName("overclock"):setPositionX(-self.cachePanelList[2]:getPositionX())
	end
end

function TwisteggLayer:registerTouchEvent()
	self.touchPanel = self:createTouchPanel()

	self.touchPanel:setTouchEnabled(false)

	self._controlPoint = 0
	self._isCachePanelInAnim = false
	self._autoscroll = false
	self._autoscrollaction = nil
	self._autoscrollpos = nil

	local var_4_0 = cc.EventListenerTouchOneByOne:create()

	var_4_0:setSwallowTouches(false)
	var_4_0:registerScriptHandler(function(arg_5_0, arg_5_1)
		if not self:checkTouchEnabled() then
			return false
		else
			self.startTime = os.clock()

			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_4_0:registerScriptHandler(function(arg_6_0, arg_6_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleMoveLogic(arg_6_0)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_4_0:registerScriptHandler(function(arg_7_0, arg_7_1)
		if not self:checkTouchEnabled() then
			return
		end

		self.startTime = 0

		self:handleReleaseLogic(arg_7_0, os.clock() - self.startTime)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_4_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		if not self:checkTouchEnabled() then
			return
		end

		self.startTime = 0

		self:handleReleaseLogic(arg_8_0, os.clock() - self.startTime)
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_4_0, self.touchPanel)
	self:registerCachePanelUpdateEvent()
end

function TwisteggLayer:createTouchPanel()
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(self.clipPanel:getContentSize())
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_9_0:setAnchorPoint(0, 0)
	var_9_0:setTouchEnabled(true)
	var_9_0:setPosition(cc.p(0, 0))
	self.clipPanel:addChild(var_9_0, 15)

	return var_9_0
end

function TwisteggLayer:checkTouchEnabled()
	if self._isCachePanelInAnim then
		return false
	end

	return true
end

function TwisteggLayer:handleMoveLogic(arg_11_1)
	local var_11_0 = arg_11_1:getLocation().x - arg_11_1:getPreviousLocation().x
	local var_11_1 = arg_11_1:getLocation().x - arg_11_1:getStartLocation().x

	if math.abs(var_11_1) >= 640 then
		self._controlPoint = math.abs(var_11_1) / var_11_1 * 640
		var_11_0 = self._controlPoint - self._controlPoint
	else
		self._controlPoint = self._controlPoint + var_11_0
	end

	self:movePanelCache(var_11_0)
	self:changeOpacityChildren(var_11_1)
	self:changeRightPanel(var_11_1)
end

function TwisteggLayer:handleReleaseLogic(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:getLocation().x - arg_12_1:getStartLocation().x

	if arg_12_2 <= var_0_8 then
		if math.abs(var_12_0) > 50 then
			self:switchTwistType(math.abs(var_12_0) / var_12_0)
			self:startCachePanelAnim(math.abs(var_12_0) / var_12_0 * var_0_7)
			self.twistList:scrollToIndexManual(self.curTwistIndex)
		else
			self:startCachePanelAnim(0)
		end
	elseif math.abs(var_12_0) >= 320 then
		self:switchTwistType(math.abs(var_12_0) / var_12_0)
		self:startCachePanelAnim(math.abs(var_12_0) / var_12_0 * var_0_7)
		self.twistList:scrollToIndexManual(self.curTwistIndex)
	else
		self:startCachePanelAnim(0)
	end
end

function TwisteggLayer:movePanelCache(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.cachePanelList) do
		local var_13_0 = iter_13_1:getChildByName("image_main")
		local var_13_1 = iter_13_1:getChildByName("image_bg")
		local var_13_2 = iter_13_1:getChildByName("image_title")
		local var_13_3 = iter_13_1:getChildByName("image_rarity")
		local var_13_4 = iter_13_1:getChildByName("btn_detail")

		for iter_13_2, iter_13_3 in ipairs(iter_13_1:getChildren()) do
			if var_0_4[iter_13_3:getName()] then
				iter_13_3:setPositionX(iter_13_3:getPositionX() + arg_13_1 * var_0_2[var_0_4[iter_13_3:getName()]] / var_0_3)
			end
		end
	end
end

function TwisteggLayer:changeOpacityChildren(arg_14_1)
	local var_14_0 = 255 - math.abs(arg_14_1) * var_0_5

	if var_14_0 > 255 then
		var_14_0 = 255
	elseif var_14_0 < 0 then
		var_14_0 = 0
	end

	self.oneBtn:setOpacity(var_14_0)
	self.tenBtn:setOpacity(var_14_0)
	self.cachePanelList[2]:getChildByName("rightBtnListPanel"):setOpacity(var_14_0)
	self.cachePanelList[2]:getChildByName("rightBtnListPanel"):setVisible(var_14_0 > 0)

	if self.cachePanelList[2]:getChildByName("overclock") then
		self.cachePanelList[2]:getChildByName("overclock"):setOpacity(var_14_0)
		self.cachePanelList[2]:getChildByName("overclock"):setVisible(var_14_0 > 0)
	end
end

function TwisteggLayer.changeRightPanel(arg_15_0, arg_15_1)
	return
end

function TwisteggLayer.resetCachePanel(arg_16_0)
	return
end

function TwisteggLayer:startCachePanelAnim(arg_17_1)
	self._isCachePanelInAnim = true
	self._autoscroll = true
	self._autoscrollpos = {
		pos = self._controlPoint
	}

	print("finalpos ===== ", arg_17_1, self._controlPoint)

	self._autoscrollaction = tween.new(0.3, self._autoscrollpos, {
		pos = arg_17_1
	}, "outQuad")
end

function TwisteggLayer:endCachePanelAnim()
	self._isCachePanelInAnim = false
	self._controlPoint = 0
	self._autoscroll = false
	self._autoscrollaction = nil

	self:setCachePanelDefault()
end

function TwisteggLayer:autoScrollCachePanel(arg_19_1)
	if self._autoscroll then
		if self._autoscrollaction:update(arg_19_1) then
			self:movePanelCache(self._autoscrollpos.pos - self._controlPoint)

			self._controlPoint = self._autoscrollpos.pos

			self:endCachePanelAnim()
		else
			self:movePanelCache(self._autoscrollpos.pos - self._controlPoint)

			self._controlPoint = self._autoscrollpos.pos
		end
	end
end

function TwisteggLayer:registerCachePanelUpdateEvent()
	self:scheduleUpdateWithPriorityLua(function(arg_21_0)
		self:autoScrollCachePanel(arg_21_0)
	end, 0)
end

function TwisteggLayer:setAnimController()
	self._canAnim = not self._isCachePanelInAnim and not self._isTwistListInAnim
end
