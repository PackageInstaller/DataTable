-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpCloseBgView.lua

module("logic.extensions.jumpgame.view.JumpCloseBgView", package.seeall)

local JumpCloseBgView = class("JumpCloseBgView", ViewComponent)

function JumpCloseBgView:ctor()
	JumpCloseBgView.super.ctor(self)
end

function JumpCloseBgView:bindEvents()
	self._closeBgMoveBy:AddListener(self._closeBgMoveByFinishCallBack, self)
	self._closeBgMoveBy2:AddListener(self._closeBgMoveBy2FinishCallBack, self)
end

function JumpCloseBgView:unbindEvents()
	self._closeBgMoveBy:RemoveListener()
	self._closeBgMoveBy2:RemoveListener()
end

function JumpCloseBgView:buildUI()
	self._Pnl_CloseBg = self:getGo("Container/Pnl_CloseBg")
	self._Pnl_CloseBgBg2 = self:getGo("Container/Pnl_CloseBgBg2")
	self._closeBgMoveBy = self._Pnl_CloseBg:GetComponent(UnityTweensType.TweenPositionBy)
	self._closeBgMoveBy2 = self._Pnl_CloseBgBg2:GetComponent(UnityTweensType.TweenPositionBy)
end

function JumpCloseBgView:destroyUI()
	return
end

function JumpCloseBgView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.JumpViewOffset, self.moveOffset, self)
end

function JumpCloseBgView:onEnterFinished()
	return
end

function JumpCloseBgView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.JumpViewOffset, self.moveOffset, self)
end

function JumpCloseBgView:onExitFinished()
	return
end

function JumpCloseBgView:moveOffset()
	local initPlayerPos = JumpGameModel.instance:getInitPlayerPos()
	local playerPos = JumpGameModel.instance:getPlayerPos()

	JumpGameModel.instance:updateCameraPosX(playerPos.x - initPlayerPos.x)

	self._closeBgMoveBy.positionBy = Vector3.New(-playerPos.x + initPlayerPos.x, 0, 0)

	self._closeBgMoveBy:Begin()

	self._closeBgMoveBy2.positionBy = Vector3.New(-playerPos.x + initPlayerPos.x, 0, 0)

	self._closeBgMoveBy2:Begin()
end

function JumpCloseBgView:_closeBgMoveByFinishCallBack()
	if self._Pnl_CloseBg.gameObject.transform.localPosition.x <= -1280 then
		local pos = self._Pnl_CloseBg.gameObject.transform.localPosition

		self._Pnl_CloseBg.gameObject.transform.localPosition = Vector3.New(1280, pos.y, pos.z)
	end
end

function JumpCloseBgView:_closeBgMoveBy2FinishCallBack()
	if self._Pnl_CloseBgBg2.gameObject.transform.localPosition.x <= -1280 then
		local pos = self._Pnl_CloseBgBg2.gameObject.transform.localPosition

		self._Pnl_CloseBgBg2.gameObject.transform.localPosition = Vector3.New(1280, pos.y, pos.z)
	end
end

return JumpCloseBgView
