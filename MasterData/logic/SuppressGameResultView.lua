-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameResultView.lua

module("logic.extensions.suppressgame.view.SuppressGameResultView", package.seeall)

local SuppressGameResultView = class("SuppressGameResultView", ViewComponent)

function SuppressGameResultView:ctor()
	SuppressGameResultView.super.ctor(self)
end

function SuppressGameResultView:buildUI()
	SuppressGameResultView.super.buildUI(self)

	self._imgTitle = goutil.findChild(self.mainGO, "imgTitle")
	self._btnClose = goutil.findChild(self.mainGO, "uiCol/btnClose")
	self._txtScoreCount = goutil.findChildTextComponent(self.mainGO, "uiCol/scoreCol/txtCount")
	self._txtResultCount = goutil.findChildTextComponent(self.mainGO, "uiCol/resultCol/txtCount")
	self._txtResultGameName = goutil.findChildTextComponent(self.mainGO, "uiCol/resultCol/txtGameName")
end

function SuppressGameResultView:bindEvents()
	SuppressGameResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function SuppressGameResultView:unbindEvents()
	SuppressGameResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SuppressGameResultView:destroyUI()
	SuppressGameResultView.super.destroyUI(self)
end

function SuppressGameResultView:onEnter()
	SuppressGameResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._scoreValue = checknumber(params[1])
	self._progressValue = checknumber(params[2])
	self._gameName = params[3] or ""
	self._callBack = params[4]

	self:_onSetUI()
end

function SuppressGameResultView:onExit()
	SuppressGameResultView.super.onExit(self)
end

function SuppressGameResultView:_onSetUI()
	self._txtScoreCount.text = self._scoreValue
	self._txtResultCount.text = self._progressValue
	self._txtResultGameName.text = self._gameName
end

function SuppressGameResultView:_onClickClose()
	self:close()
	GameUtil.callBack(self._callBack)
end

return SuppressGameResultView
