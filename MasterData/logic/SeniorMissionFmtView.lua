-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SeniorMissionFmtView.lua

module("logic.extensions.mission.view.SeniorMissionFmtView", package.seeall)

local SeniorMissionFmtView = class("SeniorMissionFmtView", MissionFmtView)

function SeniorMissionFmtView:onEnter()
	SeniorMissionFmtView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
end

function SeniorMissionFmtView:onExit()
	SeniorMissionFmtView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
end

function SeniorMissionFmtView:_onCurFormTabChange()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function SeniorMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function SeniorMissionFmtView:getTeamAndFormation(creepCfg)
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()
	local pets = playerFormMo:getPetMoList()
	local teams = {}
	local formations = {}

	for i = 1, 9 do
		local pet = playerFormMo:getPetMoByIdx(i)

		if pet then
			local fPetMo = pet:toFightingPowerPetMo(pets)

			table.insert(teams, fPetMo)

			formations[i] = fPetMo
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function SeniorMissionFmtView:_createExtParams(formations)
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()

	self:setExtParams(playerFormMo:getExtParams())
end

function SeniorMissionFmtView:getheroSkillId(monsterCo, teams)
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()

	return (playerFormMo:getHeroSkillId())
end

function SeniorMissionFmtView:_getPsychicedSkillId()
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()
	local skillId = playerFormMo:getPsychicedSkillId()

	return skillId, self:_getPsychicedFaceId(skillId)
end

function SeniorMissionFmtView:getChangeRaceTypes()
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()

	return playerFormMo:getChangeRaceTypes()
end

function SeniorMissionFmtView:getElementMasterAndTarget()
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()
	local var_10_0, var_10_1 = playerFormMo:getElementPetId()

	return var_10_0, var_10_1
end

function SeniorMissionFmtView:_getCutePetInfo()
	local playerFormMo = SeniorArenaController.instance:getCurTabOpponentFormMo()
	local cutePetRaceId, cutePetQuality = playerFormMo:getCutePetInfo()

	return cutePetRaceId, cutePetQuality
end

return SeniorMissionFmtView
