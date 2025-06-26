-- chunkname: @IQIGame\\Net\\NetChurchResponse.lua

function net_item.exchangeResult(code, success, showItems, exchangeRecords, critMultiple)
	ChurchModule.ResponseExchangeMsg(success, showItems, exchangeRecords, critMultiple)
end

function net_item.exchangeBatchResult(code, successInfo, showItems, exchangeRecords)
	ChurchModule.OnSendBatchExchangeMsgResult(successInfo, showItems, exchangeRecords)
end
