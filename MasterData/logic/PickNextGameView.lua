-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickNextGameView.lua

module("logic.extensions.pickapet.view.PickNextGameView", package.seeall)

local PickNextGameView = class("PickNextGameView", ViewComponent)

function PickNextGameView:ctor()
	PickNextGameView.super.ctor(self)
end

function PickNextGameView:bindEvents()
	self._fadeOut:AddListener(self._fadeOutFinishCallBack, self)
	GlobalDispatcher:addListener(GlobalNotify.PickNextGate, self._onNextGate, self)
end

function PickNextGameView:unbindEvents()
	self._fadeOut:RemoveListener()
	GlobalDispatcher:removeListener(GlobalNotify.PickNextGate, self._onNextGate, self)
end

function PickNextGameView:buildUI()
	self._Pnl_NextLevel = self:getGo("Pnl_NextLevel")
	self._fadeOut = self._Pnl_NextLevel:GetComponent(UnityTweensType.UITweenFadeOut)
end

function PickNextGameView:destroyUI()
	return
end

function PickNextGameView:onEnter()
	return
end

function PickNextGameView:onEnterFinished()
	return
end

function PickNextGameView:onExit()
	return
end

function PickNextGameView:onExitFinished()
	return
end

function PickNextGameView:_onNextGate()
	self._Pnl_NextLevel.gameObject:SetActive(true)
	self._fadeOut:Begin()
end

function PickNextGameView:_fadeOutFinishCallBack()
	self._Pnl_NextLevel.gameObject:SetActive(false)
	PickAPetController.instance:startGame()
end

return PickNextGameView
