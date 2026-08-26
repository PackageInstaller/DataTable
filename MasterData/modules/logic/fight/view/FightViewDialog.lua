-- chunkname: @modules/logic/fight/view/FightViewDialog.lua

module("modules.logic.fight.view.FightViewDialog", package.seeall)

local FightViewDialog = class("FightViewDialog", BaseView)

FightViewDialog.Type = {
	BeforeSkill = 10,
	MonsterSpawn = 1,
	MonsterDieP = 16,
	AttackStart = 5,
	MonsterWave = 11,
	SkillStart = 7,
	RoundStart = 4,
	DetectFail31 = 32,
	BeforeMonsterA2B = 25,
	RoundEndAndCheckBuff = 22,
	BuffRoundAfter = 19,
	MonsterWaveEnd = 12,
	Success = 36,
	Trigger = 999,
	MonsterWaveEndAndCheckBuffId = 17,
	BuffAdd = 13,
	BuffRoundBefore = 18,
	HPRateAfterSkillP = 14,
	CharacterDie = 6,
	FightFail = 21,
	MonsterChangeAfter = 9,
	BossDieTimelineBefore = 29,
	DetectFail33 = 34,
	CheckDeadEntityCount = 20,
	MonsterChangeBefore = 8,
	MonsterDie = 2,
	HPRateAfterSkillNP = 15,
	checkHaveMagicCircle = 23,
	HaveBuffAndHaveDamageSkill_onlyCheckOnce = 31,
	AfterSummon = 35,
	BeforeStartFightAndXXTimesEnterBattleId = 37,
	DetectHaveCardAfterEndOperation = 33,
	BeforeStartFight = 24,
	AfterAppearTimeline = 27,
	ChangeCareer = 28,
	DeadPerformanceNoCondition = 30,
	AfterMonsterA2B = 26,
	NoCondition = 38,
	NewHeroSpawn = 3
}

local deadMonsterId

function FightViewDialog:onInitView()
	self._godialogcontainer = gohelper.findChild(self.viewGO, "root/#go_dialogcontainer")
	self._godialog = gohelper.findChild(self.viewGO, "root/#go_dialogcontainer/#go_dialog")
	self._godialog2 = gohelper.findChild(self.viewGO, "root/#go_dialogcontainer/#go_dialog2")
	self._click = gohelper.getClick(self._godialogcontainer)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewDialog:addEvents()
	self._click:AddClickListener(self._onClickThis, self)
end

function FightViewDialog:removeEvents()
	self._click:RemoveClickListener()
end

function FightViewDialog:_editableInitView()
	gohelper.setActive(self._godialogcontainer, false)
	gohelper.setActive(self._godialog, false)
	gohelper.setActive(self._godialog2, false)
	gohelper.addChild(self.viewGO, self._godialogcontainer)

	self._dialogItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._godialog, FightViewDialogItem, self)
	self._dialogItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._godialog2, FightViewDialogItem2, self)
	self._toShowConfigList = {}
	self._showedDialogIdDict = {}
	self._showingItemList = {}

	self:_initConfig()

	self._playedDeadEnemyMOList = {}
end

function FightViewDialog:_initConfig()
	self._dialogChecks = {}

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local episodeId = fightParam.episodeId
	local hasPassLevel = episodeId and episodeId ~= 0 and DungeonModel.instance:hasPassLevel(episodeId)
	local battleId = fightParam.battleId

	for _, dialogConfig in ipairs(lua_battle_dialog.configList) do
		if dialogConfig.code == battleId and (not hasPassLevel or dialogConfig.canRepeat) then
			local dialog = string.splitToNumber(dialogConfig.param, "#")
			local dialogCheck = {}

			dialogCheck.type = dialog[1]
			dialogCheck.param1 = dialog[2]
			dialogCheck.param2 = dialog[3]
			dialogCheck.param3 = dialog[4]
			dialogCheck.param4 = dialog[5]
			dialogCheck.dialogConfig = dialogConfig

			table.insert(self._dialogChecks, dialogCheck)
		end
	end
end

