-- chunkname: @modules/logic/fight/model/FightModel.lua

module("modules.logic.fight.model.FightModel", package.seeall)

local FightModel = class("FightModel", BaseModel)

function FightModel:onInit()
	self._fightParam = nil
	self._curWaveId = 1
	self._curRoundId = 1
	self._roundInc = 1
	self._historyRoundMOList = nil
	self._isFinish = false
	self._recordMO = nil
	self.maxRound = 1
	self.maxWave = 1
	self.power = 0
	self.clothId = 0
	self._clothSkillDict = nil
	self.needFightReconnect = false
	self._fightReason = nil
	self._userSpeed = 1
	self._gmOpenFightJoin = false
	self._isClickEnemy = false
	self.autoPlayCardList = {}
	self._guideParam = {
		OnGuideFightEndPause = false,
		OnGuideEntityDeadPause = false,
		OnGuideDistributePause = false,
		OnGuideCardEndPause = false,
		OnGuideFightEndPause_sp = false,
		OnGuideBeforeSkillPause = false
	}
	self._startFinish = false
	self.roundOffset = 0
end

function FightModel:reInit()
	self.needFightReconnect = false
end

function FightModel:clear()
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	FightModel.forceParallelSkill = false
	self._curWaveId = 1

	FightPlayCardModel.instance:clearUsedCards()
	self:resetRTPCSpeedTo1()

	self._userSpeed = 1
	self._historyRoundMOList = nil

	self:getMagicCircleInfo():clear()

	self.stressBehaviourDict = nil
	self.entitySpAttrMoDict = nil
	self.notifyEntityId = nil
	self.canContractList = nil
	self.contractEntityUid = nil
	self.beContractEntityUid = nil
	self.roundOffset = 0
	self.removeActEffectObj = nil
	self.smallSkillIcon = nil
	self.bigSkillIcon = nil
	self.needPlay500MRemoveActEffect = nil
	self.multiHpType = nil
	self.isHideCard = nil
end

function FightModel:onRestart()
	self:clear()
end

function FightModel:onSwitchPlane()
	self:clear()
end

function FightModel:setFightParam(fightParam)
	self._historyRoundMOList = nil
	self._fightParam = fightParam

	if self._fightParam.monsterGroupIds then
		self.maxWave = #self._fightParam.monsterGroupIds or 0
	end
end

function FightModel:getGuideParam()
	return self._guideParam
end

function FightModel:getFightParam()
	return self._fightParam
end

function FightModel:updateMySide(fightGroup)
	local fightParam = self:getFightParam()

	if fightParam then
		fightParam:setMySide(fightGroup.clothId, fightGroup.heroList, fightGroup.subHeroList, fightGroup.equips, fightGroup.activity104Equips, fightGroup.trialHeroList, fightGroup.extraList, fightGroup.assistBossId, fightGroup.params)
	end
end

function FightModel:recordFightGroup(fightGroup)
	self.last_fightGroup = fightGroup
end

function FightModel:getCurWaveId()
	return self._curWaveId
end

function FightModel:getCurRoundId()
	return self._curRoundId - self.roundOffset
end

function FightModel:getMaxRound()
	return self.maxRound - self.roundOffset
end

function FightModel:setRoundOffset(offset)
	offset = offset or 0
	self.roundOffset = offset
end

function FightModel:getRecordMO()
	return self._recordMO
end

function FightModel:clearRecordMO()
	self._recordMO = nil
end

function FightModel:getFightReason()
	return self._fightReason
end

function FightModel:getHistoryRoundMOList()
	return self._historyRoundMOList
end

function FightModel:getSelectMonsterGroupId(groupIndex, battleId)
	local fightParam = self._fightParam

	if not battleId then
		local var_19_0

		if fightParam then
			::label_19_0::

			var_19_0 = fightParam.monsterGroupIds and fightParam.monsterGroupIds[groupIndex]
		end

		return var_19_0
	end

	if not fightParam or fightParam.battleId ~= battleId then
		fightParam = FightParam.New()

		fightParam:setBattleId(battleId)
	end

	local var_19_1

	if fightParam then
		::label_19_1::

		var_19_1 = fightParam.monsterGroupIds and fightParam.monsterGroupIds[groupIndex]
	end

	return var_19_1
