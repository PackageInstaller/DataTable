-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpMissionView.lua

module("logic.extensions.familyteamplay.view.FamilytpMissionView", package.seeall)

local FamilytpMissionView = class("FamilytpMissionView", MissionView)

function FamilytpMissionView:ctor()
	FamilytpMissionView.super.ctor(self)
end

function FamilytpMissionView:buildUI()
	FamilytpMissionView.super.buildUI(self)

	local imgTiredPrefab = self._viewPresentor:getPrefab("ui/views/familyteamplay/imgtired.prefab")

	FamilyteamplayController.instance:setBtnTiredGo(imgTiredPrefab)
end

function FamilytpMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayFightInfo, self._scTeamPlayFightRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayPracticeInfo, self._onMissionBattleResBack, self)

	self._petlimitLv = FamilyteamplayConfig.instance:getPetLimitLv()

	self:onEnterInherit()

	local params = self:getOpenParam()

	self._periodId = params[1]
	self._bossId = params[2]
	self._tpType = params[3]
	self._zoneID = params[4]
	self._isPractice = params[5]

	local bcfg = self:_getBossCfg(self._periodId, self._zoneID, self._bossId)

	self:_setMaskBlock(false)
	self:_setDescStr(bcfg.name .. "挑战", "", lang("击败所有敌方精灵可获得胜利"))
	self:_setPureValidatorDesc("需上阵大于等于" .. self._petlimitLv .. "级的精灵")
	self:_updatePowerCost(self._isPractice and 0 or FamilyteamplayConfig.instance:getPlayConsumeStrength(), false)
end

function FamilytpMissionView:onExit()
	FamilytpMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayFightInfo, self._scTeamPlayFightRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayPracticeInfo, self._onMissionBattleResBack, self)
end

function FamilytpMissionView:_startNow()
	local currAtt = self:_getCurAttribute()
	local curFmo = self:_getCurFormation()
	local curPetPos = curFmo:GetPositions()
	local hasEff = true

	if self._tpType == FamilyteamplayController.teamPlayType.Season then
		for k, v in pairs(curPetPos) do
			if checknumber(v) > 0 then
				local petMo = curFmo:_getPet(v)

				if not petMo:checkHasRace(currAtt) then
					hasEff = false

					break
				end
			end
		end
	end

	if hasEff or string.nilorempty(currAtt) then
		self:_battleStart()
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), string.format("敌方BOSS受到5倍的%s属性伤害,其余属性1倍伤害，是否继续进入战斗？", currAtt), function()
			self:_battleStart()
		end, function()
			self:_setMaskBlock(false)
		end, "确定", "取消")
	end
end

function FamilytpMissionView:destroyUI()
	FamilytpMissionView.super.destroyUI(self)
	FamilyteamplayController.instance:setBtnTiredGo()
end

function FamilytpMissionView:_battleStart()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()
	BattleFacade.instance:startFamilyTeamPlay(self._tpType, self._isPractice)
	FamilyteamplayController.instance:csSendTeamPlayFightOrPracticeReq(self._periodId, self._bossId, self._tpType, not self._isPractice)
end

function FamilytpMissionView:_getCurAttribute()
	if self._tpType == FamilyteamplayController.teamPlayType.Common or self._zoneID == nil then
		return
	end

	return FamilyteamplayConfig.instance:getBossWarZoneAttribute(self._zoneID)
end

function FamilytpMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(pet)
		if pet:getPetLv() >= self._petlimitLv and not FamilyteamplayModel.instance:isFatiguePetId(pet:getPetId(), self._tpType) then
			return true
		end
	end)

	local hasPet = false

	for k, pet in pairs(BagModel.instance:getPets()) do
		if pet:getPetLv() >= self._petlimitLv and not FamilyteamplayModel.instance:isFatiguePetId(pet:getPetId(), self._tpType) then
			hasPet = true

			break
		end
	end

	if not hasPet then
		FloatWordMgr.instance:show("暂未有符合条件的精灵")
	end

	MissionModel.instance:setForceResetOneKey(false)
end

function FamilytpMissionView:_scTeamPlayFightRes(status)
	self:_onMissionBattleResBack(status)

	if status == -15106 then
		self:close()
	end
end

function FamilytpMissionView:_getBossCfg(periodId, zoneId, curBossId)
	local cfg = {}

	if self._tpType == FamilyteamplayController.teamPlayType.Season then
		cfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(periodId, zoneId, curBossId)
	elseif self._tpType == FamilyteamplayController.teamPlayType.Common then
		cfg = FamilyteamplayConfig.instance:getBossCfg(periodId, curBossId)
	else
		print("传进来的模式是不是有问题呀----------------------")

		return nil
	end

	return cfg
end

return FamilytpMissionView
