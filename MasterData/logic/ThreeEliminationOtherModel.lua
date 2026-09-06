-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/model/ThreeEliminationOtherModel.lua

module("logic.extensions.threeelimination.model.ThreeEliminationOtherModel", package.seeall)

local ThreeEliminationOtherModel = class("ThreeEliminationOtherModel", BaseModel)

ThreeEliminationOtherModel.ReadFlag = "ThreeEliminationOtherModel.ReadFlag"

function ThreeEliminationOtherModel:ctor()
	return
end

function ThreeEliminationOtherModel:onInit()
	self:onReset()
end

function ThreeEliminationOtherModel:onReset()
	self._allPetGain = {}
	self._tempPetByStep = {}
	self._prizeInOnceBattle = {}
	self._powerAdd = {}
end

function ThreeEliminationOtherModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._playerLvl = data.playerLvl
	self._gainedBuffIdMap = self._gainedBuffIdMap and table.clear(self._gainedBuffIdMap) or {}

	if data.gainedBuffId and #data.gainedBuffId then
		for i, v in ipairs(data.gainedBuffId) do
			self._gainedBuffIdMap[v] = true
		end
	end

	self:setUseBuff(data.activityId, data.buffUsing)

	self._battleGroup = data.bestGroupStage.left or 0
	self._battleStage = data.bestGroupStage.right or 0
	self._curRoundUsedStepCount = data.curRoundUsedStepCount
	self._hangUpValue = data.hangUpValue
	self._hangUpBalanceTime = data.hangUpBalanceTime
	self._attackValue = data.attackValue
	self._attackBalanceTime = data.attackBalanceTime
	self._allPetGain = self._allPetGain and table.clear(self._allPetGain) or {}

	if data.ownPetInfo and #data.ownPetInfo > 0 then
		for i, v in ipairs(data.ownPetInfo) do
			self._allPetGain[v.left] = v.right
		end
	end
end

function ThreeEliminationOtherModel:removeTempRemoveByStep()
	self._tempPetByStep = self._tempPetByStep and table.clear(self._tempPetByStep) or {}
end

function ThreeEliminationOtherModel:getTempRemoveByStep()
	return self._tempPetByStep
end

function ThreeEliminationOtherModel:addPetFromIncrease()
	local insPet = ThreeEliminationModel.instance:getIncreasePet()

	for k, v in pairs(insPet) do
		if v > 0 then
			self._allPetGain[k] = (self._allPetGain[k] or 0) + v
			self._tempPetByStep[k] = (self._tempPetByStep[k] or 0) + v
		end
	end

	ThreeEliminationModel.instance:removeIncreasePet()
end

function ThreeEliminationOtherModel:getAllPet()
	return self._allPetGain
end

function ThreeEliminationOtherModel:getPlayerLv()
	return self._playerLvl
end

function ThreeEliminationOtherModel:setPlayerLv(playerLvl)
	self._playerLvl = playerLvl
end

function ThreeEliminationOtherModel:addPrizeInOnceBattle(prizeStr)
	table.insert(self._prizeInOnceBattle, prizeStr)
end

function ThreeEliminationOtherModel:getPrizeInOnceBattle()
	return self._prizeInOnceBattle
end

function ThreeEliminationOtherModel:resetPrizeInOnceBattle()
	table.clear(self._prizeInOnceBattle)
end

function ThreeEliminationOtherModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.ThreeElimination)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.ThreeElimination)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.ThreeElimination, v.activityId) then
			local cfg = ThreeEliminationConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v.activityId)

			break
		end
	end

	return actId
end

function ThreeEliminationOtherModel:getStepCount()
	return self._curRoundUsedStepCount
end

function ThreeEliminationOtherModel:moveStep(step)
	self._curRoundUsedStepCount = self._curRoundUsedStepCount + step
end

function ThreeEliminationOtherModel:getAttackValue()
	return self._attackValue or 0
end

function ThreeEliminationOtherModel:saveFightInfo(msg)
	self._fightInfo = GameUtil.pbToTable(msg)
	self._attackValue = self._fightInfo.attackValue
	self._attackBalanceTime = self._fightInfo.attackBalanceTime
end

function ThreeEliminationOtherModel:getFightInfo()
	return self._fightInfo
end

function ThreeEliminationOtherModel:isOverBestLevel(groupId, stageId)
	if groupId == self._battleGroup then
		return stageId > self._battleStage
	end

	return groupId > self._battleGroup
end

function ThreeEliminationOtherModel:checkBestFromFightInfo()
	if self:isOverBestLevel(self._fightInfo.bestGroupStage.left, self._fightInfo.bestGroupStage.right) then
		self._battleGroup = self._fightInfo.bestGroupStage.left
		self._battleStage = self._fightInfo.bestGroupStage.right
	end
end

function ThreeEliminationOtherModel:getBestBattleGroup()
	return self._battleGroup or 0
end

function ThreeEliminationOtherModel:getBestBattleStage()
	return self._battleStage or 0
end

function ThreeEliminationOtherModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._rankInfo = data.rankInfos
	self._myRank = data.myRank
end

function ThreeEliminationOtherModel:getRankInfo()
	return self._rankInfo or {}
end

