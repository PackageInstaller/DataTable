-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarMissionFmtView.lua

module("logic.extensions.newfamily.view.war.FamilyPillarMissionFmtView", package.seeall)

local FamilyPillarMissionFmtView = class("FamilyPillarMissionFmtView", MissionFmtView)

function FamilyPillarMissionFmtView:onEnter()
	self._params = self:getFirstParam()
	self._needSetSkillEffect = true
	self._existPetPoses = {}
	self._charas = {}
	self._loader = {}
	self._lastCallBack = {}
	self._infoSeats = {}
	self._heroSkillEff = {}

	self:_initRestrainItems()
	self:_initAtkEnemyItems()

	if self._effViewContent then
		Framework.TransformUtil.SetAnchoredPos(self._effViewContent, 0, 0)
	end

	self:onEnterInherit()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function FamilyPillarMissionFmtView:onExit()
	FamilyPillarMissionFmtView.super.onExit(self)
end

function FamilyPillarMissionFmtView:getPlayerFromation()
	local ret = {
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1,
		-1
	}

	if self._params == nil or self._params.otherPlayerView == nil or self._params.otherPlayerView.curForm == nil then
		return ret
	end

	for i, v in ipairs(self._params.otherPlayerView.curForm.pos or {}) do
		ret[i] = v
	end

	return ret
end

function FamilyPillarMissionFmtView:getPlayerPetMo(petId)
	if self._params == nil or self._params.otherPlayerView == nil or self._params.otherPlayerView.petSimpleView == nil then
		return nil
	end

	local mo

	for i, v in ipairs(self._params.otherPlayerView.petSimpleView) do
		if v.petId == petId then
			mo = BagPetMo.New()

			mo:initBaseView(v)
		end
	end

	return mo
end

function FamilyPillarMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function FamilyPillarMissionFmtView:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}
	local form = self:getPlayerFromation()

	for i, v in ipairs(form or {}) do
		if v > 0 then
			local mo = self:getPlayerPetMo(v)

			if mo then
				local fPetMo = mo:toFightingPowerPetMo()

				table.insert(teams, fPetMo)

				formations[i] = fPetMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function FamilyPillarMissionFmtView:getheroSkillId(monsterCo, teams)
	local heroSkillId = 0

	if self._params and self._params.otherPlayerView and self._params.otherPlayerView.curForm then
		heroSkillId = self._params.otherPlayerView.curForm.extParams.heroSkillId
	end
end

return FamilyPillarMissionFmtView
