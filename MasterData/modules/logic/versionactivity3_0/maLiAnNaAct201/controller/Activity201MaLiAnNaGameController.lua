-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/Activity201MaLiAnNaGameController.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.Activity201MaLiAnNaGameController", package.seeall)

local Activity201MaLiAnNaGameController = class("Activity201MaLiAnNaGameController", BaseController)

function Activity201MaLiAnNaGameController:onInit()
	self:reInit()
end

function Activity201MaLiAnNaGameController:reInit()
	if self._actionList ~= nil then
		tabletool.clear(self._actionList)
	end

	self._isPause = true
	self._dialogDataCache = {}
	self._checkDialogList = {}
	self._isOver = false
	self._isTriggerBegin = false
	self._isTriggerEnd = true
end

function Activity201MaLiAnNaGameController:enterGame(gameId, episodeId)
	self:reInit()

	self.episodeId = episodeId

	MaLiAnNaStatHelper.instance:enterEpisode(episodeId)
	Activity201MaLiAnNaGameModel.instance:initGameData(gameId)
	MaliAnNaSoliderAiMgr.instance:initAiParamsById(gameId)
	ViewMgr.instance:openView(ViewName.MaLiAnNaNoticeView)
	UpdateBeat:Remove(self._update, self)
	UpdateBeat:Add(self._update, self)

	self._dialogData = Activity201MaLiAnNaConfig.instance:getLevelDialogConfig(gameId)

	self.registerCallback(self, Activity201MaLiAnNaEvent.SoliderDead, self._checkSoliderDead, self)
	self.registerCallback(self, Activity201MaLiAnNaEvent.OnSelectActiveSkill, self._checkUseSkillId, self)
	self.registerCallback(self, Activity201MaLiAnNaEvent.SlotChangeCamp, self._checkSlotChangeCamp, self)
	self.registerCallback(self, Activity201MaLiAnNaEvent.GamePause, self._setGamePause, self)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, self._guideFinish, self)
end

function Activity201MaLiAnNaGameController:restartGame()
	MaLiAnNaStatHelper.instance:enterEpisode(self.episodeId)
	self:reInit()

	local curGameId = Activity201MaLiAnNaGameModel.instance:getCurGameId()

	Activity201MaLiAnNaGameModel.instance:clear()
	MaliAnNaSoliderEntityMgr.instance:clear()
	MaliAnNaSoliderAiMgr.instance:clear()
	self:setPause(true)
	Activity201MaLiAnNaGameModel.instance:initGameData(curGameId)
	self:dispatchEvent(Activity201MaLiAnNaEvent.OnGameReStart)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)
end

function Activity201MaLiAnNaGameController:getCurEpisodeId()
	return self.episodeId
end

function Activity201MaLiAnNaGameController:_setGamePause(pause)
	local pause = tonumber(pause)

	self:setPause(pause == 1)
end

function Activity201MaLiAnNaGameController:setPause(isPause)
	self._isPause = isPause

	if isPause then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_warring_loop)

		self._isTriggerBegin = false
	end
end

function Activity201MaLiAnNaGameController:getPause()
	return self._isPause
end

function Activity201MaLiAnNaGameController:_update()
	if self._isPause then
		return
	end

	local delta = Time.deltaTime

	callWithCatch(self._tryCatchUpdate, self, delta)
end

function Activity201MaLiAnNaGameController:_tryCatchUpdate(delta)
	if not self._isOver then
		Activity201MaLiAnNaGameModel.instance:update(delta)
		self:useAction()
		MaliAnNaSoliderAiMgr.instance:update(delta)
	end

	self:dispatchEvent(Activity201MaLiAnNaEvent.OnRefreshView)
	self:_tickDisPatch()

	if self._isOver then
		self:setPause(true)
	end
end

