-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/LengZhou6GameController.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6GameController", package.seeall)

local LengZhou6GameController = class("LengZhou6GameController", BaseController)

function LengZhou6GameController:onInit()
	return
end

function LengZhou6GameController:enterEpisodeId(episodeId)
	local activityId = 12702

	self:enterLevel(activityId, episodeId)
end

function LengZhou6GameController:enterLevel(activityId, episodeId)
	local config = LengZhou6Config.instance:getEpisodeConfig(activityId, episodeId)
	local eliminateLevelId = config.eliminateLevelId

	if eliminateLevelId ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(config)
		LengZhou6EliminateController.instance:enterLevel(eliminateLevelId)
		ViewMgr.instance:openView(ViewName.LengZhou6GameView)
	end
end

function LengZhou6GameController:restartLevel(activityId, episodeId)
	local config = LengZhou6Config.instance:getEpisodeConfig(activityId, episodeId)
	local eliminateLevelId = config.eliminateLevelId

	if eliminateLevelId ~= 0 then
		LengZhou6StatHelper.instance:enterGame()
		LengZhou6GameModel.instance:enterLevel(config)
		LengZhou6EliminateController.instance:enterLevel(eliminateLevelId)
		self:dispatchEvent(LengZhou6Event.GameReStart)
	end
end

function LengZhou6GameController:gameUpdateRound(isRound)
	self:_damageAndHpSettle(isRound)
end

function LengZhou6GameController:_damageAndHpSettle(isRound)
	local enemySettleCount = LengZhou6GameModel.instance:getEnemySettleCount()
	local totalPlayerDamage = 0
	local totalPlayerHp = 0

	for i = 1, enemySettleCount do
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackBefore)

		local playerDamage, playerHp = LengZhou6GameModel.instance:getTotalPlayerSettle()

		totalPlayerDamage = totalPlayerDamage + playerDamage
		totalPlayerHp = totalPlayerHp + playerHp

		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackAfter)
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.attackComplete)
	end

	LengZhou6GameModel.instance:resetEnemySettleCount()

	local data = {
		damage = totalPlayerDamage,
		hp = totalPlayerHp,
		isRound = isRound
	}
	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateDamage, data)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function LengZhou6GameController:_updateRoundAndCD(isRound)
	if isRound then
		LengZhou6GameModel.instance:changeRound(-1)

		local playerEntity = LengZhou6GameModel.instance:getPlayer()

		playerEntity:updateActiveSkillCD()
	end

	local isOver = LengZhou6GameModel.instance:gameIsOver()

	if isOver then
		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

		LengZhou6EliminateController.instance:buildSeqFlow(step)

		return
	end

	self:_enemySkillRelease(isRound)
end

function LengZhou6GameController:_enemySkillRelease(isRound)
	if isRound then
		local enemyEntity = LengZhou6GameModel.instance:getEnemy()
		local allSkill, residueCd = enemyEntity:getAllCanUseSkillId()

		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.enemyCheckInterval)
		self:dispatchEvent(LengZhou6Event.EnemySkillRound, residueCd)

		if allSkill == nil then
			LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)

			return
		end

		for i = 1, #allSkill do
			local skill = allSkill[i]
			local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyReleaseSkillStep, skill)

			LengZhou6EliminateController.instance:buildSeqFlow(step)
		end

		local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.LengZhou6EnemyGenerateSkillStep)

		LengZhou6EliminateController.instance:buildSeqFlow(step)
	end

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function LengZhou6GameController:playerSettle()
	LengZhou6GameModel.instance:playerSettle()
end

function LengZhou6GameController:gameEnd()
	local model = LengZhou6GameModel.instance:getBattleModel()
	local isWin = LengZhou6GameModel.instance:playerIsWin()

	if model == LengZhou6Enum.BattleModel.infinite and isWin then
		if LengZhou6GameModel.instance:canSelectSkill() then
			LengZhou6GameModel.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
			self:recordProgress()
		else
			LengZhou6GameModel.instance:enterNextLayer()
		end

		return
	end

	self:dispatchEvent(LengZhou6Event.GameEnd, isWin)
	ViewMgr.instance:openView(ViewName.LengZhou6GameResult)
end

function LengZhou6GameController:levelGame(closeGameView)
	self:recordProgress()

	if closeGameView then
		ViewMgr.instance:closeView(ViewName.LengZhou6GameView)
		LengZhou6EliminateController.instance:clear()
	end

	LengZhou6GameModel.instance:clear()
end

function LengZhou6GameController:recordProgress()
	local isWin = LengZhou6GameModel.instance:playerIsWin()
	local battleModel = LengZhou6GameModel.instance:getBattleModel()

	if battleModel == LengZhou6Enum.BattleModel.infinite or isWin then
		local progress

		if battleModel == LengZhou6Enum.BattleModel.infinite then
			local recordServerData = LengZhou6GameModel.instance:getRecordServerData()

			progress = recordServerData:getRecordData()

			local player = LengZhou6GameModel.instance:getPlayer()
			local round = LengZhou6GameModel.instance:getCurRound()

			if round <= 0 or player:getHp() <= 0 then
				progress = ""
			end
		end

		local episodeId = LengZhou6Model.instance:getCurEpisodeId()

		if not LengZhou6Enum.enterGM then
			LengZhou6Controller.instance:finishLevel(episodeId, progress)
		end
	end
end

LengZhou6GameController.instance = LengZhou6GameController.New()

return LengZhou6GameController