function FightViewDialog:_checkShowDialog(type, param1, param2, checkFun)
	if self:_isReplay() then
		return
	end

	local showCount = 0

	for i, dialogCheck in ipairs(self._dialogChecks) do
		local dialogConfig = dialogCheck.dialogConfig
		local isType = dialogCheck.type == type

		if not dialogConfig.insideRepeat then
			local canRepeat = not self._showedDialogIdDict[dialogConfig.id]
			local checkFunSucc = isType and checkFun and checkFun(dialogCheck)
			local param1Succ = not dialogCheck.param1 or dialogCheck.param1 == param1
			local param2Succ = not dialogCheck.param2 or dialogCheck.param2 == param2

			if isType and canRepeat and (checkFunSucc or param1Succ and param2Succ) then
				table.insert(self._toShowConfigList, dialogConfig)

				self._showedDialogIdDict[dialogConfig.id] = true
				showCount = showCount + 1
			end
		end
	end

	if showCount <= 0 then
		return
	end

	FightViewDialog.showFightDialog = true
	self._showingType = self._showingType or {}
	self._showingType[type] = true

	if self._godialogcontainer.activeInHierarchy then
		return #self._toShowConfigList > 0
	else
		return self:_tryShow()
	end
end

function FightViewDialog:_playDialogByTrigger(dialogConfig)
	table.insert(self._toShowConfigList, dialogConfig)

	self._showingType = self._showingType or {}
	self._showingType[FightViewDialog.Type.Trigger] = true

	return self:_tryShow()
end

function FightViewDialog:_tryShow()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	if #self._toShowConfigList <= 0 then
		FightModel.instance:updateRTPCSpeed()

		return false
	end

	gohelper.setActive(self._godialogcontainer, true)

	local dialogConfig = self._toShowConfigList[1]

	table.remove(self._toShowConfigList, 1)

	self._tempDialogConfig = dialogConfig

	if dialogConfig.delay and dialogConfig.delay > 0 then
		self:_addBlock()
		gohelper.setActive(self._godialog, false)
		gohelper.setActive(self._godialog2, false)
		TaskDispatcher.runDelay(self._playDialogItem, self, dialogConfig.delay)
	else
		self:_playDialogItem()
	end

	FightViewDialog.playingDialog = true

	FightController.instance:dispatchEvent(FightEvent.FightDialogShow, dialogConfig)

	return true
end

function FightViewDialog:_playDialogItem()
	self:_removeBlock()

	local dialogConfig = self._tempDialogConfig

	if dialogConfig.type == 2 then
		gohelper.setActive(self._godialog2, true)
	else
		gohelper.setActive(self._godialog, true)
	end

	local icon

	if not string.nilorempty(dialogConfig.icon) then
		icon = ResUrl.getHeadIconSmall(dialogConfig.icon)
	end

	self._dialogItem:showDialogContent(icon, dialogConfig)
	self._dialogItem2:showDialogContent(icon, dialogConfig)

	if dialogConfig.audioId and dialogConfig.audioId ~= 0 then
		self._audioId = dialogConfig.audioId

		FightAudioMgr.instance:playAudio(dialogConfig.audioId)
		FightModel.instance:resetRTPCSpeedTo1()
	end

	FightController.instance:dispatchEvent(FightEvent.PlayDialog, dialogConfig.id)
end

function FightViewDialog:_addBlock()
	self._hasBlockUI = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightDialog)
end

function FightViewDialog:_removeBlock()
	if self._hasBlockUI then
		self._hasBlockUI = nil

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	end
end

function FightViewDialog:_onClickThis()
	FightViewDialog.playingDialog = false

	if self._tempDialogConfig then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayDialog, self._tempDialogConfig.id)
	end

	if not self:_tryShow() then
		gohelper.setActive(self._godialogcontainer, false)
		gohelper.setActive(self._godialog, false)
		gohelper.setActive(self._godialog2, false)

		local showTypes = tabletool.copy(self._showingType)

		self._showingType = nil

		if showTypes[FightViewDialog.Type.BeforeSkill] then
			FightController.instance:dispatchEvent(FightEvent.DialogContinueSkill)
		end

		if showTypes[FightViewDialog.Type.Trigger] then
			FightController.instance:dispatchEvent(FightEvent.TriggerDialogEnd)
		end

		FightController.instance:dispatchEvent(FightEvent.FightDialogEnd)
	end
end

