-- chunkname: @IQIGame\\Module\\CelebrationGift\\CelebrationGiftModule.lua

local m = {}

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.CanBuyCelebrationGift(cid)
	local cfgData = CfgGiftBoxTable[cid]
	local baseCount = MallModule.GetResidueBuyTimes(cfgData.GiftBoxMall[1])
	local superCount = MallModule.GetResidueBuyTimes(cfgData.GiftBoxMall[2])
	local temp = baseCount <= 0 or superCount <= 0
	local haveShow = m.ShowCelebrationGift(cid)

	return not temp and haveShow
end

function m.ShowCelebrationGift(cid)
	local cfgData = CfgGiftBoxTable[cid]
	local totalMall = #cfgData.GiftBoxMall
	local doNotShow = 0

	for i, v in pairs(cfgData.GiftBoxMall) do
		local cfgMallData = CfgMallTable[v]

		if cfgMallData.ShowConditionId ~= 0 and not ConditionModule.Check(cfgMallData.ShowConditionId) then
			doNotShow = doNotShow + 1
		end
	end

	local haveShow = doNotShow < totalMall

	return haveShow
end

function m.GetOpenGiftBox()
	local ids = {}

	for i, v in pairsCfg(CfgGiftBoxTable) do
		local temp = m.CanBuyCelebrationGift(v.Id)
		local start = PlayerModule.PlayerInfo.mallStartSellTime[v.GiftBoxMall[1]]
		local isOverdue = true

		if start then
			local now = PlayerModule.GetServerTime()
			local cd = start + CfgMallTable[v.GiftBoxMall[1]].SalesTime - now

			if cd > 0 then
				isOverdue = false
			end
		end

		if temp and not isOverdue then
			table.insert(ids, v.Id)
		end
	end

	table.sort(ids, function(a, b)
		return a < b
	end)

	return ids
end

function m.IsOpen()
	return #m.GetOpenGiftBox() > 0
end

function m.Shutdown()
	m.RemoveListeners()
end

CelebrationGiftModule = m
