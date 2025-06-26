-- chunkname: @IQIGame\\Module\\RefundsGiftPack\\RefundsGiftPackModule.lua

local m = {
	isChange = false
}
local RefundsGiftRewardData = require("IQIGame.Module.RefundsGiftPack.RefundsGiftRewardData")

function m.Reload()
	m.AddListener()

	m.timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.RefundsGiftPack, function()
		m.TimerUpdate()
	end, 1, -1)

	m.timer:Start()
end

function m.AddListener()
	return
end

function m.RemoveListener()
	return
end

function m.TimerUpdate()
	local temp = m.CheckRebatePackageRedPoint()

	if m.isChange ~= temp then
		m.isChange = temp

		EventDispatcher.Dispatch(EventID.UpdateRefundsGiftPackEvent)
	end
end

function m.GetNextRewardIndex(cid)
	local nextIndex = 1
	local cfg = CfgRefundsGiftPackTable[cid]
	local getCount = m.GetRewardCount(cid)

	nextIndex = getCount + 1

	if nextIndex > #cfg.RefundsGiftPackRewards then
		nextIndex = -1
	end

	return nextIndex
end

function m.GetRewardCount(cid)
	local count = 0

	if PlayerModule.PlayerInfo.refundsGiftPackRewards then
		count = PlayerModule.PlayerInfo.refundsGiftPackRewards[cid]

		if count == nil then
			count = 0
		end
	end

	return count
end

function m.GetShowRewards(cid)
	local dataTab = {}

	if PlayerModule.PlayerInfo.refundsGiftPacks and PlayerModule.PlayerInfo.refundsGiftPacks[cid] then
		local cfgRefundsGiftPackData = CfgRefundsGiftPackTable[cid]
		local tab = {}
		local nextIndex = m.GetNextRewardIndex(cid)

		if nextIndex ~= -1 then
			local rewardID = cfgRefundsGiftPackData.RefundsGiftPackRewards[nextIndex]
			local cfgRefundsGiftPackRewardsData = CfgRefundsGiftPackRewardsTable[rewardID]

			if cfgRefundsGiftPackRewardsData.payPoint > 0 then
				if tab[Constant.ItemID.ID_PAYPOINT_SHOW] == nil then
					tab[Constant.ItemID.ID_PAYPOINT_SHOW] = 0
				end

				tab[Constant.ItemID.ID_PAYPOINT_SHOW] = tab[Constant.ItemID.ID_PAYPOINT_SHOW] + cfgRefundsGiftPackRewardsData.payPoint
			end

			for j = 1, #cfgRefundsGiftPackRewardsData.Rewards, 2 do
				local id = cfgRefundsGiftPackRewardsData.Rewards[j]
				local num = cfgRefundsGiftPackRewardsData.Rewards[j + 1]

				if tab[id] == nil then
					tab[id] = 0
				end

				tab[id] = tab[id] + num
			end
		end

		for i, v in pairs(tab) do
			local data = RefundsGiftRewardData.New(i, v)

			table.insert(dataTab, data)
		end
	end

	return dataTab
end

function m.IsOpenRebatePackage()
	if PlayerModule.PlayerInfo.refundsGiftPacks then
		for i, v in pairs(PlayerModule.PlayerInfo.refundsGiftPacks) do
			if i then
				return true
			end
		end
	end

	return false
end

function m.CanGetReward()
	local tab = {}

	if PlayerModule.PlayerInfo.refundsGiftPacks then
		for i, v in pairs(PlayerModule.PlayerInfo.refundsGiftPacks) do
			local nextIndex = m.GetNextRewardIndex(i)
			local cfgRefundsGiftPackData = CfgRefundsGiftPackTable[i]
			local cfgTime = cfgRefundsGiftPackData.Time[nextIndex]
			local nowTime = PlayerModule.GetServerTime()
			local buyTime = v
			local cd = cfgTime - (nowTime - buyTime)

			if cd <= 0 then
				table.insert(tab, i)
			end
		end
	end

	return tab
end

function m.CheckRebatePackageRedPoint()
	local tab = m.CanGetReward()

	return #tab > 0
end

function m.Shutdown()
	m.RemoveListener()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.RefundsGiftPack)
end

function m.GetRefundsGiftPacks()
	local tab = m.CanGetReward()

	if #tab == 0 then
		NoticeModule.ShowNotice(21045065)

		return
	end

	net_active.getRefundsGiftPacks(tab)
end

function m.GetRefundsGiftPacksResult(showItems)
	if #showItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, showItems)
	end
end

function m.NotifyRefundsGiftPacksUpdate(refundsGiftPacks, refundsGiftPackRewards)
	PlayerModule.PlayerInfo.refundsGiftPacks = refundsGiftPacks
	PlayerModule.PlayerInfo.refundsGiftPackRewards = refundsGiftPackRewards

	EventDispatcher.Dispatch(EventID.UpdateRefundsGiftPackEvent)
end

RefundsGiftPackModule = m
