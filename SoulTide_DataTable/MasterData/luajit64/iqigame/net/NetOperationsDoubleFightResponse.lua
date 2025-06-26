-- chunkname: @IQIGame\\Net\\NetOperationsDoubleFightResponse.lua

function net_operationsDoubleFight.fightResult(code)
	ActiveDoubleFightModule.FightResult(code)
end

function net_operationsDoubleFight.getRewardsResult(code, items, eventId, step, indexs)
	ActiveDoubleFightModule.GetRewardsResult(items, eventId, step, indexs)
end

function net_operationsDoubleFight.notifyFightComplete(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
	ActiveDoubleFightModule.NotifyFightComplete(eventId, win, dmgRecords, hurtScore, hurtPercentage, roundScore, round)
end

function net_operationsDoubleFight.notifyUpdateDoubleFightStepPOD(eventId, doubleFightStepPOD)
	ActiveDoubleFightModule.NotifyUpdateDoubleFightStepPOD(eventId, doubleFightStepPOD)
end
