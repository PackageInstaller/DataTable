-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueTipsView.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueTipsView", package.seeall)

local JieShenEventClueTipsView = class("JieShenEventClueTipsView", ViewComponent)

function JieShenEventClueTipsView:ctor()
	JieShenEventClueTipsView.super.ctor(self)
end

function JieShenEventClueTipsView:unbindEvents()
	JieShenEventClueTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function JieShenEventClueTipsView:bindEvents()
	JieShenEventClueTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function JieShenEventClueTipsView:buildUI()
	JieShenEventClueTipsView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnComfirm = self:getGo("btnComfirm")
	self._btnCancel = self:getGo("btnCancel")
end

function JieShenEventClueTipsView:onExit()
	JieShenEventClueTipsView.super.onExit(self)

	if JieShenEventModel.instance:getChangeSetId() then
		MaterialController.instance:showChangeSetInTemp(JieShenEventModel.instance:getChangeSetId())
		JieShenEventModel.instance:resetTempChangeSetId()
	end
end

function JieShenEventClueTipsView:onEnter()
	JieShenEventClueTipsView.super.onEnter(self)
	GameUtil.SetActive(self._btnSure, true)
	GameUtil.SetActive(self._btnComfirm, false)
	GameUtil.SetActive(self._btnCancel, false)

	local params = self:getOpenParam()
	local activityId = params[1]
	local clueId = params[2]
	local clueCfg = JieShenEventConfig.instance:getClueCfg(activityId, clueId)

	self._txtDesc.text = clueCfg.desc
end

return JieShenEventClueTipsView
