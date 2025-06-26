-- chunkname: @IQIGame\\Net\\NetMallResponse.lua

function net_mall.buyResult(code, mallCid, num, getItems)
	MallModule.OnBuyGoodsResult(mallCid, num, getItems)
end

function net_mall.buyResult_delegate(code, mallCid, num, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 21016 then
			NoticeModule.ShowNotice(21040020)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_mall.buyResult(code, mallCid, num, getItems)
end

function net_mall.notifyMallRefresh(mallBuyCountRecords)
	MallModule.OnNotifyMallRefresh(mallBuyCountRecords)
end

function net_mall.notifyMallStartSellTime(mallStartSellTime)
	MallModule.NotifyMallStartSellTime(mallStartSellTime)
end