function ThreeEliminationOtherModel:getMyRank()
	return self._myRank
end

function ThreeEliminationOtherModel:getBuffUsing()
	return self._buffUsing or 0
end

function ThreeEliminationOtherModel:isUnlockBuff(buffId)
	return self._gainedBuffIdMap[buffId] or false
end

function ThreeEliminationOtherModel:setInfoByUnlockBuff(msg)
	self._gainedBuffIdMap[msg.buffId] = true
end

function ThreeEliminationOtherModel:setInfoByUseBuff(msg)
	self:setUseBuff(msg.activityId, msg.buffId)

	if checknumber(msg.hangUpBalanceTime) > 0 then
		self._hangUpBalanceTime = msg.hangUpBalanceTime
		self._hangUpValue = msg.hangUpValue
	end
end

function ThreeEliminationOtherModel:setUseBuff(activityId, buffId)
	self._buffUsing = buffId

	table.clear(self._powerAdd)
	ThreeEliminationModel.instance:setUseAddSupply(false)

	self._hangUpAddRate = 0

	local buffCfg = ThreeEliminationConfig.instance:getBuffCfg(activityId, buffId)

	if buffCfg then
		local effectStrArr = string.split(buffCfg.serverEffect, "$")

		if effectStrArr[1] == "PET_INC_ZDL" then
			local effectParam = string.split(effectStrArr[2], ",")

			self._powerAdd[checknumber(effectParam[1])] = checknumber(effectParam[2])
		elseif effectStrArr[1] == "HANG_UP_INC_RATE" then
			local effectParam = string.split(effectStrArr[2], ",")

			self._hangUpAddRate = checknumber(effectParam[1])
		end

		effectStrArr = string.split(buffCfg.clientEffect, "$")

		if effectStrArr[1] == "USE_ADD_SUPPLY" then
			local effectParam = string.split(effectStrArr[2], ",")

			if checknumber(effectParam[1]) == 1 then
				ThreeEliminationModel.instance:setUseAddSupply(true)
			end
		end
	end
end

function ThreeEliminationOtherModel:getAddPowerByRaceType(raceType)
	return self._powerAdd[raceType] or 0
end

function ThreeEliminationOtherModel:getAttackBalanceTime()
	return checknumber(self._attackBalanceTime) or 0
end

function ThreeEliminationOtherModel:onAttackBalanceTimeUp(activityId)
	local activityCfg = ThreeEliminationConfig.instance:getActivityCfg(activityId)

	if self._attackValue < activityCfg.attackMaxValue then
		self._attackValue = self._attackValue + 1
		self._attackBalanceTime = self._attackBalanceTime + activityCfg.attckUnitSecd * 1000
	else
		self._attackBalanceTime = self._attackBalanceTime + activityCfg.attckUnitSecd * 1000
	end
end

function ThreeEliminationOtherModel:setHangUpInfo(msg)
	self._hangUpValue = msg.hangUpValue
	self._hangUpBalanceTime = msg.hangUpBalanceTime
end

function ThreeEliminationOtherModel:getHangUpValue()
	return self._hangUpValue or 0
end

function ThreeEliminationOtherModel:getHangUpBalanceTime()
	return checknumber(self._hangUpBalanceTime) or 0
end

function ThreeEliminationOtherModel:onHangUpBalanceTimeUp(activityId)
	local activityCfg = ThreeEliminationConfig.instance:getActivityCfg(activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(activityCfg.hangUpMp)

	if checknumber(self._hangUpValue) < activityCfg.hangUpMaxValue then
		self._hangUpValue = checknumber(self._hangUpValue) + (1 + self._hangUpAddRate) * matNum
		self._hangUpBalanceTime = self._hangUpBalanceTime + activityCfg.hangUpUnitSecd * 1000
	else
		self._hangUpBalanceTime = self._hangUpBalanceTime + activityCfg.hangUpUnitSecd * 1000
	end
end

function ThreeEliminationOtherModel:getHangUpAddRate()
	return self._hangUpAddRate or 0
end

function ThreeEliminationOtherModel:setInfoByGetRedPoont(msg)
	self._playerLvl = msg.playerLvl
end

function ThreeEliminationOtherModel:setLevelUpRedPoint()
	local activityId = self:getCurrActId()

	if not activityId or not self._playerLvl then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_THREEELIMINATION_LEVEL, false)
	else
		local cfg = ThreeEliminationConfig.instance:getPlayerLevelCfg(activityId, self._playerLvl + 1)

		if cfg then
			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.lvlUpCost)

			if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_THREEELIMINATION_LEVEL, true)
			else
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_THREEELIMINATION_LEVEL, false)
			end
		else
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_THREEELIMINATION_LEVEL, false)
		end
	end
end

function ThreeEliminationOtherModel:getIsReadImgRule(activityId)
	return GameUtil.getUserData(ThreeEliminationOtherModel.ReadFlag .. activityId)
end

function ThreeEliminationOtherModel:saveIsReadImgRule(activityId)
	GameUtil.saveUserData(ThreeEliminationOtherModel.ReadFlag .. activityId, true)
end

ThreeEliminationOtherModel.instance = ThreeEliminationOtherModel.New()

return ThreeEliminationOtherModel
