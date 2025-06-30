-- chunkname: @IQIGame\\Net\\NetCenterEventTurnTableResponse.lua

function net_centerEventTurnTable.getTurntableLogInfoResult(code, recordList)
	ActivityTurnModule.getTurntableLogInfoResult(recordList)
end

function net_centerEventTurnTable.reciveRewardInfoResult(code)
	ActivityTurnModule.ReceiveRewardInfoResult()
end