end

function FightModel:getCurMonsterGroupId()
	return self._fightParam and self._fightParam.monsterGroupIds and self._fightParam.monsterGroupIds[self._curWaveId]
end

function FightModel:isShowSettlement()
	return self._fightParam and self._fightParam.isShowSettlement
end

function FightModel:getAfterStory()
	if self._fightParam and self._fightParam.episodeId then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(self._fightParam.episodeId)

		if episodeCO then
			return episodeCO.afterStory
		end
	end

	return 0
end

function FightModel:isStartFinish()
	return not FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter)
end

function FightModel:isFinish()
	return self._isFinish
end

function FightModel:getBattleId()
	return self._battleId
end

function FightModel:clearBattleId()
	self._battleId = nil
end

function FightModel:initSpeedConfig()
	if not self._normalSpeed then
		self._normalSpeed = {
			1,
			CommonConfig.instance:getConstNum(ConstEnum.FightSpeed)
		}

		local replaySpeed = CommonConfig.instance:getConstStr(ConstEnum.FightReplaySpeed)

		replaySpeed = FightStrUtil.instance:getSplitString2Cache(replaySpeed, true, "|", "#")
		self._replaySpeed = {
			replaySpeed[1][1],
			replaySpeed[2][1]
		}
		self._replayUISpeed = {
			replaySpeed[1][2],
			replaySpeed[2][2]
		}

		local arrs = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightSpeed), "#")

		self._bossSkillNormalSpeed = {
			arrs[1],
			arrs[2]
		}
		arrs = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightReplaySpeed), "#")
		self._bossSkillReplaySpeed = {
			arrs[1],
			arrs[2]
		}
		arrs = GameUtil.splitString2(lua_activity174_const.configDict[Activity174Enum.ConstKey.FightSpeed].value, true)
		self._douQuQuSpeed = {
			arrs[1][1],
			arrs[2][1]
		}
		self._douQuQuUISpeed = {
			arrs[1][2],
			arrs[2][2]
		}
		arrs = GameUtil.splitString2(lua_activity191_const.configDict[Activity191Enum.ConstKey.FightSpeed].value, true)
		self._douQuQu191Speed = {
			arrs[1][1],
			arrs[2][1]
		}
		self._douQuQu191UISpeed = {
			arrs[1][2],
			arrs[2][2]
		}
		arrs = GameUtil.splitString2(lua_rouge2_const.configDict[100].value, true)
		self._rouge2Speed = {
			arrs[1][1],
			arrs[2][1],
			arrs[3][1]
		}
		self._rouge2UISpeed = {
			arrs[1][2],
			arrs[2][2],
			arrs[3][2]
		}
		arrs = GameUtil.splitString2(lua_rouge2_const.configDict[31010].value, true)
		self._rouge2ExtraSpeed = {
			{
				arrs[1][1],
				arrs[1][3]
			},
			{
				arrs[2][1],
				arrs[2][3]
			},
			{
				arrs[3][1],
				arrs[3][3]
			}
		}
		arrs = GameUtil.splitString2(lua_survival_const.configDict[4704].value, true)
		self._shelterSpeed = {
			arrs[1][1],
			arrs[2][1],
			arrs[3][1]
		}
		self._shelterUISpeed = {
			arrs[1][2],
			arrs[2][2],
			arrs[3][2]
		}
		arrs = GameUtil.splitString2(lua_sodache_const.configDict[19].value, true)
		self._sdcSpeed = {
			arrs[1][1],
			arrs[2][1],
			arrs[3][1]
		}
		self._sdcUISpeed = {
			arrs[1][2],
			arrs[2][2],
			arrs[3][2]
		}
	end
end