function Activity201MaLiAnNaGameController:_tickDisPatch()
	if self._isPause then
		return
	end

	local needPlayEnd = false
	local needPlayBegin = false
	local allDisPatchSolider = Activity201MaLiAnNaGameModel.instance:allDisPatchSolider()

	for _, soliderMo in pairs(allDisPatchSolider) do
		if soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
			needPlayBegin = true
			needPlayEnd = false
		end
	end

	if needPlayBegin and not self._isTriggerBegin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_offensive_loop)

		self._isTriggerBegin = true
	end

	if (self._isTriggerBegin or nil) and true and self._isTriggerBegin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)

		self._isTriggerBegin = false
	end
end

function Activity201MaLiAnNaGameController:dispatchSolider(soliderMo)
	if soliderMo == nil then
		logError("士兵实体为空, 无法派遣")

		return
	end

	MaliAnNaSoliderEntityMgr.instance:getEntity(soliderMo)
	Activity201MaLiAnNaGameModel.instance:addDisPatchSolider(soliderMo)
	soliderMo:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
end

function Activity201MaLiAnNaGameController:soliderEnterSlot(soliderMo, slotId)
	if soliderMo == nil or slotId == nil then
		logError("士兵实体/据点ID为空, 无法进入据点")

		return
	end

	if soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.AttackSlot or soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.InSlot then
		return
	end

	local targetSlot = Activity201MaLiAnNaGameModel.instance:getSlotById(slotId)

	if targetSlot then
		local needChange, solider = targetSlot:enterSoldier(soliderMo)
		local attackSoliderCamp

		if needChange then
			attackSoliderCamp = soliderMo:getCamp()

			soliderMo:changeState(Activity201MaLiAnNaEnum.SoliderState.AttackSlot)

			if solider then
				solider:updateHp(0, true)
			end
		end

		local _, _, allCount = targetSlot:getSoliderCount()

		if attackSoliderCamp and allCount == 0 then
			targetSlot:createSolider(attackSoliderCamp)
		end
	end

	soliderMo:changeRecordSoliderState(false)
end

function Activity201MaLiAnNaGameController:soliderBattle(soliderMo1, soliderMo2)
	if soliderMo1 == nil or soliderMo2 == nil then
		return
	end

	if soliderMo1:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Attack or soliderMo2:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Attack then
		return
	end

	local x1, y1 = soliderMo1:getLocalPos()
	local x2, y2 = soliderMo2:getLocalPos()
	local posX = (x1 + x2) / 2
	local posY = (y1 + y2) / 2

	self:dispatchEvent(Activity201MaLiAnNaEvent.OnShowBattleEffect, posX, posY, Activity201MaLiAnNaEnum.attackTime, true)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_warring_loop)

	local hp1 = soliderMo1:getHp()
	local hp2 = soliderMo2:getHp()

	soliderMo1:updateHp(-hp2, false)
	soliderMo2:updateHp(-hp1, false)
	soliderMo1:changeState(Activity201MaLiAnNaEnum.SoliderState.Attack)
	soliderMo2:changeState(Activity201MaLiAnNaEnum.SoliderState.Attack)
end

function Activity201MaLiAnNaGameController:consumeSoliderHp(soliderId, diff)
	if soliderId == nil or diff == nil then
		return
	end

	local soliderMo = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(soliderId)

	if soliderMo == nil then
		return
	end

	if soliderMo:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Dead then
		return
	end

	local posX, posY = soliderMo:getLocalPos()

	self:dispatchEvent(Activity201MaLiAnNaEvent.OnShowBattleEffect, posX, posY, Activity201MaLiAnNaEnum.attackTime2, false)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_youyu_attack_3)
	soliderMo:updateHp(diff, true)
end

function Activity201MaLiAnNaGameController:soliderDead(soliderMo)
	if soliderMo == nil then
		return
	end

	local soliderId = soliderMo:getId()
	local isHero = soliderMo:isHero()

	MaliAnNaSoliderEntityMgr.instance:recycleEntity(soliderMo)
	Activity201MaLiAnNaGameModel.instance:soliderDead(soliderMo)
	soliderMo:changeRecordSoliderState(false)
	MaLiAnNaLaSoliderMoUtil.instance:recycleSoliderMo(soliderMo)

	if isHero then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.SoliderDead, soliderId)
	end
