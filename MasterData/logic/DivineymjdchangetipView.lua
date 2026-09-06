-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdchangetipView.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdchangetipView", package.seeall)

local DivineymjdchangetipView = class("DivineymjdchangetipView", ViewComponent)

function DivineymjdchangetipView:ctor()
	DivineymjdchangetipView.super.ctor(self)
end

function DivineymjdchangetipView:unbindEvents()
	DivineymjdchangetipView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function DivineymjdchangetipView:bindEvents()
	DivineymjdchangetipView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function DivineymjdchangetipView:buildUI()
	DivineymjdchangetipView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtOld = self:getTxt("txtOld")
	self._txtNew = self:getTxt("txtNew")
end

function DivineymjdchangetipView:onExit()
	DivineymjdchangetipView.super.onExit(self)
end

function DivineymjdchangetipView:onEnter()
	DivineymjdchangetipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KingSpaceDragonClgFightConfirmRes, self._onKingSpaceDragonClgFightConfirmRes, self)

	self._msg = KingspacedragonController.instance:getCacheClgFightResult()
	self._info = KingspacedragonModel.instance:getInfo(self._msg.activityId)

	self:_updateUI()
end

function DivineymjdchangetipView:_onClickbtnSure()
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgFightConfirmReq(self._msg.activityId, self._msg.confirmNum, true)
end

function DivineymjdchangetipView:_onClickbtnCancel()
	KingSpaceDragonClgAgent.instance:sendPM_KingSpaceDragonClgFightConfirmReq(self._msg.activityId, self._msg.confirmNum, false)
end

function DivineymjdchangetipView:_updateUI()
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

function DivineymjdchangetipView:_onKingSpaceDragonClgFightConfirmRes()
	local info = KingspacedragonModel.instance:getInfo(self._msg.activityId)
	local cfgs = KingspacedragonConfig.instance:getStageCfgs(self._msg.activityId)

	if info.curStageId > #cfgs then
		UIStateManager.instance:popByName(ViewName.DivineymjdlevelsView)
	end

	self:close()
end

return DivineymjdchangetipView
