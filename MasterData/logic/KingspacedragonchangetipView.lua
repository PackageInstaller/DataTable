-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/KingspacedragonchangetipView.lua

module("logic.extensions.kingspacedragon.view.KingspacedragonchangetipView", package.seeall)

local KingspacedragonchangetipView = class("KingspacedragonchangetipView", ViewComponent)

function KingspacedragonchangetipView:ctor()
	KingspacedragonchangetipView.super.ctor(self)
end

function KingspacedragonchangetipView:unbindEvents()
	KingspacedragonchangetipView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function KingspacedragonchangetipView:bindEvents()
	KingspacedragonchangetipView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function KingspacedragonchangetipView:buildUI()
	KingspacedragonchangetipView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtOld = self:getTxt("txtOld")
	self._txtNew = self:getTxt("txtNew")
end

function KingspacedragonchangetipView:onExit()
	KingspacedragonchangetipView.super.onExit(self)
end

function KingspacedragonchangetipView:onEnter()
	KingspacedragonchangetipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KingSpaceDragonClgFightConfirmRes, self._onKingSpaceDragonClgFightConfirmRes, self)

	self._msg = KingspacedragonController.instance:getCacheClgFightResult()
	self._info = KingspacedragonModel.instance:getInfo(self._msg.activityId)

	self:_updateUI()
end

function KingspacedragonchangetipView:_onClickbtnSure()
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgFightConfirmReq(self._msg.activityId, self._msg.confirmNum, true)
end

function KingspacedragonchangetipView:_onClickbtnCancel()
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgFightConfirmReq(self._msg.activityId, self._msg.confirmNum, false)
end

function KingspacedragonchangetipView:_updateUI()
	local clgName = ""
	local clgTypeName = ""
	local oldValue = 0
	local newValue = 0

	if self._msg.monsterType == GameEnum.KingSpaceDragonClgMonsterType.Time then
		clgName = "时间试炼"
		clgTypeName = "回合数"
		oldValue = self._info.curStageTimeValue
		newValue = self._msg.curFightValue
	else
		clgName = "空间试炼"
		clgTypeName = "存活精灵数"
		oldValue = self._info.curStageSpaceValue
		newValue = self._msg.curFightValue
	end

	self._txtDesc.text = string.format("本次挑战%s的%s发生变化，是否进行替换？", clgName, clgTypeName)
	self._txtOld.text = math.max(oldValue, 0)
	self._txtNew.text = math.max(newValue, 0)
end

function KingspacedragonchangetipView:_onKingSpaceDragonClgFightConfirmRes()
	local info = KingspacedragonModel.instance:getInfo(self._msg.activityId)
	local cfgs = KingspacedragonConfig.instance:getStageCfgs(self._msg.activityId)

	if info.curStageId > #cfgs then
		local activityId = self._msg.activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
			UIStateManager.instance:popByName(ViewName.KingspacedragonmainView)

			local aoqiActId = AoqiGodController.instance:getActivityId()

			UIStateManager.instance:push(ViewName.AoqiGodMainView, aoqiActId)
		end

		UIStateManager.instance:popByName(ViewName.KingspacedragonlevelsView)
	end

	self:close()
end

return KingspacedragonchangetipView
