-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FWPNMissionFmtView.lua

module("logic.extensions.newfamily.view.war.formation.FWPNMissionFmtView", package.seeall)

local FWPNMissionFmtView = class("FWPNMissionFmtView", MissionFmtView)

function FWPNMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params == nil then
		return nil
	end

	if params.isNest then
		return FamilyWarConfig.instance:getFamilyNestMasterCfg(params.enemyId)
	end

	if params.userInfo == nil then
		local pillarCfg = FamilyWarConfig.instance:getFamilyPillarLayersCfgs(params.planId, params.curTier)

		if pillarCfg and checknumber(pillarCfg.creepsMasterId) > 0 then
			return FamilyWarConfig.instance:getFamilyNestMasterCfg(pillarCfg.creepsMasterId)
		end
	end

	return nil
end

function FWPNMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params == nil then
		return nil
	end

	if params.isNest then
		return FamilyWarConfig.instance:getFamilyNestCreepsCfgs(params.enemyId)
	end

	if params.userInfo == nil then
		local pillarCfg = FamilyWarConfig.instance:getFamilyPillarLayersCfgs(params.planId, params.curTier)

		if pillarCfg and checknumber(pillarCfg.creepsMasterId) > 0 then
			return FamilyWarConfig.instance:getFamilyNestCreepsCfgs(pillarCfg.creepsMasterId)
		end
	end

	return nil
end

function FWPNMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function FWPNMissionFmtView:getTeamAndFormation(creepCfg)
	if self:_isNestBattleMission() then
		return FWPNMissionFmtView.super.getTeamAndFormation(self, creepCfg)
	else
		local params = self._viewPresentor:getFirstParam()
		local teams = {}
		local curForm = params.userInfo.curForm
		local formations = {}

		for num, id in pairs(curForm.pos) do
			if checknumber(num) > 0 and checknumber(id) > 0 then
				local mo = self:_getOtherPetMo(id, params.userInfo.petSimpleView)
				local petMo = mo:toFightingPowerPetMo()

				petMo.petId = id

				table.insert(teams, petMo)

				formations[num] = petMo
			end
		end

		ArraySort.sortOn(teams, "position")

		return teams, formations
	end
end

function FWPNMissionFmtView:getheroSkillId(monsterCo, teams)
	if self:_isNestBattleMission() then
		return FWPNMissionFmtView.super.getheroSkillId(self, monsterCo, teams)
	else
		local heroSkillId = 0
		local params = self._viewPresentor:getFirstParam()

		if params and params.userInfo then
			local curForm = params.userInfo.curForm

			if curForm and curForm.extParams then
				heroSkillId = checknumber(curForm.extParams.heroSkillId)
			end
		end

		return heroSkillId
	end
end

function FWPNMissionFmtView:_getOtherPetMo(petId, simpleView)
	local mo

	for i, v in ipairs(simpleView or {}) do
		if v.petId == petId then
			mo = BagPetMo.New()

			mo:initBaseView(v)
		end
	end

	return mo
end

function FWPNMissionFmtView:_isNestBattleMission()
	local params = self._viewPresentor:getFirstParam()

	if params == nil or params.isNest or params.userInfo == nil then
		return true
	end

	return false
end

function FWPNMissionFmtView:_setRightSpeedAndPower(speed, power)
	FWPNMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	if not self:_isNestBattleMission() then
		return
	end

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function FWPNMissionFmtView:_onClickPower()
	if not self:_isNestBattleMission() then
		FWPNMissionFmtView.super._onClickPower(self)

		return
	end

	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function FWPNMissionFmtView:_onClickSpeed()
	if not self:_isNestBattleMission() then
		FWPNMissionFmtView.super._onClickSpeed(self)

		return
	end

	FloatWordMgr.instance:show("全员速度：？？？")
end

return FWPNMissionFmtView
