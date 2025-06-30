-- chunkname: @IQIGame\\Net\\NetWorldNoticeResponse.lua

function net_worldnotice.broadcastShopBuy(noticeId, pName, goodsCid)
	NoticeModule.ShowNoticeNoCallback(noticeId, pName, CfgGoodsTable[goodsCid].Name)
end