function FightModel:getSpeed()
	if FightModel.instance.useExclusiveSpeed then
		return FightModel.instance.useExclusiveSpeed
	end

	self:initSpeedConfig()

	if FightDataHelper.fieldMgr:isSouDaChe() then
		return self._sdcSpeed[self._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:isRouge2() then
		if not self._rouge2Speed[self._userSpeed] then
			do
				local speed = 1

				return speed + self:getRouge2ExtraSpeed()
			end

			if FightDataHelper.fieldMgr:isShelter() then
				return self._shelterSpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:isSurvival() then
				return self._shelterSpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:isDouQuQu() then
				return self._douQuQuSpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:is191DouQuQu() then
				return self._douQuQu191Speed[self._userSpeed] or 1
			end

			if FightDataHelper.stateMgr.isReplay then
				if FightModel.instance.useBossSkillSpeed then
					return self._bossSkillReplaySpeed[self._userSpeed] or 1
				end

				return self._replaySpeed[self._userSpeed] or 1
			elseif FightModel.instance.useBossSkillSpeed then
				return self._bossSkillNormalSpeed[self._userSpeed] or 1
			end
		end
	end

	return self._normalSpeed[self._userSpeed] or 1
end

function FightModel:getRouge2ExtraSpeed()
	do return 0 end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		return 0
	end

	local roundData = FightDataHelper.roundMgr:getRoundData()

	if roundData then
		if not roundData.timelineCount then
			local timeCount = 0

			for i = #self._rouge2ExtraSpeed, 1, -1 do
				if timeCount >= self._rouge2ExtraSpeed[i][1] then
					return self._rouge2ExtraSpeed[i][2]
				end
			end

			return 0
		end
	end
end

function FightModel:addSpeed()
	self._userSpeed = self._userSpeed >= self:getMaxSpeed() and 1 or self._userSpeed + 1

	self:updateRTPCSpeed()

	return self._userSpeed
end

function FightModel:getMaxSpeed()
	if FightDataHelper.fieldMgr:isRouge2() then
		return 3
	end

	if FightDataHelper.fieldMgr:isShelter() then
		return 3
	end

	if FightDataHelper.fieldMgr:isSurvival() then
		return 3
	end

	if FightDataHelper.fieldMgr:isSouDaChe() then
		return 3
	end

	return 2
end

function FightModel:getNormalSpeed()
	self:initSpeedConfig()

	return self._normalSpeed[1] or 1
end

function FightModel:getReplaySpeed()
	self:initSpeedConfig()

	return self._replaySpeed[1] or 1
end

function FightModel:getUISpeed()
	self:initSpeedConfig()

	if FightDataHelper.fieldMgr:isSouDaChe() then
		return self._sdcUISpeed[self._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:isRouge2() then
		if not self._rouge2UISpeed[self._userSpeed] then
			do
				local speed = 1

				return speed + self:getRouge2ExtraSpeed()
			end

			if FightDataHelper.fieldMgr:isShelter() then
				return self._shelterUISpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:isSurvival() then
				return self._shelterUISpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:isDouQuQu() then
				return self._douQuQuUISpeed[self._userSpeed] or 1
			end

			if FightDataHelper.fieldMgr:is191DouQuQu() then
				return self._douQuQu191UISpeed[self._userSpeed] or 1
			end

			if FightDataHelper.stateMgr.isReplay then
				do return self._replayUISpeed[self._userSpeed] or 1 end

				goto label_34_0
			end
		end
	end

	do return 1 end

	::label_34_0::
end

function FightModel:setGMSpeed(normalSpeed, replaySpeed)
	self._normalSpeed = {
		normalSpeed,
		normalSpeed
	}
	self._replaySpeed = {
		replaySpeed,
		replaySpeed
	}

	self:updateRTPCSpeed()
end

function FightModel:getUserSpeed()
	return self._userSpeed
end

function FightModel:setUserSpeed(speed)
	speed = speed or 1
	speed = Mathf.Clamp(speed, 1, self:getMaxSpeed())
	self._userSpeed = speed or 1

	self:updateRTPCSpeed()
end

function FightModel:updateRTPCSpeed()
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, self:getSpeed())
end

function FightModel:resetRTPCSpeedTo1()
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, 1)
end

function FightModel:switchGMFightJoin()
	self._gmOpenFightJoin = not self._gmOpenFightJoin
end

function FightModel:isGMFightJoin()
	return self._gmOpenFightJoin