function FightViewDialog:onOpen()
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	FightController.instance:registerCallback(FightEvent.OnStartChangeEntity, self._onStartChangeEntity, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect1, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect2, self)
	FightController.instance:registerCallback(FightEvent.OnStartFightPlayBornNormal, self._onStartFightPlayBornNormal, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, self._onInvokeSkill, self)
	FightController.instance:registerCallback(FightEvent.BeforeSkillDialog, self._beforeSkill, self)
	FightController.instance:registerCallback(FightEvent.FightDialog, self._onFightDialogCheck, self)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	FightController.instance:registerCallback(FightEvent.HideFightDialog, self._onHideFightDialog, self)
end

function FightViewDialog:onClose()
	FightViewDialog.playingDialog = false

	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnStartChangeEntity, self._onStartChangeEntity, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect1, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self._beforeDeadEffect2, self)
	FightController.instance:unregisterCallback(FightEvent.OnStartFightPlayBornNormal, self._onStartFightPlayBornNormal, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, self._onInvokeSkill, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeSkillDialog, self._beforeSkill, self)
	FightController.instance:unregisterCallback(FightEvent.FightDialog, self._onFightDialogCheck, self)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)
	FightController.instance:unregisterCallback(FightEvent.HideFightDialog, self._onHideFightDialog, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseSpecialView, self)
end

function FightViewDialog:_onBuffUpdate(entityId, effectType, buffId, buffUid, configEffect)
	if effectType == FightEnum.EffectType.BUFFADD then
		self:_checkShowDialog(FightViewDialog.Type.BuffAdd, buffId)
	end
end

function FightViewDialog:_isReplay()
	return FightDataHelper.stateMgr.isReplay
end

function FightViewDialog:_onStartSequenceFinish()
	return
end

function FightViewDialog:_onCloseSpecialView(viewName)
	return
end

function FightViewDialog:_onRoundSequenceFinish()
	return
end

function FightViewDialog:_onHideFightDialog()
	gohelper.setActive(self._godialogcontainer, false)
end

function FightViewDialog:_onStartChangeEntity(entityMO)
	if not entityMO then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local mySideSubUids = fightParam.mySideSubUids

	if not mySideSubUids then
		return
	end

	for index, subUid in ipairs(mySideSubUids) do
		if subUid == entityMO.uid then
			self:_checkShowDialog(FightViewDialog.Type.NewHeroSpawn, index)

			return
		end
	end
end

