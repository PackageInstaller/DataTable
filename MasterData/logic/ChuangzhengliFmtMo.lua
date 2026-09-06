-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/model/ChuangzhengliFmtMo.lua

module("logic.extensions.chuangzhengli.model.ChuangzhengliFmtMo", package.seeall)

local ChuangzhengliFmtMo = class("ChuangzhengliFmtMo", ICustomFmtMo)

function ChuangzhengliFmtMo:initParams(activityId, stageId, teamIndex, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamIndex = teamIndex
	self._creepsMasterId = creepsMasterId
	self._masterData = ChuangzhengliConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = ChuangzhengliConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self._lockRaceIdMap = ChuangzhengliModel.instance:getAllLockRaceId(self._activityId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function ChuangzhengliFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		ChuangZhengliClgAgent.instance:sendPM_ChuangZhengliClgChallengeReq(self._activityId, self._stageId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function ChuangzhengliFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function ChuangzhengliFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ChuangzhengliFmtMo:getFmtInfoConfig()
	return self._masterData
end

function ChuangzhengliFmtMo:checkPetIsForbit(petMo)
	return self._lockRaceIdMap[petMo.raceId]
end

function ChuangzhengliFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show("此精灵已锁定")
end

return ChuangzhengliFmtMo
