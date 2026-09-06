-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueImportView.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueImportView", package.seeall)

local JieShenEventClueImportView = class("JieShenEventClueImportView", ViewComponent)

function JieShenEventClueImportView:ctor()
	JieShenEventClueImportView.super.ctor(self)
end

function JieShenEventClueImportView:unbindEvents()
	JieShenEventClueImportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnComfirm)
end

function JieShenEventClueImportView:bindEvents()
	JieShenEventClueImportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnComfirm, self._onClickComfirm, self)
end

function JieShenEventClueImportView:buildUI()
	JieShenEventClueImportView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnComfirm = self:getGo("btnComfirm")
	self._btnCancel = self:getGo("btnCancel")
end

function JieShenEventClueImportView:onExit()
	JieShenEventClueImportView.super.onExit(self)
end

function JieShenEventClueImportView:onEnter()
	JieShenEventClueImportView.super.onEnter(self)
	GameUtil.SetActive(self._btnSure, false)
	GameUtil.SetActive(self._btnComfirm, true)
	GameUtil.SetActive(self._btnCancel, true)

	local params = self:getOpenParam()
	local activityId = params[1]

	self._clueId = params[2]

	local clueCfg = JieShenEventConfig.instance:getClueCfg(activityId, self._clueId)

	self._txtDesc.text = clueCfg.desc
end

function JieShenEventClueImportView:_onClickComfirm()
	GlobalDispatcher:dispatch(GlobalNotify.JieShenEvnetComfirmClue, self._clueId)
	self:close()
end

return JieShenEventClueImportView
