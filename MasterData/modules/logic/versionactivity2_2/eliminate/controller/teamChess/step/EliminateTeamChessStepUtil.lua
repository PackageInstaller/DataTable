-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/step/EliminateTeamChessStepUtil.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepUtil", package.seeall)

local EliminateTeamChessStepUtil = class("EliminateTeamChessStepUtil")

function EliminateTeamChessStepUtil.createStep(effectData, _stepType)
	local stepType = _stepType

	if effectData then
		stepType = effectData.effectType
	end

	local step
	local data = EliminateTeamChessStepUtil.createStepData(stepType, effectData)

	if stepType == EliminateTeamChessEnum.StepWorkType.placeChess or stepType == EliminateTeamChessEnum.StepWorkType.callChess then
		step = TeamChessPlaceStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		step = TeamChessPowerChangeStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.resourceChange then
		step = ResourceDataChangeStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		step = StrongHoldPowerChangeStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		step = MainCharacterHpChangeStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessFightResult then
		step = TeamChessFightResultStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff then
		step = EliminateTeamChessSyncDataStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState then
		step = TeamChessCheckRoundStateStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.strongHoldSettleFinish then
		step = TeamChessPerformReductionStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessDie then
		step = TeamChessDieStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.removeChess then
		step = TeamChessRemoveStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		step = StrongHoldSettleStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		step = MainCharacterPowerChangeStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		step = EliminateTeamChessBeginStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		step = EliminateTeamChessUpdateActiveMoveStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		step = EliminateTeamChessShowBuffEffectStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		step = TeamChessGrowUpUpdateStep.New()
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast then
		step = TeamChessForecastUpdateStep.New()
	end

	step = step or EliminateTeamChessStepBase.New()

	step:initData(data)

	return step
end

function EliminateTeamChessStepUtil.createStepData(stepType, effectData)
	local stepData = {}

	if stepType == EliminateTeamChessEnum.StepWorkType.placeChess or stepType == EliminateTeamChessEnum.StepWorkType.callChess then
		stepData.strongholdId = effectData.effectNum
		stepData.chessPiece = effectData.chessPiece

		if not string.nilorempty(effectData.extraData) then
			stepData.sourceStrongholdId = tonumber(effectData.extraData)
		end
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		stepData.uid = effectData.targetId
		stepData.diffValue = effectData.effectNum
		stepData.needShowDamage = effectData.needShowDamage or false
		stepData.reasonId = effectData.reasonId
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.resourceChange then
		stepData.resourceIdMap = cjson.decode(effectData.extraData)
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.strongHoldPowerChange then
		stepData.strongholdId = tonumber(effectData.targetId)
		stepData.diffValue = effectData.effectNum
		stepData.teamType = tonumber(effectData.extraData)
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.mainCharacterHpChange then
		stepData.diffValue = effectData.effectNum
		stepData.teamType = tonumber(effectData.targetId)
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessDie then
		stepData.uid = effectData.targetId
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.removeChess then
		stepData.uid = effectData.targetId
		stepData.strongholdId = tonumber(effectData.effectNum)

		if not string.nilorempty(effectData.extraData) then
			stepData.targetStrongholdId = tonumber(effectData.extraData)
		end
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.strongHoldSettle then
		stepData.strongholdId = tonumber(effectData.targetId)
		stepData.state = tonumber(effectData.effectNum)
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.mainCharacterPowerChange then
		stepData.diffValue = tonumber(effectData.effectNum)
		stepData.teamType = tonumber(effectData.targetId)
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow then
		stepData.time = EliminateTeamChessEnum.beginViewShowTime
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessActiveMove then
		stepData.uid = effectData.targetId
		stepData.displacementState = effectData.chessPiece.displacementState
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect then
		stepData.uid = effectData.uid
		stepData.vxEffectType = effectData.vxEffectType
		stepData.time = effectData.time
	end

	if stepType == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
		stepData.uid = effectData.targetId
		stepData.upValue = effectData.effectNum
		stepData.skillId = tonumber(effectData.extraData)
	end

	return stepData
end

return EliminateTeamChessStepUtil
