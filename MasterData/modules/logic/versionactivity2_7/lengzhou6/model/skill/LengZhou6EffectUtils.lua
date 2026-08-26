-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/LengZhou6EffectUtils.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.LengZhou6EffectUtils", package.seeall)

local LengZhou6EffectUtils = class("LengZhou6EffectUtils")

function LengZhou6EffectUtils:ctor()
	self._defineList = {
		[LengZhou6Enum.SkillEffect.DamageUpByIntensified] = LengZhou6EffectUtils._damageUpByIntensified,
		[LengZhou6Enum.SkillEffect.HealUpByIntensified] = LengZhou6EffectUtils._healUpByIntensified,
		[LengZhou6Enum.SkillEffect.EliminationDecreaseCd] = LengZhou6EffectUtils._eliminationDecreaseCd,
		[LengZhou6Enum.SkillEffect.AddBuffByIntensified] = LengZhou6EffectUtils._addBuffByIntensified,
		[LengZhou6Enum.SkillEffect.DamageUpByType] = LengZhou6EffectUtils._damageUpByType,
		[LengZhou6Enum.SkillEffect.SuccessiveElimination] = LengZhou6EffectUtils._successiveElimination,
		[LengZhou6Enum.SkillEffect.EliminationLevelUp] = LengZhou6EffectUtils._eliminationLevelUp,
		[LengZhou6Enum.SkillEffect.EliminationCross] = LengZhou6EffectUtils._eliminationCross,
		[LengZhou6Enum.SkillEffect.EliminationDoubleAttack] = LengZhou6EffectUtils._eliminationDoubleAttack,
		[LengZhou6Enum.SkillEffect.EliminationRange] = LengZhou6EffectUtils._eliminationRange,
		[LengZhou6Enum.SkillEffect.AddBuff] = LengZhou6EffectUtils._addBuff,
		[LengZhou6Enum.SkillEffect.DealsDamage] = LengZhou6EffectUtils._dealsDamage,
		[LengZhou6Enum.SkillEffect.Contaminate] = LengZhou6EffectUtils._contaminate,
		[LengZhou6Enum.SkillEffect.Shuffle] = LengZhou6EffectUtils._shuffle,
		[LengZhou6Enum.SkillEffect.FreezeEliminationBlock] = LengZhou6EffectUtils._freezeEliminationBlock,
		[LengZhou6Enum.SkillEffect.PetrifyEliminationBlock] = LengZhou6EffectUtils._petrifyEliminationBlock,
		[LengZhou6Enum.SkillEffect.Heal] = LengZhou6EffectUtils._heal
	}
end

function LengZhou6EffectUtils._damageUpByIntensified(param)
	local player = LengZhou6GameModel.instance:getPlayer()

	if player ~= nil then
		local damageComp = player:getDamageComp()

		damageComp:setEliminateTypeExDamage(param[2], tonumber(param[3]))
	end
end

function LengZhou6EffectUtils._healUpByIntensified(param)
	local player = LengZhou6GameModel.instance:getPlayer()

	if player ~= nil then
		local treatmentComp = player:getTreatmentComp()

		treatmentComp:setEliminateTypeExTreatment(param[2], tonumber(param[3]))
	end
end

function LengZhou6EffectUtils._eliminationDecreaseCd(param)
	local player = LengZhou6GameModel.instance:getPlayer()

	if player ~= nil then
		local count = LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(param[2]) or 0
		local allActiveSkills = player:getActiveSkills()
		local cdMaxSkill
		local maxCd = 0

		for i = 1, #allActiveSkills do
			local skill = allActiveSkills[i]
			local cd = skill:getCd()

			if maxCd < cd then
				cdMaxSkill = skill
				maxCd = cd
			end
		end

		if cdMaxSkill ~= nil then
			for i = 1, count do
				cdMaxSkill:setCd(cdMaxSkill:getCd() - tonumber(param[3]))
			end
		end
	end
end