function FightViewDialog:_beforeDeadEffect1(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local monsterGroupIds = fightParam.monsterGroupIds
	local curMonsterGroupId = FightModel.instance:getCurMonsterGroupId()

	for i, monsterGroupId in ipairs(monsterGroupIds) do
		if monsterGroupId == curMonsterGroupId then
			break
		end

		local monsterGroupConfig = lua_monster_group.configDict[monsterGroupId]
		local monsterList = FightStrUtil.instance:getSplitToNumberCache(monsterGroupConfig.monster, "#")

		for _, monsterId in ipairs(monsterList) do
			if monsterId == tonumber(entityMO.modelId) then
				return
			end
		end

		if not string.nilorempty(monsterGroupConfig.spMonster) then
			local spMonsterList = FightStrUtil.instance:getSplitToNumberCache(monsterGroupConfig.spMonster, "#")

			for _, monsterId in ipairs(spMonsterList) do
				if monsterId == tonumber(entityMO.modelId) then
					return
				end
			end
		end
	end

	local deadEnemyMOList = {}

	for i, v in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if v:isStatusDead() then
			table.insert(deadEnemyMOList, v)
		end
	end

	local allEnemyMOList = {}

	for i, deadEnemyMO in ipairs(deadEnemyMOList) do
		table.insert(allEnemyMOList, deadEnemyMO)
	end

	for i, enemyMO in ipairs(self._playedDeadEnemyMOList) do
		table.insert(allEnemyMOList, enemyMO)
	end

	for _, enemyMO in ipairs(allEnemyMOList) do
		if enemyMO.uid ~= entityMO.uid and enemyMO.modelId == entityMO.modelId then
			return
		end

		if enemyMO.uid == entityMO.uid then
			break
		end
	end

	table.insert(self._playedDeadEnemyMOList, entityMO)
	self:_checkShowDialog(FightViewDialog.Type.MonsterDie, tonumber(entityMO.modelId))
end

function FightViewDialog:_beforeDeadEffect2(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	if not entityMO:isCharacter() then
		return
	end

	self:_checkShowDialog(FightViewDialog.Type.CharacterDie)
end

function FightViewDialog:_onStartFightPlayBornNormal(entityId)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if not entityMO then
		return
	end

	local fightParam = FightModel.instance:getFightParam()
	local monsterGroupIds = fightParam.monsterGroupIds
	local curMonsterGroupId = FightModel.instance:getCurMonsterGroupId()

	for i, monsterGroupId in ipairs(monsterGroupIds) do
		if monsterGroupId == curMonsterGroupId then
			break
		end

		local monsterGroupConfig = lua_monster_group.configDict[monsterGroupId]
		local monsterList = FightStrUtil.instance:getSplitToNumberCache(monsterGroupConfig.monster, "#")

		for _, monsterId in ipairs(monsterList) do
			if monsterId == tonumber(entityMO.modelId) then
				return
			end
		end

		if not string.nilorempty(monsterGroupConfig.spMonster) then
			local spMonsterList = FightStrUtil.instance:getSplitToNumberCache(monsterGroupConfig.spMonster, "#")

			for _, monsterId in ipairs(spMonsterList) do
				if monsterId == tonumber(entityMO.modelId) then
					return
				end
			end
		end
	end

	local allEnemyMOList = {}
	local enemyMOList = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, nil, true)

	for i, enemyMO in ipairs(enemyMOList) do
		table.insert(allEnemyMOList, enemyMO)
	end

	for _, enemyMO in ipairs(allEnemyMOList) do
		if enemyMO.uid ~= entityMO.uid and enemyMO.modelId == entityMO.modelId then
			return
		end

		if enemyMO.uid == entityMO.uid then
			break
		end
	end

	self:_checkShowDialog(FightViewDialog.Type.MonsterSpawn, tonumber(entityMO.modelId))
end

function FightViewDialog:onDestroyView()
	self:_removeBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	TaskDispatcher.cancelTask(self._playDialogItem, self)
	self._dialogItem:onDestroy()
	self._dialogItem2:onDestroy()
end

function FightViewDialog:_onSkillPlayStart(entity, skillId, fightStepData)
	local attacker = FightHelper.getEntity(fightStepData.fromId)
	local defender = FightHelper.getEntity(fightStepData.toId)
	local attackerMO = attacker and attacker:getMO()
	local defenderMO = defender and defender:getMO()
	local attackId = attackerMO and attackerMO.modelId
	local defenderId = defenderMO and defenderMO.modelId

	self:_checkShowDialog(FightViewDialog.Type.AttackStart, attackId, defenderId)
	self:_checkShowDialog(FightViewDialog.Type.SkillStart, fightStepData.actId)
end

function FightViewDialog:_onInvokeSkill(fightStepData)
	self:_checkShowDialog(FightViewDialog.Type.SkillStart, fightStepData.actId)
end

function FightViewDialog:_beforeSkill(skillId)
	local result = self:_checkShowDialog(FightViewDialog.Type.BeforeSkill, skillId)

	if result then
		FightWorkStepSkill.needWaitBeforeSkill = true
	end
end

function FightViewDialog:_onFightDialogCheck(dialogType, param1, param2, param3)
	FightViewDialog.showFightDialog = nil

	if dialogType == FightViewDialog.Type.MonsterWave then
		local waveId = param1

		if self:_checkShowDialog(dialogType, waveId) then
			if waveId == 1 then
				FightStartSequence.needStopMonsterWave = true
			else
				FightWorkStepChangeWave.needStopMonsterWave = true
			end
		end
	elseif dialogType == FightViewDialog.Type.MonsterWaveEnd then
		local waveId = param1

		if self:_checkShowDialog(dialogType, waveId) then
			local maxWave = FightModel.instance.maxWave

			if waveId < maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif dialogType == FightViewDialog.Type.HPRateAfterSkillP then
		if self:_checkShowDialog(dialogType, nil, nil, self._checkHpLessThan) then
			FightWorkStepSkill.needStopSkillEnd = true
		end
	elseif dialogType == FightViewDialog.Type.HPRateAfterSkillNP then
		self:_checkShowDialog(dialogType, nil, nil, self._checkHpLessThan)
	elseif dialogType == FightViewDialog.Type.MonsterDieP then
		deadMonsterId = param1

		if deadMonsterId and self:_checkShowDialog(dialogType, nil, nil, self._detectMonsterDie) then
			FightWorkEffectDeadNew.needStopDeadWork = true
		end
	elseif dialogType == FightViewDialog.Type.MonsterWaveEndAndCheckBuffId then
		local waveId = param1

		if self:_checkShowDialog(dialogType, waveId, nil, self._checkMonsterWaveEndAndCheckBuffId) then
			local maxWave = FightModel.instance.maxWave

			if waveId < maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif dialogType == FightViewDialog.Type.Trigger then
		self:_playDialogByTrigger(param1)
	elseif dialogType == FightViewDialog.Type.BuffRoundBefore then
		if self:_checkShowDialog(dialogType, nil, nil, self._checkFirstGetBuff) then
			FightWorkShowBuffDialog.needStopWork = self._tempDialogConfig
		end
	elseif dialogType == FightViewDialog.Type.BuffRoundAfter then
		if self:_checkShowDialog(dialogType, nil, nil, self._checkHasBuff) then
			FightWorkShowBuffDialog.needStopWork = self._tempDialogConfig
		end
	elseif dialogType == FightViewDialog.Type.RoundEndAndCheckBuff then
		if self:_checkShowDialog(dialogType, nil, nil, self._checkEntityBuff) then
			FightWorkShowBuffDialog.needStopWork = self._tempDialogConfig
		end
	elseif dialogType == FightViewDialog.Type.checkHaveMagicCircle then
		if self:_checkShowDialog(dialogType, nil, nil, self._checkHaveMagicCircle) and not self._playedShuZhen then
			self._playedShuZhen = true
			FightWorkShowBuffDialog.needStopWork = self._tempDialogConfig
		end
	elseif dialogType == FightViewDialog.Type.CheckDeadEntityCount then
		local count = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)

		self:_checkShowDialog(dialogType, count)
	elseif dialogType == FightViewDialog.Type.FightFail then
		self:_checkShowDialog(dialogType)
	elseif dialogType == FightViewDialog.Type.BeforeStartFight then
		self:_checkShowDialog(dialogType)
	elseif dialogType == FightViewDialog.Type.BeforeMonsterA2B then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.AfterMonsterA2B then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.MonsterChangeBefore then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.MonsterChangeAfter then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.AfterAppearTimeline then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.ChangeCareer then
		self:_checkShowDialog(dialogType)
	elseif dialogType == FightViewDialog.Type.BossDieTimelineBefore then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.DeadPerformanceNoCondition then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce then
		self:_onHaveBuffAndHaveDamageSkill_onlyCheckOnce()
	elseif dialogType == FightViewDialog.Type.DetectHaveCardAfterEndOperation then
		self:_onDetectHaveCardAfterEndOperation(param1)
	elseif dialogType == FightViewDialog.Type.AfterSummon then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.Success then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.BeforeStartFightAndXXTimesEnterBattleId then
		self:_checkShowDialog(dialogType, nil, nil, self._onCheckBeforeStartFightAndXXTimesEnterBattleId)
	elseif dialogType == FightViewDialog.Type.NoCondition then
		self:_checkShowDialog(dialogType, param1)
	elseif dialogType == FightViewDialog.Type.RoundStart then
		self:_checkShowDialog(FightViewDialog.Type.RoundStart, param1)
	end