end

function FightModel:checkEnterUseFreeLimit()
	self._useFreeLimit = false
	self._checkFreeLimitChapterType = nil

	local episodeId = DungeonModel.instance.curSendEpisodeId
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if config then
		::label_42_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(config.chapterId)

		if chapterConfig and chapterConfig.enterAfterFreeLimit > 0 then
			if DungeonModel.instance:getChapterRemainingNum(chapterConfig.type) > 0 then
				self._useFreeLimit = true
			else
				self._checkFreeLimitChapterType = chapterConfig.type
			end
		end
	end
end

function FightModel:isEnterUseFreeLimit()
	if self._useFreeLimit then
		return true
	end

	return self._checkFreeLimitChapterType and DungeonModel.instance:getChapterRemainingNum(self._checkFreeLimitChapterType) > 0
end

function FightModel:canParallelSkill(fightStepData)
	if FightModel.forceParallelSkill then
		return true
	end

	if fightStepData and fightStepData.custom_ingoreParallelSkill then
		return false
	end

	local episodeId = FightDataHelper.fieldMgr.episodeId

	if episodeId == 11306 or episodeId == 21304 or episodeId == 1306 then
		return false
	end

	return FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stateMgr.isReplay or self:isGMFightJoin()
end

function FightModel:updateFight(fightData, changeWave)
	self._version = FightModel.GMForceVersion or fightData.version or 0

	if not changeWave then
		self._isRecord = fightData.isRecord
	end

	self._fightActType = fightData.fightActType or FightEnum.FightActType.Normal

	if self._fightActType == 0 then
		self._fightActType = FightEnum.FightActType.Normal
	end

	if not changeWave then
		FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Fight, fightData)
	end

	if self._version >= 3 then
		if not changeWave then
			self._curRoundId = fightData.curRound
		end
	else
		self._curRoundId = fightData.curRound
	end

	self._curWaveId = fightData.curWave
	self.maxRound = fightData.maxRound

	if not changeWave then
		self._isFinish = fightData.isFinish
	end

	self.power = fightData.attacker.power
	self.clothId = fightData.attacker.clothId
	self._battleId = fightData.battleId
	self.exTeamStr = fightData.attacker.exTeamStr

	if fightData.attacker and #fightData.attacker.skillInfos > 0 then
		self:_updatePlayerSkillInfo(fightData.attacker.skillInfos)
	end

	if fightData.magicCircle then
		self:getMagicCircleInfo():refreshData(fightData.magicCircle)
	end
end

function FightModel:updateFightRound(round)
	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, round)
	FightDataHelper.setRoundDataByProto(round)

	local roundData = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(roundData)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, roundData)
	FightLocalDataMgr.instance:afterPlayRoundData(roundData)
	roundData:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(roundData)
	self:updateSpAttributeMo(roundData.heroSpAttributes)

	self._isFinish = roundData.isFinish
	self.power = roundData.power

	if #roundData.skillInfos > 0 then
		self:_updatePlayerSkillInfo(roundData.skillInfos)
	end

	if self:getVersion() < 1 then
		FightPlayCardModel.instance:updateFightRound(roundData)
	end

	self.autoPlayCardList = {}
end

function FightModel:updateSpAttributeMo(heroSpAttributes)
	if #heroSpAttributes == 0 then
		return
	end

	self.entitySpAttrMoDict = self.entitySpAttrMoDict or {}

	for _, attribute in ipairs(heroSpAttributes) do
		local uid = attribute.uid
		local attrMo = self.entitySpAttrMoDict[uid]

		if not attrMo then
			attrMo = HeroSpAttributeMO.New()
			self.entitySpAttrMoDict[uid] = attrMo
		end

		attrMo:init(uid, attribute.attribute)
	end
end

function FightModel:getSpAttributeMo(uid)
	return self.entitySpAttrMoDict and self.entitySpAttrMoDict[uid]
end

