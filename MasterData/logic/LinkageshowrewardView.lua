-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkageshowrewardView.lua

module("logic.extensions.linkageintroduction.view.LinkageshowrewardView", package.seeall)

local LinkageshowrewardView = class("LinkageshowrewardView", ViewComponent)

function LinkageshowrewardView:ctor()
	LinkageshowrewardView.super.ctor(self)
end

function LinkageshowrewardView:unbindEvents()
	LinkageshowrewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function LinkageshowrewardView:bindEvents()
	LinkageshowrewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function LinkageshowrewardView:buildUI()
	LinkageshowrewardView.super.buildUI(self)

	self._tip = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txt")
	self._btnGoto = self:getBtn("btnGoto")
end

function LinkageshowrewardView:onExit()
	LinkageshowrewardView.super.onExit(self)
end

function LinkageshowrewardView:onEnter()
	LinkageshowrewardView.super.onEnter(self)

	self._id = self:getFirstParam()
	self._cfg = LinkageConfig.instance:getCfgByTab(1, self._id)

	local isOffical = LinkageController.instance:isOffical()
	local isState = LinkageController.instance:isOfficalAndUrl(self._id)

	GameUtil.SetActive(self._btnGoto, isState)

	self._txtTip.text = isOffical and self._cfg.descOfficial or self._cfg.desc
end

function LinkageshowrewardView:_onClickGoto()
	local url = self._cfg.url

	UnityEngine.Application.OpenURL(url)

	local reportBehaviorArr = string.split(self._cfg.reportBehavior, "#")

	SurveyController.instance:reportBehavior(reportBehaviorArr[2])
end

return LinkageshowrewardView
