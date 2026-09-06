-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/model/PhantomSpaceEndlessFirstFmtMo.lua

module("logic.extensions.phantomspace.model.PhantomSpaceEndlessFirstFmtMo", package.seeall)

local PhantomSpaceEndlessFirstFmtMo = class("PhantomSpaceEndlessFirstFmtMo", BaseCustomFmtMo)

function PhantomSpaceEndlessFirstFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._creepsMasterId = PhantomSpaceConfig.instance:getEndlessCreepsMasterId(activityId)
	self._masterCfg = PhantomSpaceConfig.instance:getMonsterCfgById(self._creepsMasterId)
	self._creepsCfg = PhantomSpaceConfig.instance:getCreeps(self._creepsMasterId)

	self:setFormCondition(self._masterCfg.formCondition)

	self.topTitleStr = self._masterCfg.name
	self.ruleDescStr = self._masterCfg.ruleDesc
	self.useMaxFightPower = true
end

function PhantomSpaceEndlessFirstFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function PhantomSpaceEndlessFirstFmtMo:getFmtInfoConfig()
	return self._masterCfg
end

function PhantomSpaceEndlessFirstFmtMo:getTeamAndFormation(creepCfg)
	local teams = {}
	local formations = {}

	if creepCfg then
		for i, v in pairs(creepCfg) do
			if checknumber(v.posId) > 0 then
				local raceId = v.raceId
				local curFaceId = checknumber(v.faceId)
				local petMo = FightingPowerPetMo.getMaxPetMo(raceId, curFaceId)

				petMo.creepName = v.creepName

				table.insert(teams, petMo)

				formations[v.posId] = petMo
			end
		end
	end

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function PhantomSpaceEndlessFirstFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		PhantomSpaceController.instance:sendPM_PhantomSpaceChallengeEndlessReq(self._activityId, self._stageId, self:getCurSimpleForm())
	end, nil)
end

return PhantomSpaceEndlessFirstFmtMo
