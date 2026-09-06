-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossMissionView.lua

module("logic.extensions.family.view.FamilyBossMissionView", package.seeall)

local FamilyBossMissionView = class("FamilyBossMissionView", MissionView)

function FamilyBossMissionView:ctor()
	FamilyBossMissionView.super.ctor(self)
end

function FamilyBossMissionView:onEnter()
	GlobalDispatcher:addListener(FamilyAgent.ChallengeBossRes, self._onMissionBattleResBack, self)
	self:onEnterInherit()
	self:_setMaskBlock(false)
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return FamilyModel.instance:getAllShowPetList()
	end)
end

function FamilyBossMissionView:onExit()
	FamilyBossMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(FamilyAgent.ChallengeBossRes, self._onMissionBattleResBack, self)
end

function FamilyBossMissionView:procMid()
	local levelStr = ""
	local titleStr = lang("家族魔王")
	local ruleDesc = lang("伤害越多奖励越多")

	self:_setDescStr(titleStr, levelStr, ruleDesc)

	self._txtCd.text = ""
end

function FamilyBossMissionView:_startNow()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()

	local bossId = self:getFirstParam()

	if not bossId then
		printInfo("===没有bossId")

		return
	end

	FamilyController.instance:sendChallengeBossReq(bossId)
	BattleFacade.instance:startFamilyBoss(bossId)
end

function FamilyBossMissionView:_onClickStart()
	FamilyBossMissionView.super._onClickStart(self)
end

function FamilyBossMissionView:_saveFormationEx()
	PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_NORMAL)

	return FamilyBossMissionView.super._saveFormationEx(self)
end

function FamilyBossMissionView:_getCurFormation()
	return FamilyModel.instance:_getCurFormation()
end

return FamilyBossMissionView