function LengZhou6EffectUtils._addBuffByIntensified(param)
	local eliminateType = param[2]
	local count = LengZhou6GameModel.instance:getCurEliminateSpEliminateCount(eliminateType) or 0
	local buffConfigId = tonumber(param[3])
	local buffAddLayerCount = tonumber(param[4])
	local camp = tonumber(param[5])

	for i = 1, count do
		for j = 1, buffAddLayerCount do
			if camp == LengZhou6Enum.entityCamp.player then
				LengZhou6BuffSystem.instance:addBuffToPlayer(buffConfigId)
			end

			if camp == LengZhou6Enum.entityCamp.enemy then
				LengZhou6BuffSystem.instance:addBuffToEnemy(buffConfigId)
			end
		end
	end
end

function LengZhou6EffectUtils._damageUpByType(param)
	local player = LengZhou6GameModel.instance:getPlayer()

	if player ~= nil then
		local damageComp = player:getDamageComp()
		local damages = string.splitToNumber(param[3], ",")

		damageComp:setSpEliminateRate(damages[1], damages[2], damages[3])
	end
end

function LengZhou6EffectUtils._successiveElimination(param)
	local rate = tonumber(param[2]) / 1000

	LengZhou6GameModel.instance:setLineEliminateRate(rate)
end

function LengZhou6EffectUtils._eliminationLevelUp(param)
	local eliminateType = param[2]
	local changeCount = tonumber(param[3])
	local eliminateId = EliminateEnum_2_7.ChessTypeToIndex[eliminateType]
	local allPos = LocalEliminateChessModel.instance:getAllEliminateIdPos(eliminateId)
	local needChangeX = {}
	local needChangeY = {}

	if changeCount < #allPos then
		for i = 1, changeCount do
			local randomIndex = math.random(1, #allPos)

			table.insert(needChangeX, allPos[randomIndex].x)
			table.insert(needChangeY, allPos[randomIndex].y)
		end
	else
		for i = 1, #allPos do
			table.insert(needChangeX, allPos[i].x)
			table.insert(needChangeY, allPos[i].y)
		end
	end

	local changeStepFlow = FlowParallel.New()

	for i = 1, #needChangeX do
		local x = needChangeX[i]
		local y = needChangeY[i]

		LocalEliminateChessModel.instance:changeCellState(x, y, EliminateEnum.ChessState.SpecialSkill)

		local data = {
			x = x,
			y = y
		}
		local updateStateWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, data)

		changeStepFlow:addWork(updateStateWork)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(changeStepFlow)
end

function LengZhou6EffectUtils._eliminationCross(x, y)
	LocalEliminateChessModel.instance:eliminateCross(x, y)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function LengZhou6EffectUtils._eliminationDoubleAttack()
	LengZhou6GameModel.instance:setEnemySettleCount(2)
end

function LengZhou6EffectUtils._eliminationRange(x, y)
	LocalEliminateChessModel.instance:eliminateRange(x, y, 3)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function LengZhou6EffectUtils._addBuff(param)
	local buffConfigId = tonumber(param[2])
	local layout = tonumber(param[3])

	for i = 1, layout do
		LengZhou6BuffSystem.instance:addBuffToEnemy(buffConfigId)
	end
end

function LengZhou6EffectUtils._dealsDamage(param, exValue)
	local damage = tonumber(param[2]) + (exValue ~= nil and exValue or 0)
	local player = LengZhou6GameModel.instance:getPlayer()

	player:changeHp(-damage)
end

function LengZhou6EffectUtils._contaminate(param, exValue)
	local contaminateCount = tonumber(param[2]) + (exValue ~= nil and exValue or 0)
	local row, col = LocalEliminateChessModel.instance:getCellRowAndCol()
	local randomXYSet = LengZhou6EffectUtils.getRandomXYSet(row, col, contaminateCount, true, LengZhou6Enum.SkillEffect.Contaminate)

	for i = 1, #randomXYSet do
		local randomX = randomXYSet[i].x
		local randomY = randomXYSet[i].y

		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEffect, randomX, randomY, EliminateEnum_2_7.ChessEffect.pollution)
	end
end

function LengZhou6EffectUtils._shuffle()
	local randomList = LocalEliminateChessModel.instance:randomCell()

	LengZhou6EliminateController.instance:updateAllItemPos(randomList)
