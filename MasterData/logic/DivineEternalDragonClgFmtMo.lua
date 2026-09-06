-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/model/DivineEternalDragonClgFmtMo.lua

module("logic.extensions.divineeternaldragonclg.model.DivineEternalDragonClgFmtMo", package.seeall)

local DivineEternalDragonClgFmtMo = class("DivineEternalDragonClgFmtMo", BaseCustomFmtMo)

function DivineEternalDragonClgFmtMo:initParams(activityId, stageId, teamId)
	self.activityId = activityId
	self.stageId = stageId
	self.teamId = teamId

	local stageCfg = DivineEternalDragonClgConfig.instance:getStageCfgByStageId(self.activityId, self.stageId)
	local creepMasterId = stageCfg.creepsMasterId[self.teamId]

	self.masterCfg = DivineEternalDragonClgConfig.instance:getCreepMonsterCfg(creepMasterId) or {}
	self.creeps = DivineEternalDragonClgConfig.instance:getCreepCfg(creepMasterId) or {}
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self.activityId)

	self:setFormCondition(self.masterCfg.formCondition)

	local baseInfo = DivineEternalDragonClgModel.instance:getBaseInfoByActId(self.activityId)

	self._lockedRaceMap = {}

	for i = 1, 2 do
		if not baseInfo.teamLockRaceIds[i] then
			if not baseInfo.teamLockRaceIds[i].list then
				local lockRaceIds = {}

				for _, raceId in ipairs(lockRaceIds) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end
	end

	self:clearAllPetList()
end

function DivineEternalDragonClgFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		local petMoForm = self:_changePetMo(petMo)

		self:addPetToList(petMoForm)
	end
end

function DivineEternalDragonClgFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineEternalDragonClgFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineEternalDragonClgFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo, true)
	end
end

function DivineEternalDragonClgFmtMo:initFightHandler()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, 445, self.activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineEternalDragonClgController.instance:startClgChanllenge(self.activityId, self.stageId, self.teamId, self:getCurSimpleForm())
	end, nil)
end

function DivineEternalDragonClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function DivineEternalDragonClgFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return DivineEternalDragonClgFmtMo
