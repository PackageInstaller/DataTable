-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/EliminateLevelController.lua

module("modules.logic.versionactivity2_2.eliminate.controller.EliminateLevelController", package.seeall)

local EliminateLevelController = class("EliminateLevelController", BaseController)

function EliminateLevelController:onInit()
	self._canClickCharacter = true
end

function EliminateLevelController:reInit()
	return
end

function EliminateLevelController:onInitFinish()
	return
end

function EliminateLevelController:enterLevel(levelId, warChessCharacterId, pieceIds)
	levelId = levelId or 222101
	warChessCharacterId = warChessCharacterId or 222002
	pieceIds = pieceIds or {
		222001,
		222002,
		222003,
		222004,
		22101,
		22102
	}

	EliminateLevelModel.instance:initLevel(levelId, warChessCharacterId, pieceIds)
	EliminateRpc.instance:sendStartMatch3WarChessInfoRequest(levelId, warChessCharacterId, pieceIds, self.openEliminateView, self)
end

function EliminateLevelController:closeLevel()
	EliminateLevelController.instance:clear()
	ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelResultView)
	ViewMgr.instance:closeView(ViewName.EliminateEffectView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelView)
	self:_gc()
end

function EliminateLevelController:_gc()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
end

function EliminateLevelController:openEliminateResultView(param, isImmediate)
	local resultData = EliminateTeamChessModel.instance:getWarFightResult()

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(false)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(false)

	if resultData and resultData:haveReward() then
		ViewMgr.instance:openView(ViewName.EliminateLevelRewardView, param, isImmediate)
	else
		ViewMgr.instance:openView(ViewName.EliminateLevelResultView, param, isImmediate)
	end
end

function EliminateLevelController:openEliminateView(param, isImmediate)
	if EliminateTeamChessModel.instance:getCurTeamChessWar() == nil then
		return
	end

	self._dialogData = EliminateConfig.instance:getEliminateDialogConfig(EliminateLevelModel.instance:getLevelId())

	self:clearTrigger()
	self.registerCallback(self, EliminateChessEvent.Match3RoundBegin, self.checkLevelDialogMatchRound, self)
	self.registerCallback(self, EliminateChessEvent.TeamChessRoundBegin, self.checkLevelDialogTeamChessRound, self)
	self.registerCallback(self, EliminateChessEvent.TeamChessEnemyPlaceBefore, self.checkLevelDialogTeamChessEnemyPlaceBefore, self)
	self.registerCallback(self, EliminateChessEvent.SettleAndToHaveDamage, self.checkLevelSettleAndHaveDamage, self)
	ViewMgr.instance:openView(ViewName.EliminateLevelView, param, isImmediate)
	ViewMgr.instance:openView(ViewName.EliminateEffectView)
end

function EliminateLevelController:changeRoundType(roundType)
	local curRoundType = EliminateLevelModel.instance:getCurRoundType()

	if roundType and curRoundType and roundType == curRoundType then
		self:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, false)

		return
	end

	if roundType == EliminateEnum.RoundType.Match3Chess then
		EliminateLevelModel.instance:setNeedChangeTeamToEliminate(false)
	else
		local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()

		if roundStepState ~= EliminateTeamChessEnum.TeamChessRoundType.enemy then
			EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)
		end
	end

	EliminateLevelModel.instance:setCurRoundType(roundType)
	self:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, true)
end

function EliminateLevelController:checkState()
	local roundStepState = EliminateTeamChessModel.instance:getCurTeamRoundStepState()
	local roundNumber = EliminateLevelModel.instance:getRoundNumber()
	local needChangeRound = false
	local needChangeTeamToEliminate = false

	if roundStepState and roundStepState ~= EliminateTeamChessEnum.TeamChessRoundType.settlement then
		if roundStepState == EliminateTeamChessEnum.TeamChessRoundType.enemy then
			EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)

			if roundNumber == 1 then
				needChangeRound = true
			end
		end
	else
		needChangeTeamToEliminate = EliminateLevelModel.instance:getNeedChangeTeamToEliminate()
		needChangeRound = needChangeTeamToEliminate
	end

	if needChangeRound then
		if needChangeTeamToEliminate then
			EliminateChessController.instance:sendGetMatch3WarChessInfoRequest(EliminateEnum.GetInfoType.OnlyMovePint, function()
				self:changeRoundType(EliminateEnum.RoundType.Match3Chess)
			end)
		else
			self:changeRoundType(EliminateEnum.RoundType.Match3Chess)
		end
	end
