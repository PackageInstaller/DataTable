-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubMapButtonWidget.lua

ClubMapButtonWidget = class("ClubMapButtonWidget", BaseWidget, _M)

ClubMapButtonWidget:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubMapButtonWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function ClubMapButtonWidget:initialize(view)
	super.initialize(self, view)

	self._view = view
	self._isBunShow = false
	self._oneHousePosition = nil
end

function ClubMapButtonWidget:createWidgetNode()
	local resFile = "uiasset/club_New/widget/clubMapButtonWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function ClubMapButtonWidget:dispose()
	super.dispose(self)
end

function ClubMapButtonWidget:initSubviews(delegate)
	self._mainPanel = self._view:getChildByFullName("main")
	self._visitButton = self._mainPanel:getChildByFullName("Node_1.visitButton")
	self._checkButton = self._mainPanel:getChildByFullName("Node_2.checkButton")
	self._cancelButton = self._mainPanel:getChildByFullName("Node_3.cancelButton")
	self._backHomeButton = self._mainPanel:getChildByFullName("Node_4.backHomeButton")
	self._moveHomeButton = self._mainPanel:getChildByFullName("Node_5.moveHomeButton")

	self._visitButton:addTouchEventListener(function(sender, eventType)
		self:onClickVisit(sender, eventType)
	end)
	self._checkButton:addTouchEventListener(function(sender, eventType)
		self:onClickCheck(sender, eventType)
	end)
	self._cancelButton:addTouchEventListener(function(sender, eventType)
		self:onClickCancel(sender, eventType)
		delegate:willCancel()
	end)
	self._backHomeButton:addTouchEventListener(function(sender, eventType)
		self:onClickBackHome(sender, eventType)
	end)
end

function ClubMapButtonWidget:onClickVisit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._clubSystem:tryEnterSomebodyHouse(self._oneHousePosition:getRId())
	end
end

function ClubMapButtonWidget:onClickCheck(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		if self._oneHousePosition then
			self._clubSystem:showMemberPlayerInfoView(self._oneHousePosition:getRId())
		end
	end
end

function ClubMapButtonWidget:onClickCancel(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self:buttonHide()
	end
end

function ClubMapButtonWidget:onClickBackHome(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._clubSystem:tryEnterSomebodyHouse(self._oneHousePosition:getRId())
	end
end

function ClubMapButtonWidget:setSelfUser(isSelf)
	local Node_1 = self._mainPanel:getChildByFullName("Node_1")
	local Node_2 = self._mainPanel:getChildByFullName("Node_2")
	local Node_3 = self._mainPanel:getChildByFullName("Node_3")
	local Node_4 = self._mainPanel:getChildByFullName("Node_4")
	local Node_5 = self._mainPanel:getChildByFullName("Node_5")

	if isSelf then
		Node_1:setVisible(false)
		Node_2:setVisible(false)
		Node_3:setVisible(true)
		Node_4:setVisible(true)
		Node_5:setVisible(true)
	else
		Node_1:setVisible(true)
		Node_2:setVisible(true)
		Node_3:setVisible(true)
		Node_4:setVisible(false)
		Node_5:setVisible(false)
	end
end

function ClubMapButtonWidget:buttonShow(data)
	self._oneHousePosition = data
	self._isBunShow = true

	self._mainPanel:stopAllActions()
	self._visitButton:setVisible(true)
	self._checkButton:setVisible(true)
	self._cancelButton:setVisible(true)
	self._backHomeButton:setVisible(true)
	self._moveHomeButton:setVisible(true)

	local action = cc.CSLoader:createTimeline("asset/ui/clubMapButtonWidget.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 10, false)
end

function ClubMapButtonWidget:buttonHide()
	self._oneHousePosition = nil
	self._isBunShow = false

	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/clubMapButtonWidget.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(10, 20, false)
	self._visitButton:setVisible(false)
	self._checkButton:setVisible(false)
	self._cancelButton:setVisible(false)
	self._backHomeButton:setVisible(false)
	self._moveHomeButton:setVisible(false)
end

function ClubMapButtonWidget:getIsButtonShow()
	return self._isBunShow
end