end

function FightViewDialog:_haveSkillCard(skillId)
	local ops = FightDataHelper.operationDataMgr:getOpList()

	for i, v in ipairs(ops) do
		if v:isPlayCard() and skillId == v.skillId then
			return true
		end
	end
end

function FightViewDialog:_onDetectHaveCardAfterEndOperation()
	for i, dialogCheck in ipairs(self._dialogChecks) do
		local dialogConfig = dialogCheck.dialogConfig
		local isType = dialogCheck.type == FightViewDialog.Type.DetectHaveCardAfterEndOperation

		if isType then
			if not dialogConfig.insideRepeat then
				if dialogConfig.insideRepeat then
					local buffId = dialogCheck.param1
					local skillId = dialogCheck.param2
					local list = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)

					for e_index, entityMO in ipairs(list) do
						local isEnemySide = entityMO.side == FightEnum.EntitySide.EnemySide

						if isEnemySide then
							local buffDic = entityMO:getBuffDic()

							for b_index, buffMO in pairs(buffDic) do
								if buffMO.buffId == buffId then
									local have = self:_haveSkillCard(skillId)

									if have then
										self:_checkShowDialog(dialogCheck.type, buffId, skillId)
									else
										self:_checkShowDialog(FightViewDialog.Type.DetectFail33, buffId, skillId)
									end

									self._showedDialogIdDict[dialogConfig.id] = true
								end
							end
						end
					end
				end
			end
		end
	end
