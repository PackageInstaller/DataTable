-- chunkname: @IQIGame\\Net\\NetOperationsLimitTurntableResponse.lua

function net_operationsLimitTurntable.drawResult(code, awardsId, list, pod)
	ActiveLimitedTurnModule.DrawResult(awardsId, list, pod)
end

function net_operationsLimitTurntable.getHistoryResult(code, history)
	ActiveLimitedTurnModule.GetHistoryResult(history)
end
