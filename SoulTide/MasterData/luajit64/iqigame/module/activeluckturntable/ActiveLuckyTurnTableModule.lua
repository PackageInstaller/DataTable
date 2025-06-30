-- chunkname: @IQIGame\\Module\\ActiveLuckTurnTable\\ActiveLuckyTurnTableModule.lua

local m = {
	showLandingTip = true
}

function m.Reload()
	m.showLandingTip = true
	m.LUCKY_TURNTABLE_MONEY = CfgDiscreteDataTable[6520067].Data[1]
end

function m.GetCfgData()
	local tab = {}

	for i, v in pairsCfg(CfgLuckyTurntableTable) do
		table.insert(tab, v)
	end

	table.sort(tab, function(a, b)
		return a.Id < b.Id
	end)

	return tab
end

function m.CheckLuckyTurnTableRedPoint()
	local haveNum = WarehouseModule.GetItemNumByCfgID(ActiveLuckyTurnTableModule.LUCKY_TURNTABLE_MONEY)

	return haveNum > 0 and m.showLandingTip
end

function m.Shutdown()
	m.getHistoryCallBack = nil
	m.luckDrawCallBack = nil
end

function m.LuckDraw(type, callBack)
	m.luckDrawCallBack = callBack

	net_active.luckDraw(type)
end

function m.GetLuckDrawHistory(callBack)
	m.getHistoryCallBack = callBack

	net_active.getLuckDrawHistory()
end

function m.LuckDrawResult(showItems)
	if m.luckDrawCallBack then
		m.luckDrawCallBack(showItems)
	elseif #showItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, showItems)
	end

	m.luckDrawCallBack = nil
end

function m.GetLuckDrawHistoryResult(luckDrawHistorys)
	if m.getHistoryCallBack then
		m.getHistoryCallBack(luckDrawHistorys)
	end

	m.getHistoryCallBack = nil
end

ActiveLuckyTurnTableModule = m
