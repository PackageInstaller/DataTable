-- chunkname: @IQIGame\\Net\\NetOperationsGachaPoolResponse.lua

function net_operationsGachaPool.drawResult(code, awardsId, list, pod)
	ActiveGachaModule.OnDrawResult(code, awardsId, list, pod)
end

function net_operationsGachaPool.refreshResult(code, pod)
	ActiveGachaModule.RefreshResult(pod)
end
