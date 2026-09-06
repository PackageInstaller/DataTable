-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpAllPassView.lua

module("logic.extensions.expedition.view.ExpAllPassView", package.seeall)

local ExpAllPassView = class("ExpAllPassView", ViewComponent)

function ExpAllPassView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function ExpAllPassView:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function ExpAllPassView:buildUI()
	self._btnClose = self:getBtn("container/btnClose")
	self._containerCan = self:getGo("container"):GetComponent(ComponentType.CanvasGroup)
	self._passTip = self:getGo("container/PassTip")

	local tipSearchFinish = self:getTxt("container/btnClose/Text")
	local tipConFinish = self:getTxt("container/TextTips")

	tipSearchFinish.text = lang("finish_search")
	tipConFinish.text = lang("con_finish_search")
end

function ExpAllPassView:onEnter()
	self._containerCan.alpha = 0
	self._closable = nil

	UnityTweens.UITweenFadeIn.StartTween(self._containerCan.gameObject, 0.5, UnityTweens.EaseType.easeInSine):AddListener(self._onFadeInFinished, self)
end

function ExpAllPassView:_onFadeInFinished()
	self._closable = true
end

function ExpAllPassView:_onClickClose()
	if self._closable then
		self:close()
		UIStateManager.instance:clear(true)
	end
end

return ExpAllPassView