function FightModel:updateClothSkillRound(round)
	local version = self:getVersion()

	if version < 5 then
		round.actPoint = FightDataHelper.operationDataMgr.actPoint
	end

	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, round)
	FightDataHelper.setRoundDataByProto(round)

	local roundData = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(roundData)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, roundData)
	FightLocalDataMgr.instance:afterPlayRoundData(roundData)
	roundData:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(roundData)

	self._isFinish = roundData.isFinish
	self.power = roundData.power

	if #roundData.skillInfos > 0 then
		self:_updatePlayerSkillInfo(roundData.skillInfos)
	end
end

function FightModel:onAutoRound(opers)
	self.autoPlayCardList = {}

	for _, oper in ipairs(opers) do
		local beginRoundOp = FightOperationItemData.New()

		beginRoundOp:setByProto(oper)
		table.insert(self.autoPlayCardList, beginRoundOp)
	end
end

function FightModel:_updatePlayerSkillInfo(skillInfos)
	self._clothSkillList = {}
	self._clothSkillDict = {}

	for _, one in ipairs(skillInfos) do
		local skillInfo = {
			skillId = one.skillId,
			cd = one.cd,
			needPower = one.needPower,
			type = one.type
		}

		table.insert(self._clothSkillList, skillInfo)

		self._clothSkillDict[one.skillId] = skillInfo
	end

	FightController.instance:dispatchEvent(FightEvent.OnClothSkillDataUpdate)
end

function FightModel:onEndRound()
	local version = FightModel.instance:getVersion()

	if version >= 3 then
		-- block empty
	else
		self._curRoundId = self._curRoundId + self._roundInc
	end

	self._roundInc = 1
	self.hasNextWave = false

	self:clearStressBehaviour()
end

function FightModel:updateRecord(record)
	self._recordMO = self._recordMO or FightRecordMO.New()

	self._recordMO:init(record)

	self._lastFightResult = self._recordMO.fightResult
end

function FightModel:getLastFightResult()
	return self._lastFightResult
end

function FightModel:onEndFight()
	self._isFinish = true
	self._clothSkillList = nil
	self._clothSkillDict = nil
	self.hasNextWave = false
end

function FightModel:updateFightReason(reason)
	self._fightReason = self._fightReason or FightReasonMO.New()

	self._fightReason:init(reason)
end

function FightModel:setNextWaveMsg(msg)
	self._roundInc = 0
	self.hasNextWave = true
end

function FightModel:getClothSkillList()
	return self._clothSkillList
end

function FightModel:setClickEnemyState(isClick)
	self._isClickEnemy = isClick
end

function FightModel:getClickEnemyState()
	return self._isClickEnemy
end

function FightModel:recordPassModel(proto)
	self.curFightModel = proto.isRecord

	local record_data = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	record_data = string.nilorempty(record_data) and {} or cjson.decode(record_data)

	if self._fightParam then
		record_data[tostring(self._fightParam.episodeId)] = proto.isRecord
	end

	PlayerPrefsHelper.setString(FightModel.getPrefsKeyFightPassModel(), cjson.encode(record_data))
end

function FightModel.getPrefsKeyFightPassModel()
	return PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.FightPassModel
end

function FightModel:setWaitIndicatorAnimation(isWait)
	self.waitIndicatorAnimation = isWait
end

function FightModel:isWaitIndicatorAnimation()
	return self.waitIndicatorAnimation
end

function FightModel:refreshBattleId(fightData)
	self._battleId = fightData.battleId

	if self._fightParam then
		self._fightParam:setBattleId(self._battleId)
	end
end

function FightModel:getMagicCircleInfo()
	self._magicCircleInfo = self._magicCircleInfo or FightMagicCircleInfo.New()

	return self._magicCircleInfo
end

function FightModel:getVersion()
	return self._version or 0
end

function FightModel:getFightActType()
	return self._fightActType
end

function FightModel:isRecord()
	return self._isRecord
end

function FightModel:setRougeExData(index, num)
	local exTeamStr = FightModel.instance.exTeamStr
	local arr = string.split(exTeamStr, "#")

	arr[1] = arr[1] or 0
	arr[2] = arr[2] or 0
	arr[3] = arr[3] or 0
	arr[4] = arr[4] or cjson.encode({})
	arr[index] = num
	FightModel.instance.exTeamStr = string.format("%s#%s#%s#%s", arr[1], arr[2], arr[3], arr[4])
