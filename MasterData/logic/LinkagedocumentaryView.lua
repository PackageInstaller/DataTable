-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagedocumentaryView.lua

module("logic.extensions.linkageintroduction.view.LinkagedocumentaryView", package.seeall)

local LinkagedocumentaryView = class("LinkagedocumentaryView", ViewComponent)

function LinkagedocumentaryView:ctor()
	LinkagedocumentaryView.super.ctor(self)
end

function LinkagedocumentaryView:unbindEvents()
	LinkagedocumentaryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function LinkagedocumentaryView:bindEvents()
	LinkagedocumentaryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function LinkagedocumentaryView:buildUI()
	LinkagedocumentaryView.super.buildUI(self)

	self._tip = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txt")
	self._btnGoto = self:getBtn("btnGoto")
end

function LinkagedocumentaryView:onExit()
	LinkagedocumentaryView.super.onExit(self)
end

function LinkagedocumentaryView:onEnter()
	LinkagedocumentaryView.super.onEnter(self)

	self._id = self:getFirstParam()
	self._cfg = LinkageConfig.instance:getCfgByTab(1, self._id)

	local isOffical = LinkageController.instance:isOffical()
	local isState = LinkageController.instance:isOfficalAndUrl(self._id)

	GameUtil.SetActive(self._btnGoto, isState)

	self._txtTip.text = isOffical and self._cfg.descOfficial or self._cfg.desc
end

function LinkagedocumentaryView:_onClickGoto()
	local url = self._cfg.url

	UnityEngine.Application.OpenURL(url)

	local reportBehaviorArr = string.split(self._cfg.reportBehavior, "#")

	SurveyController.instance:reportBehavior(reportBehaviorArr[2])
end

return LinkagedocumentaryView
