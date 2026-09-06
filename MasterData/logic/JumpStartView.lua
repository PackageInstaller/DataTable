-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpStartView.lua

module("logic.extensions.jumpgame.view.JumpStartView", package.seeall)

local JumpStartView = class("JumpStartView", ViewComponent)

function JumpStartView:ctor()
	JumpStartView.super.ctor(self)
end

function JumpStartView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onStartGame, self)
end

function JumpStartView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function JumpStartView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnStart = self:getBtn("Btn_start")
	self._txtTitle = self:getGo("txtTitle"):GetComponent("Text")
	self._img1 = self:getGo("txtTitle/img"):GetComponent("UIImageSpriteChange")
	self._img2 = self:getGo("Main/img2/img"):GetComponent("UIImageSpriteChange")
	self._img3 = self:getGo("Main/img3/img"):GetComponent("UIImageSpriteChange")
end

function JumpStartView:destroyUI()
	return
end

function JumpStartView:onEnter()
	local gameType = self._viewPresentor._openParam[1]
	local imgNum = gameType - 1

	if gameType == 1 then
		self._img1:ChangeStateNow(imgNum)
		self._img2:ChangeStateNow(imgNum)
		self._img3:ChangeStateNow(imgNum)
	elseif gameType == 2 then
		self._img1:ChangeStateNow(imgNum)
		self._img2:ChangeStateNow(imgNum)
		self._img3:ChangeStateNow(imgNum)
	end

	local names = {}

	names[1] = "梅花之证"
	names[2] = "八卦之证"
	self._txtTitle.text = langPara("请在<color=#09be16>规定时间</color>内，快速跳木桩，获得<color=#09be16>%s</color>", names[gameType])
end

function JumpStartView:onEnterFinished()
	return
end

function JumpStartView:onExit()
	return
end

function JumpStartView:onExitFinished()
	return
end

function JumpStartView:_onClickClose()
	self:close()
end

function JumpStartView:_onStartGame()
	local params = {
		self._viewPresentor._openParam[1],
		self._viewPresentor._openParam[2]
	}

	JumpGameModel.instance:setInitCollectParams(params)
	self:_onClickClose()
	UIStateManager.instance:push(ViewName.JumpGameView)
end

return JumpStartView