end

function FightModel:getRougeExData(index)
	local arr = string.split(FightModel.instance.exTeamStr, "#")

	if index == FightEnum.ExIndexForRouge.SupportHeroSkill then
		return arr[index] or cjson.encode({})
	end

	return tonumber(arr[index]) or 0
end

function FightModel:isAbort()
	return self._recordMO and self._recordMO.fightResult == FightEnum.FightResult.Abort
end

function FightModel:isFail()
	return self._recordMO and self._recordMO.fightResult == FightEnum.FightResult.Fail
end

function FightModel:setCurSceneOriginPos(x, y, z)
	self.originX, self.originY, self.originZ = x, y, z
end

function FightModel:getCurSceneOriginPos()
	return self.originX, self.originY, self.originZ
end

function FightModel:isSeason2()
	return self:getFightActType() == FightEnum.FightActType.Season2
end

function FightModel:recordDelayHandleStressBehaviour(actEffectData)
	if not actEffectData then
		return
	end

	self.stressBehaviourDict = self.stressBehaviourDict or {}

	local queue = self.stressBehaviourDict[actEffectData.targetId]

	if not queue then
		queue = {}
		self.stressBehaviourDict[actEffectData.targetId] = queue
	end

	table.insert(queue, actEffectData)
end

function FightModel:popNoHandledStressBehaviour(entityId)
	if entityId then
		::label_78_0::

		local var_78_0 = self.stressBehaviourDict

		if self.stressBehaviourDict then
			local queue = self.stressBehaviourDict[entityId]

			return queue and table.remove(queue, 1)
		end
	end
end

function FightModel:clearStressBehaviour()
	if self.stressBehaviourDict then
		for _, queue in pairs(self.stressBehaviourDict) do
			tabletool.clear(queue)
		end
	end
end

function FightModel:setNotifyContractInfo(entityId, entityIdList)
	self.notifyEntityId = entityId
	self.canContractList = entityIdList
end

function FightModel:setContractEntityUid(entityUid)
	self.contractEntityUid = entityUid
end

function FightModel:setBeContractEntityUid(entityUid)
	self.beContractEntityUid = entityUid
end

function FightModel:isBeContractEntity(entityId)
	return entityId == self.beContractEntityUid
end

function FightModel:setSkillIcon(smallSkillIcon, bigSkillIcon)
	self.smallSkillIcon = smallSkillIcon
	self.bigSkillIcon = bigSkillIcon
end

function FightModel:setIsHideCard(isHide)
	self.isHideCard = isHide
end

function FightModel:getHandCardSkillIcon(entityId, skillCo)
	if not skillCo then
		return
	end

	local skillCardLv = FightCardDataHelper.getSkillLv(self.entityId, skillCo.id)

	if skillCardLv == FightEnum.UniqueSkillCardLv then
		return string.nilorempty(self.bigSkillIcon) and ResUrl.getSkillIcon(skillCo.icon) or ResUrl.getSkillIcon(self.bigSkillIcon)
	end

	return string.nilorempty(self.smallSkillIcon) and ResUrl.getSkillIcon(skillCo.icon) or ResUrl.getSkillIcon(self.smallSkillIcon)
end

function FightModel:setRemoveActEffectObj(effectObj)
	self.removeActEffectObj = effectObj
end

function FightModel:getRemoveActEffectObj()
	return self.removeActEffectObj
end

function FightModel:setNeedPlay500MRemoveActEffect(need)
	self.needPlay500MRemoveActEffect = need
end

function FightModel:getNeedPlay500MRemoveActEffect()
	return self.needPlay500MRemoveActEffect
end

function FightModel:setMultiHpType(multiHpType)
	self.multiHpType = multiHpType
end

function FightModel:getMultiHpType()
	return self.multiHpType or FightEnum.MultiHpType.Default
end

function FightModel:setBulletTimeBuffId(buffId)
	self.bulletTimeBuffId = buffId
end

function FightModel:getBulletTimeBuffId()
	return self.bulletTimeBuffId
end

FightModel.instance = FightModel.New()

return FightModel
