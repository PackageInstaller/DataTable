-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateStepUtil.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateStepUtil", package.seeall)

local EliminateStepUtil = class("EliminateStepUtil")

function EliminateStepUtil.createStep(stepType, data)
	local step

	if stepType == EliminateEnum.StepWorkType.Move then
		step = EliminateChessMoveStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.Die then
		step = EliminateChessDieStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.Debug then
		step = EliminateChessDebugStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.Arrange then
		step = EliminateChessArrangeStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.HandleData then
		step = EliminateChessHandleDataStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.StartShowView then
		step = EliminateChessShowStartStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.EndShowView then
		step = EliminateChessShowEndStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.ShowEvaluate then
		step = EliminateChessShowEvaluateStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.PlayEffect then
		step = EliminateChessPlayEffectStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.PlayAudio then
		step = EliminateChessPlayAudioStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.RefreshEliminate then
		step = EliminateChessRefreshStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.Arrange_XY then
		step = EliminateChessArrange_XYStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.DieEffect then
		step = EliminateChessDieEffectStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.ChangeState then
		step = EliminateChessChangeStateStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.CheckEliminate then
		step = EliminateChessCheckStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.EliminateChessDebug2_7 then
		step = EliminateChessDebug2_7Step.New()
	end

	if stepType == EliminateEnum.StepWorkType.EliminateChessRevert then
		step = EliminateChessRevertStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.EliminateChessUpdateDamage then
		step = EliminateChessUpdateDamageStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo then
		step = EliminateChessUpdateGameInfoStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.LengZhou6EnemyReleaseSkillStep then
		step = LengZhou6EnemyReleaseSkillStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.ChessItemUpdateInfo then
		step = EliminateChessItemUpdateInfoStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.LengZhou6EnemyGenerateSkillStep then
		step = LengZhou6EnemyGenerateSkillStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.EliminateCheckAndRefresh then
		step = EliminateCheckAndRefreshStep.New()
	end

	if stepType == EliminateEnum.StepWorkType.LengZhou6PlayAudio then
		step = EliminatePlayAudioStep.New()
	end

	if step then
		step:initData(data)
	else
		logError("EliminateChessController:getSetWork stepType error!")
	end

	return step
end

function EliminateStepUtil.createCommonStepTable(x, y, time)
	if EliminateStepUtil.stepPool == nil then
		EliminateStepUtil.stepPool = LuaObjPool.New(10, function()
			local data = {}

			data.x = x
			data.y = y
			data.time = time

			return data
		end, function(data)
			data = nil
		end, function(data)
			data.x = 0
			data.y = 0
			data.time = 0
		end)
	end

	return EliminateStepUtil.stepPool:getObject()
end

function EliminateStepUtil.putCommonStepTable(putObject)
	EliminateStepUtil.stepPool:putObject(putObject)
end

function EliminateStepUtil.releaseCommonStepTable()
	if EliminateStepUtil.stepPool then
		EliminateStepUtil.stepPool:dispose()

		EliminateStepUtil.stepPool = nil
	end
end

function EliminateStepUtil.createOrGetMoveStepTable(item, time, animType)
	if EliminateStepUtil.moveStepPool == nil then
		EliminateStepUtil.moveStepPool = LuaObjPool.New(10, function()
			local data = {}

			data.chessItem = item

			if time then
				data.time = time or EliminateEnum.AniTime.Move
			end

			data.animType = animType

			return data
		end, function(data)
			data.chessItem = nil
			data.time = nil
			data.animType = nil
			data = nil
		end, function(data)
			data.chessItem = nil
			data.time = nil
			data.animType = nil
		end)
	end

	local data = EliminateStepUtil.moveStepPool:getObject()

	data.chessItem = item
	data.time = time and time or EliminateEnum.AniTime.Move
	data.animType = animType

	return data
end

function EliminateStepUtil.putMoveStepTable(putObject)
	if EliminateStepUtil.moveStepPool ~= nil then
		EliminateStepUtil.moveStepPool:putObject(putObject)
	end
end

function EliminateStepUtil.releaseMoveStepTable()
	if EliminateStepUtil.moveStepPool ~= nil then
		EliminateStepUtil.moveStepPool:dispose()

		EliminateStepUtil.moveStepPool = nil
	end
end

return EliminateStepUtil
