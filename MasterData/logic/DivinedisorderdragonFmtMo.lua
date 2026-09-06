-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/model/DivinedisorderdragonFmtMo.lua

module("logic.extensions.divinedisorderdragon.model.DivinedisorderdragonFmtMo", package.seeall)

local DivinedisorderdragonFmtMo = class("DivinedisorderdragonFmtMo", BaseCustomFmtMo)

function DivinedisorderdragonFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	local challengeCfg = DivinedisorderdragonConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._cfgEnemy = DivinedisorderdragonConfig.instance:getTeamCfg(challengeCfg.creepsMasterId)
	self._masterList = DivinedisorderdragonConfig.instance:getCreepsCfg(challengeCfg.creepsMasterId)
end

function DivinedisorderdragonFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function DivinedisorderdragonFmtMo:initFightHandler()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineDisorderDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	local function handler()
		local simpleForm = self:getCurSimpleForm()

		DivineDisorderDragonAgent.instance:sendPM_DivineDisorderDragonFightReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivinedisorderdragonFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function DivinedisorderdragonFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivinedisorderdragonFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return DivinedisorderdragonFmtMo