end

function LengZhou6EffectUtils._freezeEliminationBlock(param, exValue)
	local freezeCount = tonumber(param[2]) + (exValue ~= nil and exValue or 0)
	local row, col = LocalEliminateChessModel.instance:getCellRowAndCol()
	local changeStepFlow = FlowParallel.New()
	local randomXYSet = LengZhou6EffectUtils.getRandomXYSet(row, col, freezeCount, true, LengZhou6Enum.SkillEffect.FreezeEliminationBlock)

	for i = 1, #randomXYSet do
		local randomX = randomXYSet[i].x
		local randomY = randomXYSet[i].y

		LocalEliminateChessModel.instance:changeCellState(randomX, randomY, EliminateEnum.ChessState.Frost)

		local data = {
			x = randomX,
			y = randomY
		}
		local updateStateWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, data)

		changeStepFlow:addWork(updateStateWork)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(changeStepFlow)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function LengZhou6EffectUtils._petrifyEliminationBlock(param, exValue)
	local petrifyCount = tonumber(param[2]) + (exValue ~= nil and exValue or 0)
	local row, col = LocalEliminateChessModel.instance:getCellRowAndCol()
	local isInGuide, pos = LengZhou6Controller.instance:getFixChessPos()

	if isInGuide then
		petrifyCount = petrifyCount - 1
	end

	local randomXYSet = LengZhou6EffectUtils.getRandomXYSet(row, col, petrifyCount, true, LengZhou6Enum.SkillEffect.PetrifyEliminationBlock)

	if isInGuide and pos ~= nil then
		table.insert(randomXYSet, {
			x = pos.x,
			y = pos.y
		})
	end

	local updateInfoStepFlow = FlowParallel.New()

	for i = 1, #randomXYSet do
		local randomX = randomXYSet[i].x
		local randomY = randomXYSet[i].y
		local work = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChessItemUpdateInfo, {
			x = randomX,
			y = randomY
		})

		updateInfoStepFlow:addWork(work)
	end

	LengZhou6EliminateController.instance:buildSeqFlow(updateInfoStepFlow)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function LengZhou6EffectUtils._heal(param, exValue)
	local hp = tonumber(param[2]) + (exValue ~= nil and exValue or 0)
	local enemy = LengZhou6GameModel.instance:getEnemy()

	enemy:changeHp(hp)
end

function LengZhou6EffectUtils.getRandomXYSet(row, col, count, needExcludeEffect, effect)
	local randomXYSet = {}

	for j = 1, 100 do
		if #randomXYSet == count then
			break
		end

		local randomX = math.random(1, row)
		local randomY = math.random(1, col)
		local canAdd = true

		if needExcludeEffect then
			local cell = LocalEliminateChessModel.instance:getCell(randomX, randomY)
			local spEffect = LocalEliminateChessModel.instance:getSpEffect(randomX, randomY)

			if effect == LengZhou6Enum.SkillEffect.Contaminate and spEffect ~= nil then
				canAdd = false
			end

			if effect == LengZhou6Enum.SkillEffect.FreezeEliminationBlock and (spEffect ~= nil or cell.id == EliminateEnum.InvalidId or cell:getEliminateID() == EliminateEnum_2_7.ChessType.stone) then
				canAdd = false
			end

			if effect == LengZhou6Enum.SkillEffect.PetrifyEliminationBlock and (spEffect ~= nil and spEffect == EliminateEnum_2_7.ChessEffect.frost or cell.id == EliminateEnum.InvalidId) then
				canAdd = false
			end
		end

		if canAdd then
			for i = 1, #randomXYSet do
				local x = randomXYSet[i].x
				local y = randomXYSet[i].y

				if randomX == x and y == randomY then
					canAdd = false
				end
			end
		end

		if canAdd then
			table.insert(randomXYSet, {
				x = randomX,
				y = randomY
			})
		end
	end

	return randomXYSet
end

function LengZhou6EffectUtils:getHandleFunc(type)
	return self._defineList[type]
end

LengZhou6EffectUtils.instance = LengZhou6EffectUtils.New()

return LengZhou6EffectUtils
