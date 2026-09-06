-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareMissionView.lua

module("logic.extensions.sharetask.view.ShareMissionView", package.seeall)

local ShareMissionView = class("ShareMissionView", MissionView)

function ShareMissionView:ctor()
	ShareMissionView.super.ctor(self)
end

function ShareMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	GameUtil.SetActive(self._btnRule, false)
	FastFormation.instance:setGetCurPetList(function()
		return ShareTaskModel.instance:getAllShowPetList()
	end)
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function ShareMissionView:procMid()
	local battleInfo = ShareTaskModel.instance:GetBattleBossInfo()

	if battleInfo == nil or checknumber(battleInfo.bossId) < 1 then
		return
	end

	local bossInfo
	local cfg = ShareTaskConfig.instance:GetBossBaseCfg((battleInfo.isMyBoss and ShareTaskModel.instance:GetMyShareBossInfo() or ShareTaskModel.instance:GetOtherShareBossInfo()).bossTypeId)

	if cfg == nil then
		return
	end

	local levelStr = ""
	local titleStr = cfg.name
	local ruleDesc = ""

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function ShareMissionView:_enterBattle()
	local battleInfo = ShareTaskModel.instance:GetBattleBossInfo()

	if battleInfo == nil then
		return
	end

	if not battleInfo.isMyBoss then
		ShareTaskController.instance:CSHelpChallengeOtherBossReq(battleInfo.bossId, battleInfo.isParam)
	else
		ShareTaskController.instance:CSChallengeMyBossReq()
	end

	if battleInfo.isMainView then
		UIJumper.instance:pushOneStack(ViewName.ShareTask, true)
	end
end

function ShareMissionView:onExit()
	ShareMissionView.super.onExit(self)
	GameUtil.SetActive(self._btnRule, true)
end

function ShareMissionView:_isShowBtnEvaluate()
	return true
end

function ShareMissionView:_saveFormationEx()
	PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

	return ShareMissionView.super._saveFormationEx(self)
end

function ShareMissionView:_getCurFormation()
	return ShareTaskModel.instance:_getCurFormation()
end

return ShareMissionView