end

function EliminateLevelController:changeRoundToTeamChess()
	WarChessRpc.instance:sendWarChessMyRoundStartRequest(self.changeRoundToTeamChessBegin, self)
end

function EliminateLevelController:changeRoundToTeamChessBegin()
	self:changeRoundType(EliminateEnum.RoundType.TeamChess)
end

function EliminateLevelController:cancelSkillRelease()
	if self._selectSkillMo ~= nil then
		self._selectSkillMo:cancelRelease()
	end

	self._selectSkillMo = nil
	self._releaseSkillCb = nil
	self._releaseSkillCbTarget = nil
end

function EliminateLevelController:canRelease()
	if self._selectSkillMo ~= nil then
		return self._selectSkillMo:canRelease()
	end

	return false
end

function EliminateLevelController:canReleaseByRound(skillMo)
	skillMo = skillMo or self._selectSkillMo

	if skillMo == nil then
		return false
	end

	local curRound = EliminateLevelModel.instance:getCurRoundType()
	local effectRound = skillMo:getEffectRound()

	return curRound == effectRound
end

function EliminateLevelController:setSkillDataParams(...)
	if self._selectSkillMo ~= nil then
		self._selectSkillMo:setSkillParam(...)
	end
end

function EliminateLevelController:setCurSelectSkill(skillId, effect)
	if self._selectSkillMo == nil then
		local effectName = string.split(effect, "#")[1]

		self._selectSkillMo = CharacterSkillMoUtil.createMO(effectName)

		self._selectSkillMo:init(skillId)
	end

	return self._selectSkillMo
end

function EliminateLevelController:getTempSkillMo(skillId, effect)
	if self._tempSkillMo == nil then
		local effectName = string.split(effect, "#")[1]

		self._tempSkillMo = CharacterSkillMoUtil.createMO(effectName)

		self._tempSkillMo:init(skillId)
	end

	return self._tempSkillMo
end

function EliminateLevelController:getCurSelectSkill()
	return self._selectSkillMo
end

function EliminateLevelController:releaseSkill(cb, cbTarget)
	if self._selectSkillMo ~= nil then
		self._selectSkillMo:playAction(self._releaseSkill, self)

		self._releaseSkillCb = cb
		self._releaseSkillCbTarget = cbTarget
	end
end

function EliminateLevelController:_releaseSkill()
	if self._selectSkillMo == nil then
		return
	end

	if self._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PerformBegin)
		EliminateChessController.instance:setFlowEndState(false)
	end

	EliminateLevelModel.instance:addMainUseSkillNum()
	WarChessRpc.instance:sendWarChessCharacterSkillRequest(self._selectSkillMo._skillId, self._selectSkillMo:getReleaseParam(), EliminateEnum.RoundType.Match3Chess, self.onReceiveWarChessCharacterSkillSuccess, self)
end

function EliminateLevelController:onReceiveWarChessCharacterSkillSuccess()
	local needSetFlowEnd = self._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess

	if self._releaseSkillCbTarget and self._releaseSkillCb then
		self._releaseSkillCb(self._releaseSkillCbTarget)
	end

	self:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillSuccess)

	if needSetFlowEnd then
		EliminateChessController.instance:setFlowEndState(true)
	end
end