end

function Activity201MaLiAnNaGameController:addAction(effect, params)
	if self._actionList == nil then
		self._actionList = {}
	end

	table.insert(self._actionList, 1, {
		effect = tabletool.copy(effect),
		params = tabletool.copy(params)
	})
end

function Activity201MaLiAnNaGameController:useAction()
	if self._actionList == nil or #self._actionList == 0 then
		return
	end

	local count = #self._actionList

	for i = 1, count do
		local action = table.remove(self._actionList, 1)
		local effect = action.effect
		local actionType = effect[1]
		local params = action.params
		local actionFunc = MaLiAnNaActionUtils.instance:getHandleFunc(actionType)

		if actionFunc then
			actionFunc(params, effect)
		else
			logError("没有找到对应的action处理函数: ", actionType)
		end
	end
end

function Activity201MaLiAnNaGameController:gameIsOver()
	local isOver, isWin, isLose = Activity201MaLiAnNaGameModel.instance:gameIsOver()

	if isOver then
		self._isOver = true

		if isWin then
			self:_checkGameOverAndWin()
		else
			local loseType = Activity201MaLiAnNaEnum.FailResultType.timeOut
			local isLoseByTarget, loseData = Activity201MaLiAnNaGameModel.instance:isLoseByTarget()

			if isLoseByTarget and loseData then
				local condition = loseData[1]

				if condition == Activity201MaLiAnNaEnum.ConditionType.occupySlot then
					loseType = Activity201MaLiAnNaEnum.FailResultType.mySlotDead
				end

				if condition == Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead then
					loseType = Activity201MaLiAnNaEnum.FailResultType.myHeroDead
				end
			end

			MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.fail, loseType)
			ViewMgr.instance:openView(ViewName.MaLiAnNaResultView, {
				isWin = isWin
			})
		end
	else
		self:setPause(false)
	end
end

function Activity201MaLiAnNaGameController:_guideFinish()
	self:setPause(false)
end

function Activity201MaLiAnNaGameController:exitGame()
	self.unregisterCallback(self, Activity201MaLiAnNaEvent.SoliderDead, self._checkSoliderDead, self)
	self.unregisterCallback(self, Activity201MaLiAnNaEvent.SlotChangeCamp, self._checkSlotChangeCamp, self)
	self.unregisterCallback(self, Activity201MaLiAnNaEvent.OnSelectActiveSkill, self._checkUseSkillId, self)
	self.unregisterCallback(self, Activity201MaLiAnNaEvent.GamePause, self._setGamePause, self)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, self._guideFinish, self)
	ViewMgr.instance:closeView(ViewName.TipDialogView)
	self:setPause(true)
	UpdateBeat:Remove(self._update, self)
	Activity201MaLiAnNaGameModel.instance:destroy()
end

function Activity201MaLiAnNaGameController:_checkSoliderDead(soliderId)
	self:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead)
end

function Activity201MaLiAnNaGameController:_checkSlotChangeCamp(configId, camp)
	if configId ~= nil then
		local config = Activity201MaLiAnNaConfig.instance:getSlotConfigById(configId)
		local str = ""

		if camp == Activity201MaLiAnNaEnum.CampType.Player then
			str = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("maliannagame_tip_player"), config.name)
		end

		if camp == Activity201MaLiAnNaEnum.CampType.Enemy then
			str = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("maliannagame_tip_enemy"), config.name)
		end

		if not string.nilorempty(str) then
			self:dispatchEvent(Activity201MaLiAnNaEvent.ShowBattleEvent, camp, str, true)

			if camp == Activity201MaLiAnNaEnum.CampType.Player then
				if not AudioEnum3_0.MaLiAnNa.play_ui_lushang_our_occupy then
					local audioId = AudioEnum3_0.MaLiAnNa.play_ui_lushang_enemy_occupy

					AudioMgr.instance:trigger(audioId)
				end
			end
		end
	end

	self:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.occupySlot)