end

function FightViewDialog:_detectStepIsDamgeSkill(fightStepData)
	if fightStepData.actType == FightEnum.ActType.SKILL or fightStepData.actType == FightEnum.ActType.EFFECT then
		if fightStepData.actType == FightEnum.ActType.SKILL and fightStepData.fromId ~= FightEntityScene.MySideId then
			local fromEntity = FightHelper.getEntity(fightStepData.fromId)

			if fromEntity and fromEntity:isMySide() then
				local skillConfig = lua_skill.configDict[fightStepData.actId]

				if skillConfig and skillConfig.damageRate > 0 then
					return true
				end
			end
		end

		local effectHaveDamgeSkill = self:_haveDamageSkillactEffect(fightStepData.actEffect)

		if effectHaveDamgeSkill then
			return true
		end
	end
end

function FightViewDialog:_haveDamageSkill(roundData)
	for s_index, fightStepData in ipairs(roundData) do
		local have = self:_detectStepIsDamgeSkill(fightStepData)

		if have then
			return true
		end
	end
end

function FightViewDialog:_haveDamageSkillactEffect(actEffect)
	for i, v in ipairs(actEffect) do
		local fightStepData = v.fightStep

		if fightStepData then
			local have = self:_detectStepIsDamgeSkill(fightStepData)

			if have then
				return
			end
		end
	end
end

function FightViewDialog._onCheckBeforeStartFightAndXXTimesEnterBattleId(dialogCheck)
	local battleId = FightDataHelper.fieldMgr.battleId
	local matchBattleId = dialogCheck.param1

	if battleId == matchBattleId then
		local key = PlayerPrefsKey.EnterBattleIdTimes .. battleId
		local times = PlayerPrefsHelper.getNumber(key, 0)

		times = times + 1

		PlayerPrefsHelper.setNumber(key, times)

		if times >= dialogCheck.param2 then
			return true
		end
	end
end

function FightViewDialog:_onHaveBuffAndHaveDamageSkill_onlyCheckOnce()
	for i, dialogCheck in ipairs(self._dialogChecks) do
		local dialogConfig = dialogCheck.dialogConfig
		local isType = dialogCheck.type == FightViewDialog.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce

		if isType then
			if not dialogConfig.insideRepeat then
				if dialogConfig.insideRepeat then
					local buffId = dialogCheck.param1
					local list = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)

					for e_index, entityMO in ipairs(list) do
						local isEnemySide = entityMO.side == FightEnum.EntitySide.EnemySide

						if isEnemySide then
							local buffDic = entityMO:getBuffDic()

							for b_index, buffMO in pairs(buffDic) do
								if buffMO.buffId == buffId then
									local roundData = FightDataHelper.roundMgr:getRoundData()
									local have = roundData and self:_haveDamageSkill(roundData.fightStep)

									if have then
										self:_checkShowDialog(dialogCheck.type, buffId)
									else
										self:_checkShowDialog(FightViewDialog.Type.DetectFail31, buffId)
									end

									self._showedDialogIdDict[dialogConfig.id] = true
								end
							end
						end
					end
				end
			end
		end
	end
end

function FightViewDialog._checkFirstGetBuff(dialogCheck)
	local buffId = dialogCheck.param1

	FightViewDialog._checkBuffState(buffId)

	local roundId = dialogCheck.param2

	if not FightWorkShowBuffDialog.addBuffRoundId and roundId == FightModel.instance:getCurRoundId() then
		return true
	end
end