function EliminateLevelController:getCurLevelNeedPreloadRes()
	local preloadRes = {}
	local pieceIds = EliminateLevelModel.instance:getCurLevelPieceIds()

	if pieceIds then
		for i = 1, #pieceIds do
			local pieceId = pieceIds[i]
			local pieceRes = EliminateConfig.instance:getSoldierChessModelPath(pieceId)

			if pieceRes then
				table.insert(preloadRes, pieceRes)
			end
		end
	end

	for _, path in pairs(EliminateTeamChessEnum.VxEffectTypeToPath) do
		table.insert(preloadRes, path)
	end

	return preloadRes
end

function EliminateLevelController:checkLevelDialogMatchRound(data)
	self:_checkLevelDialog(EliminateEnum.ConditionType.MatchRoundBegin, data)
end

function EliminateLevelController:checkLevelDialogTeamChessRound(data)
	self:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessRoundBegin, data)
end

function EliminateLevelController:checkLevelDialogTeamChessEnemyPlaceBefore(data)
	self:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore, data)
end

function EliminateLevelController:checkLevelSettleAndHaveDamage(data)
	self:_checkLevelDialog(EliminateEnum.ConditionType.SettleAndToHaveDamage, data)
end

function EliminateLevelController:clickMainCharacter()
	if not self._canClickCharacter then
		return
	end

	self:_checkLevelDialog(EliminateEnum.ConditionType.ClickMainCharacter)
end

function EliminateLevelController:_checkLevelDialog(conditionType, params)
	local dialogId
	local isAuto = false
	local trigger = ""

	self._lastConditionType = conditionType

	local param = ""

	if conditionType == EliminateEnum.ConditionType.MatchRoundBegin or conditionType == EliminateEnum.ConditionType.TeamChessRoundBegin then
		local dataList = string.split(params, "_")

		param = #dataList >= 2 and dataList[2] or nil
	else
		param = params
	end

	if self._dialogData ~= nil and tabletool.len(self._dialogData) > 0 then
		local mainCharacterId = EliminateLevelModel.instance:getWarChessCharacterId()

		for _, data in ipairs(self._dialogData) do
			trigger = data.trigger

			local condList = string.split(data.trigger, "#")
			local condType = condList[1]

			if conditionType == condType then
				local needMainCharacterId, roundParam

				if conditionType == EliminateEnum.ConditionType.MatchRoundBegin or conditionType == EliminateEnum.ConditionType.TeamChessRoundBegin or conditionType == EliminateEnum.ConditionType.SettleAndToHaveDamage then
					needMainCharacterId = tonumber(condList[3])
					roundParam = condList[2]
				else
					needMainCharacterId = tonumber(condList[2])
				end

				if needMainCharacterId == -1 and roundParam == nil or needMainCharacterId == mainCharacterId and roundParam == param then
					local dialogIds = data.dialogId
					local dialogCount = #dialogIds

					isAuto = data.auto == 1
					dialogId = dialogIds[dialogCount]

					if dialogCount > 1 then
						dialogId = dialogIds[math.random(1, dialogCount)]
					end

					break
				end
			end
		end
	end

	if dialogId ~= nil and conditionType ~= EliminateEnum.ConditionType.ClickMainCharacter and self:isTrigger(trigger) then
		dialogId = nil
	end

	if dialogId ~= nil then
		TipDialogController.instance:openTipDialogView(dialogId, self._levelDialogClose, self, isAuto, isAuto and EliminateConfig.instance:getConstValue(35) / 1000 or nil, isAuto and EliminateConfig.instance:getConstValue(34) / 100 or nil)
		self:setTrigger(trigger)
	else
		self:_levelDialogClose()
	end
end

function EliminateLevelController:setTrigger(conditionType)
	if self.trigger == nil then
		self.trigger = {}
	end

	self.trigger[conditionType] = conditionType
end

function EliminateLevelController:clearTrigger()
	self.trigger = nil
end

function EliminateLevelController:isTrigger(conditionType)
	return self.trigger ~= nil and self.trigger[conditionType] ~= nil
end

function EliminateLevelController:_levelDialogClose()
	if self._lastConditionType and self._lastConditionType == EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore then
		self:dispatchEvent(EliminateChessEvent.LevelDialogClosed)
	end

	if self._lastConditionType and self._lastConditionType == EliminateEnum.ConditionType.ClickMainCharacter then
		self._canClickCharacter = true
	end