end

function Activity201MaLiAnNaGameController:_checkGameStart()
	self:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.gameStart)
end

function Activity201MaLiAnNaGameController:_checkGameOverAndWin()
	self:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin)
end

function Activity201MaLiAnNaGameController:_checkUseSkillId(skillData)
	local skillId

	self:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.useSkill, {
		skillId = (skillData ~= nil or nil) and skillData:getConfigId()
	})
end

function Activity201MaLiAnNaGameController:checkLevelDialog(conditionType, params)
	if self._lastConditionType == nil then
		self:_checkLevelDialog(conditionType, params)
	else
		table.insert(self._checkDialogList, {
			conditionType = conditionType,
			params = params
		})
	end
end

function Activity201MaLiAnNaGameController:_checkNextDialog()
	if self._lastConditionType == nil and self._checkDialogList ~= nil then
		local data = table.remove(self._checkDialogList, 1)

		if data then
			self:_checkLevelDialog(data.conditionType, data.params)
		end
	end
end

function Activity201MaLiAnNaGameController:_checkLevelDialog(conditionType, params)
	if self._isOver and conditionType ~= Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin then
		self:_checkNextDialog()

		return
	end

	local dialogId, seqId
	local isAuto = false

	self._lastConditionType = conditionType

	if self._dialogData ~= nil then
		for _, dialog in pairs(self._dialogData) do
			local triggerList = Activity201MaLiAnNaConfig.instance:getTriggerList(dialog.trigger)
			local isFinish, conditionType = Activity201MaLiAnNaGameModel.instance:checkCondition(triggerList, params)

			if isFinish and conditionType == self._lastConditionType and not self:isTrigger(self.episodeId, dialog.dialogSeq) then
				dialogId = dialog.dialogId
				seqId = dialog.dialogSeq
			end
		end
	end

	if dialogId ~= nil then
		self:setPause(true)
		self:setTrigger(self.episodeId, seqId, true)
		TipDialogController.instance:openTipDialogView(dialogId, self._levelDialogClose, self, isAuto, isAuto and EliminateConfig.instance:getConstValue(35) / 1000 or nil, isAuto and EliminateConfig.instance:getConstValue(34) / 100 or nil)
	else
		self:_levelDialogClose()
	end
end

function Activity201MaLiAnNaGameController:isTrigger(episodeId, dialogSeqId)
	if self._dialogDataCache == nil or self._dialogDataCache[episodeId] == nil then
		return false
	end

	return self._dialogDataCache[episodeId][dialogSeqId]
end

function Activity201MaLiAnNaGameController:setTrigger(episodeId, dialogSeqId, isTrigger)
	if self._dialogDataCache == nil then
		self._dialogDataCache = {}
	end

	if self._dialogDataCache[episodeId] == nil then
		self._dialogDataCache[episodeId] = {}
	end

	self._dialogDataCache[episodeId][dialogSeqId] = isTrigger
end

function Activity201MaLiAnNaGameController:_levelDialogClose()
	if self._lastConditionType and self._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.occupySlot then
		self:gameIsOver()
	end

	if self._lastConditionType and self._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead then
		self:gameIsOver()
	end

	if self._lastConditionType and self._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin then
		self:setPause(true)
		Activity201MaLiAnNaController.instance:_onGameFinished(VersionActivity3_0Enum.ActivityId.MaLiAnNa, self.episodeId)
		MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.success)
	end

	if self._lastConditionType and self._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.gameStart then
		self:setPause(false)
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.GameStart, self.episodeId)
	end

	self._lastConditionType = nil

	self:_checkNextDialog()
end

function Activity201MaLiAnNaGameController:finishGame()
	self:setPause(true)
	self:_checkGameOverAndWin()
end

Activity201MaLiAnNaGameController.instance = Activity201MaLiAnNaGameController.New()

return Activity201MaLiAnNaGameController
