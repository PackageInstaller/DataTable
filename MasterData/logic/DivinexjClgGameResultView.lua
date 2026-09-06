-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameResultView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameResultView", package.seeall)

local DivinexjClgGameResultView = class("DivinexjClgGameResultView", ViewComponent)

function DivinexjClgGameResultView:ctor()
	DivinexjClgGameResultView.super.ctor(self)
end

function DivinexjClgGameResultView:buildUI()
	DivinexjClgGameResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtScore = self:getTxt("txtScore")
	self._txtTotal = self:getTxt("txtTotal")
end

function DivinexjClgGameResultView:bindEvents()
	DivinexjClgGameResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickClose, self)
end

function DivinexjClgGameResultView:unbindEvents()
	DivinexjClgGameResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DivinexjClgGameResultView:onEnter()
	DivinexjClgGameResultView.super.onEnter(self)

	local score = self:getFirstParam()
	local activityId = DivineXingJiangClgModel.instance:getActivityId()
	local cfgActivity = DivineXingJiangClgConfig.instance:getActivityCfg(activityId)
	local oldTotalScore = DivineXingJiangClgModel.instance:getBuffProgress(activityId)

	score = Mathf.Min(cfgActivity.maxProgressPerGame, score)
	self._txtScore.text = score
	self._txtTotal.text = string.format("当前累计获得：%d", oldTotalScore + score)

	DivineXingJiangClgAgent.instance:sendPM_DivineXingJiangClgPlayGameReq(activityId, score)
end

function DivinexjClgGameResultView:onExit()
	DivinexjClgGameResultView.super.onExit(self)
end

function DivinexjClgGameResultView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.DivinexjClgGameMainView)
	self:close()
end

return DivinexjClgGameResultView
