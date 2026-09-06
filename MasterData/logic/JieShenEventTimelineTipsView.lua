-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventTimelineTipsView.lua

module("logic.extensions.jieshenevent.view.JieShenEventTimelineTipsView", package.seeall)

local JieShenEventTimelineTipsView = class("JieShenEventTimelineTipsView", ViewComponent)

function JieShenEventTimelineTipsView:ctor()
	JieShenEventTimelineTipsView.super.ctor(self)
end

function JieShenEventTimelineTipsView:unbindEvents()
	JieShenEventTimelineTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function JieShenEventTimelineTipsView:bindEvents()
	JieShenEventTimelineTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function JieShenEventTimelineTipsView:buildUI()
	JieShenEventTimelineTipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("headIcon/txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._headIcon = self:getGo("headIcon")
	self._con = self:getGo("headIcon/con")
end

function JieShenEventTimelineTipsView:onExit()
	JieShenEventTimelineTipsView.super.onExit(self)

	if JieShenEventModel.instance:getChangeSetId() then
		MaterialController.instance:showChangeSetInTemp(JieShenEventModel.instance:getChangeSetId())
		JieShenEventModel.instance:resetTempChangeSetId()
	end
end

function JieShenEventTimelineTipsView:onEnter()
	JieShenEventTimelineTipsView.super.onEnter(self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local timelineId = checknumber(params[2])
	local cfg = JieShenEventConfig.instance:getTimelineCfg(activityId, timelineId)

	self._txtTitle.text = cfg.title
	self._txtDesc.text = cfg.desc

	MaterialMgr.resetAll(self._con)

	if checknumber(cfg.raceId) > 0 then
		MaterialMgr.setIcon(self._con, MatType.PET_SKIN, cfg.raceId)
		GameUtil.SetActive(self._headIcon, true)
	else
		GameUtil.SetActive(self._headIcon, false)
	end
end

function JieShenEventTimelineTipsView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.JieShenEventGameView)
	self:close()
end

return JieShenEventTimelineTipsView
