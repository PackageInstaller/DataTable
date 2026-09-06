-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/model/LionCultureCustomFmtMo.lua

module("logic.extensions.lionculture.model.LionCultureCustomFmtMo", package.seeall)

local LionCultureCustomFmtMo = class("LionCultureCustomFmtMo", ICustomFmtMo)

function LionCultureCustomFmtMo:onReset()
	LionCultureCustomFmtMo.super.onReset(self)
end

function LionCultureCustomFmtMo:updateCfg(activityId, gameId)
	self._gameId = gameId
	self._activityId = activityId
	self._monsterData = LioncultureConfig.instance:getGameMonsterData(self._activityId, self._gameId)
	self._creepsCfg = LioncultureConfig.instance:getGameCreepsCfg(self._activityId, self._gameId)
end

function LionCultureCustomFmtMo:updateData()
	self.topTitleStr = self._monsterData.name
	self.ruleDescStr = self._monsterData.WinDesc
	self.validatorDescStr = self._monsterData.missionDesc

	self:setFormCondition(self._monsterData.formCondition)
	self:initPetList()
end

function LionCultureCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		WakingLionGameAgent.instance:sendPM_WakingLionGameChallengeReq(self._activityId, self._gameId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function LionCultureCustomFmtMo:initPetList()
	self:clearAllPetList()

	local SystemPetCfg = LioncultureConfig.instance:getGameSystemPetCfg(self._activityId, self._gameId)

	if SystemPetCfg then
		local fmo = FightingPowerPetMo.New()

		for _, systemPetData in pairs(SystemPetCfg) do
			fmo:fromChallengeCreepCo(systemPetData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end

		fmo = nil
	end
end

function LionCultureCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function LionCultureCustomFmtMo:getFmtInfoConfig()
	return self._monsterData
end

return LionCultureCustomFmtMo
