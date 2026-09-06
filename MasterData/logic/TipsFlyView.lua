-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipsFlyView.lua

module("logic.extensions.tips.view.TipsFlyView", package.seeall)

local TipsFlyView = class("TipsFlyView", ViewComponent)

function TipsFlyView:buildUI()
	self._tween = self.mainGO:GetComponent(UnityTweensType.TweenSequence)
	self._text = self:getGo("Text"):GetComponent("Text")
end

function TipsFlyView:destroyUI()
	self._tween = nil
	self._text = nil
end

function TipsFlyView:onEnter()
	self:setTips(self._viewPresentor._openParam[1])
	self._tween:AddListener(self._onTweenFinish, self)
end

function TipsFlyView:onExit()
	self._tween:RemoveListener()
	self._tween:Stop()
end

function TipsFlyView:setTips(tips)
	self._tween:Stop()

	self._text.text = tips

	self._tween:Begin()
end

function TipsFlyView:_onTweenFinish()
	self:close()
end

return TipsFlyView
