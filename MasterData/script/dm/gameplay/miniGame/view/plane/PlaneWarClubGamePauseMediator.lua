-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarClubGamePauseMediator.lua

PlaneWarClubGamePauseMediator = class("PlaneWarClubGamePauseMediator", DmPopupViewMediator, _M)

function PlaneWarClubGamePauseMediator:initialize()
	super.initialize(self)
end

function PlaneWarClubGamePauseMediator:enterWithData(data)
	self._activityId = data.activityId

	local bgNode = self:getView():getChildByFullName("main.bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onContinueClicked, self),
		title = Strings:get("MiniPlaneText28")
	})

	local mainPanel = self:getView():getChildByFullName("main")
	local rewardNode = cc.Node:create()

	rewardNode:addTo(mainPanel):center(mainPanel:getContentSize())

	local width = 0
	local label1 = mainPanel:getChildByFullName("label1")

	label1:setString(Strings:get("MiniPlaneText36"))

	if data.rewards and #data.rewards > 0 then
		label1:setString(Strings:get("MiniPlaneText8"))

		local index = 0

		for id, data in pairs(data.rewards) do
			local icon = IconFactory:createIcon(data)

			icon:setScale(0.7)
			icon:setAnchorPoint(cc.p(0, 0))
			icon:addTo(rewardNode):posite(90 * index, 0)

			index = index + 1
			width = width + 90
		end
	end

	rewardNode:setPositionX(590 - width / 2)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_GAMEOVER, self, self.viewClose)
end

function PlaneWarClubGamePauseMediator:viewClose(event)
	self:close()
end

function PlaneWarClubGamePauseMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarClubGamePauseMediator:bindWidgets()
	self:bindWidget("main.continue_btn", TwoLevelMainButton, {
		handler = bind1(self.onContinueClicked, self)
	})
	self:bindWidget("main.leave_btn", TwoLevelViceButton, {
		handler = bind1(self.onLeaveClicked, self)
	})
end

function PlaneWarClubGamePauseMediator:onTouchMaskLayer()
	return
end

function PlaneWarClubGamePauseMediator:onContinueClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
		snkAudio.play("Se_Click_Common_2")

		self._buttonResponsed = true

		self:close()
	end
end

function PlaneWarClubGamePauseMediator:onLeaveClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._popupDelegate and self._popupDelegate.onLeave then
		self._popupDelegate:onLeave(self)
		snkAudio.play("Se_Click_Common_2")

		self._buttonResponsed = true

		self:close()
	end
end

function PlaneWarClubGamePauseMediator:close()
	if not self._buttonResponsed and self._popupDelegate and self._popupDelegate.onContinue then
		self._popupDelegate:onContinue(self)
	end

	super.close(self)
end