end

function EliminateLevelController.queryBgm()
	local episodeId = EliminateTeamSelectionModel.instance:getSelectedEpisodeId()

	if episodeId == nil then
		episodeId = EliminateLevelModel.instance:getLevelId()
	end

	local episodeConfig = EliminateConfig.instance:getEliminateEpisodeConfig(episodeId)

	if episodeConfig then
		local levelType = episodeConfig.levelPosition

		if levelType == EliminateLevelEnum.levelType.normal then
			return AudioBgmEnum.Layer.NormalBattleV2_2
		else
			return AudioBgmEnum.Layer.BossBattleV2_2
		end
	else
		return AudioBgmEnum.Layer.NormalBattleV2_2
	end
end

function EliminateLevelController:BgSwitch(audioStep)
	if self.switchGroupId == nil then
		self.switchGroupId = AudioMgr.instance:getIdFromString("Checkpointstate")
		self.fightNormal = AudioMgr.instance:getIdFromString("Fightnormal")
		self.victory = AudioMgr.instance:getIdFromString("Victory")
		self.comeShow = AudioMgr.instance:getIdFromString("Comeshow")
	end

	if audioStep == EliminateEnum.AudioFightStep.ComeShow then
		AudioMgr.instance:setSwitch(self.switchGroupId, self.comeShow)
	end

	if audioStep == EliminateEnum.AudioFightStep.FightNormal then
		AudioMgr.instance:setSwitch(self.switchGroupId, self.fightNormal)
	end

	if audioStep == EliminateEnum.AudioFightStep.Victory then
		AudioMgr.instance:setSwitch(self.switchGroupId, self.victory)
	end
end

function EliminateLevelController:checkMainSkill()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
		local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)
		local skillCostPower = skillConfig.cost

		if skillCostPower <= myInfo.power then
			local levelId = EliminateLevelModel.instance:getLevelId()

			self:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", levelId, myInfo.id))
		end
	end
end

function EliminateLevelController:checkPlayerSoliderCount()
	local strongholds = EliminateTeamChessModel.instance:getStrongholds()
	local playerSoliderCount = 0

	for _, stronghold in pairs(strongholds) do
		playerSoliderCount = playerSoliderCount + stronghold:getPlayerSoliderCount()
	end

	if playerSoliderCount > 0 then
		local levelId = EliminateLevelModel.instance:getLevelId()

		self:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", levelId, playerSoliderCount))
	end
end

function EliminateLevelController:updatePlayerExtraWinCondition(extraWinCondition)
	local curTeamChessWar = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local serverTeamChessWar = EliminateTeamChessModel.instance:getServerTeamChessWar()

	serverTeamChessWar:updateCondition(serverTeamChessWar.winCondition, extraWinCondition)

	local isChange = curTeamChessWar:updateCondition(curTeamChessWar.winCondition, extraWinCondition)

	if isChange then
		self:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end
end

function EliminateLevelController:clear()
	self.unregisterCallback(self, EliminateChessEvent.Match3RoundBegin, self.checkLevelDialogMatchRound, self)
	self.unregisterCallback(self, EliminateChessEvent.TeamChessRoundBegin, self.checkLevelDialogTeamChessRound, self)
	self.unregisterCallback(self, EliminateChessEvent.TeamChessEnemyPlaceBefore, self.checkLevelDialogTeamChessEnemyPlaceBefore, self)
	self.unregisterCallback(self, EliminateChessEvent.SettleAndToHaveDamage, self.checkLevelSettleAndHaveDamage, self)
	EliminateTeamChessController.instance:clear()
	EliminateChessController.instance:clear()
	self:cancelSkillRelease()

	self._tempSkillMo = nil

	EliminateLevelModel.instance:clear()
	TeamChessEffectPool.dispose()
end

EliminateLevelController.instance = EliminateLevelController.New()

return EliminateLevelController