function FightViewDialog._checkEntityBuff(dialogCheck)
	local buffId = dialogCheck.param1

	if FightViewDialog._hasBuff(buffId) then
		return true
	end
end

function FightViewDialog._checkHaveMagicCircle(dialogCheck)
	local magicCircleInfo = FightModel.instance:getMagicCircleInfo()

	if magicCircleInfo.magicCircleId then
		if magicCircleInfo.magicCircleId == dialogCheck.param1 then
			return true
		end

		if magicCircleInfo.magicCircleId == dialogCheck.param2 then
			return true
		end

		if magicCircleInfo.magicCircleId == dialogCheck.param3 then
			return true
		end

		if magicCircleInfo.magicCircleId == dialogCheck.param4 then
			return true
		end
	end
end

function FightViewDialog._checkHasBuff(dialogCheck)
	local buffId = dialogCheck.param1

	FightViewDialog._checkBuffState(buffId)

	local curRoundId = FightModel.instance:getCurRoundId()
	local roundId = dialogCheck.param2

	if FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		return roundId == curRoundId - FightWorkShowBuffDialog.addBuffRoundId + 1
	end
end

function FightViewDialog._checkBuffState(buffId)
	local curRoundId = FightModel.instance:getCurRoundId()
	local hasBuff = FightViewDialog._hasBuff(buffId)

	if hasBuff then
		FightWorkShowBuffDialog.addBuffRoundId = FightWorkShowBuffDialog.addBuffRoundId or curRoundId
	elseif FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		FightWorkShowBuffDialog.delBuffRoundId = curRoundId
	end
end

function FightViewDialog._hasBuff(buffId)
	local entitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(entitys) do
		local buffDic = entity:getMO():getBuffDic()

		for _, buffMO in pairs(buffDic) do
			if buffMO.buffId == buffId then
				return true
			end
		end
	end
end

local _hpEntityTemp

function FightViewDialog._checkHpLessThan(dialogCheck)
	local side = dialogCheck.param1
	local posId = dialogCheck.param2
	local rate = dialogCheck.param3
	local monsterId = dialogCheck.param4

	_hpEntityTemp = nil

	if posId == 0 then
		if side == 1 then
			if not FightEnum.EntitySide.EnemySide then
				local realSide = FightEnum.EntitySide.MySide

				_hpEntityTemp = FightHelper.getSideEntitys(realSide, false)
			end
		end
	else
		local entityMgr = FightGameMgr.entityMgr

		if side == 1 then
			if not SceneTag.UnitMonster then
				local tag = SceneTag.UnitPlayer
				local entity = entityMgr:getEntityByPosId(tag, posId)

				_hpEntityTemp = _hpEntityTemp or {}

				tabletool.clear(_hpEntityTemp)

				if entity then
					table.insert(_hpEntityTemp, entity)
				end
			end
		end
	end

	for _, entity in ipairs(_hpEntityTemp) do
		local entityMO = entity:getMO()

		if entityMO then
			if not entityMO.currentHp then
				local currentHp = 0

				if entityMO.attrMO and entityMO.attrMO.hp > 0 then
					if not entityMO.attrMO.hp then
						local maxHp = 1
						local hpPercent = currentHp / maxHp

						if hpPercent < rate / 1000 then
							if monsterId then
								if monsterId == entityMO.modelId then
									return true
								end
							else
								return true
							end
						end
					end
				end
			end
		end
	end
end

function FightViewDialog._checkMonsterWaveEndAndCheckBuffId(dialogCheck)
	local currWaveId = FightModel.instance:getCurWaveId()

	if currWaveId ~= dialogCheck.param1 then
		return
	end

	local buffId = dialogCheck.param2
	local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for i, v in ipairs(entityList) do
		local entityMO = v:getMO()
		local buffDic = entityMO and entityMO:getBuffDic()

		if buffDic then
			for index, buff in pairs(buffDic) do
				if buff.buffId == buffId then
					return true
				end
			end
		end
	end
end

function FightViewDialog._detectMonsterDie(dialogCheck)
	local monsterIds = FightStrUtil.instance:getSplitToNumberCache(dialogCheck.dialogConfig.param, "#")

	for i = 2, #monsterIds do
		if deadMonsterId == monsterIds[i] then
			return true
		end
	end
end

return FightViewDialog
