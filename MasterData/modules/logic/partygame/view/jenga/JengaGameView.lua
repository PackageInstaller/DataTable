-- chunkname: @modules/logic/partygame/view/jenga/JengaGameView.lua

module("modules.logic.partygame.view.jenga.JengaGameView", package.seeall)

local JengaGameView = class("JengaGameView", SceneGameCommonView)

function JengaGameView:onInitView()
	self._btnLeft = gohelper.findChildClick(self.viewGO, "node_jenga/#btnLeft")
	self._btnRight = gohelper.findChildClick(self.viewGO, "node_jenga/#btnRight")
	self._btnLeft.canMultTouch = true
	self._btnRight.canMultTouch = true
	self._downDict = {}

	JengaGameView.super.onInitView(self)
end

function JengaGameView:addEvents()
	JengaGameView.super.addEvents(self)
	self._btnLeft:AddClickDownListener(self._onClickDown, self, 1)
	self._btnRight:AddClickDownListener(self._onClickDown, self, 0)
	self._btnLeft:AddClickUpListener(self._onClickUp, self, 1)
	self._btnRight:AddClickUpListener(self._onClickUp, self, 0)
end

function JengaGameView:removeEvents()
	JengaGameView.super.removeEvents(self)
	self._btnLeft:RemoveClickDownListener()
	self._btnRight:RemoveClickDownListener()
	self._btnLeft:RemoveClickUpListener()
	self._btnRight:RemoveClickUpListener()
end

function JengaGameView:onOpen()
	JengaGameView.super.onOpen(self)
	gohelper.setActive(self._goJoystick, false)
end

function JengaGameView:_onClickDown(index)
	self._downDict[index] = true

	PartyGameEnum.CommandUtil.CreateJoystickCommand(index, 1)
end

function JengaGameView:_onClickUp(index)
	self._downDict[index] = nil

	local pressIndex = next(self._downDict)

	if pressIndex then
		PartyGameEnum.CommandUtil.CreateJoystickCommand(pressIndex, 1)
	else
		PartyGameEnum.CommandUtil.CreateJoystickCommand(0, 0)
	end
end

function JengaGameView:viewUpdate()
	local isAcc = PartyGameCSDefine.JengaGameInterfaceCs.IsTimeAcc()

	self.partyGameCountDown:setIsAcc(isAcc)
end

function JengaGameView:createPlayerInfoComp()
	local go = gohelper.findChild(self.viewGO, "#go_Players")

	self._playerInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, JengaPlayerInfoComp)

	if self._playerInfoComp then
		self._playerInfoComp:Init()
	end
end

return JengaGameView
