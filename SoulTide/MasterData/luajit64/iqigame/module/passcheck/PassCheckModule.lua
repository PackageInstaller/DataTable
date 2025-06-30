-- chunkname: @IQIGame\\Module\\PassCheck\\PassCheckModule.lua

PassCheckModule = {
	state = 0,
	lastGetRewardCids = {},
	lastGotBaseRewardCids = {},
	rewardCid2IndexDic = {}
}

local bit = require("bit")

function PassCheckModule.ReloadPassPOD(dailyDupPOD)
	if not dailyDupPOD then
		return
	end

	PassCheckModule.UpdatePOD(dailyDupPOD)
end

function PassCheckModule.Shutdown()
	PassCheckModule.state = 0
end

function PassCheckModule.UpdatePOD(dailyDupPOD)
	PassCheckModule.id = dailyDupPOD.common.openCount
	PassCheckModule.state = dailyDupPOD.common.status
	PassCheckModule.openTime = dailyDupPOD.common.openDate
	PassCheckModule.advanced = dailyDupPOD.battlePassesPOD.advanced
	PassCheckModule.lv = dailyDupPOD.battlePassesPOD.bpLv
	PassCheckModule.exp = dailyDupPOD.battlePassesPOD.bpExp
	PassCheckModule.rewardsGetList = dailyDupPOD.battlePassesPOD.rewardsGetList
	PassCheckModule.lastSeasonLv = dailyDupPOD.battlePassesPOD.lastSeasonLv

	local cfgDailyDupData = CfgDailyDupTable[9]

	PassCheckModule.endTime = PassCheckModule.openTime + cfgDailyDupData.AccessibleTime
	PassCheckModule.maxLv = 0

	local cids = {}

	for i, v in pairsCfg(CfgBattlePassRewardTable) do
		if v.SeasonLv > PassCheckModule.maxLv then
			PassCheckModule.maxLv = v.SeasonLv
		end

		if v.BattlePassSeason == PassCheckModule.id then
			cids[#cids + 1] = i
		end
	end

	PassCheckModule.rewardCid2IndexDic = {}

	table.sort(cids, function(a, b)
		return a < b
	end)

	for i, v in ipairs(cids) do
		PassCheckModule.rewardCid2IndexDic[v] = i
	end
end

function PassCheckModule:GetNextCfgRewardData()
	if PassCheckModule.CheckReachMaxLv() then
		return nil
	end

	for i, v in pairsCfg(CfgBattlePassRewardTable) do
		if v.BattlePassSeason == PassCheckModule.id and v.SeasonLv == PassCheckModule.lv + 1 then
			return v
		end
	end
end

function PassCheckModule.GetAllRewardDatum(rewardType)
	return PassCheckModule.GetRewardDatum(rewardType, 1, PassCheckModule.maxLv)
end

function PassCheckModule.GetRewardDatum(rewardType, startLv, endLv)
	local itemCid2CountDic = {}
	local itemCid2SortDic = {}
	local cfgRewardDatum = PassCheckModule.GetSortCfgRewardDatum()
	local sort = 0

	for i, v in ipairs(cfgRewardDatum) do
		if startLv <= v.SeasonLv and endLv >= v.SeasonLv then
			local datum = {}

			if rewardType == 1 then
				datum[1] = {
					v.FreeReward[1],
					v.FreeReward[2]
				}
			elseif rewardType == 2 then
				datum[1] = {
					v.PayReward[1],
					v.PayReward[2]
				}
			else
				datum[1] = {
					v.FreeReward[1],
					v.FreeReward[2]
				}
				datum[2] = {
					v.PayReward[1],
					v.PayReward[2]
				}
			end

			for m, n in ipairs(datum) do
				local itemCid = n[1]
				local count = n[2]

				if itemCid2CountDic[itemCid] == nil then
					itemCid2CountDic[itemCid] = 0
					sort = sort + 1
					itemCid2SortDic[itemCid] = sort
				end

				itemCid2CountDic[itemCid] = itemCid2CountDic[itemCid] + count
			end
		end
	end

	local ret = {}

	for i, v in pairs(itemCid2CountDic) do
		ret[itemCid2SortDic[i]] = {
			i,
			v
		}
	end

	return ret
end

function PassCheckModule.GetSortCfgRewardDatum()
	local ret = {}

	for i, v in pairsCfg(CfgBattlePassRewardTable) do
		if v.BattlePassSeason == PassCheckModule.id then
			ret[#ret + 1] = v
		end
	end

	table.sort(ret, function(a, b)
		return a.SeasonLv < b.SeasonLv
	end)

	return ret
end

function PassCheckModule.CheckRewardIsGot(rewardCid, cid, isSuperReward)
	local checkIndex = PassCheckModule.rewardCid2IndexDic[rewardCid]

	if checkIndex <= #PassCheckModule.rewardsGetList then
		local state = PassCheckModule.rewardsGetList[checkIndex]

		if state ~= 0 then
			if isSuperReward then
				if getBinBitValue(state, 2) == 1 then
					return true
				end
			elseif getBinBitValue(state, 1) == 1 then
				return true
			end
		end
	end

	return false
end

function PassCheckModule.CheckGotSuperPass()
	return PassCheckModule.advanced
end

function PassCheckModule.CheckReachMaxLv()
	return PassCheckModule.lv >= PassCheckModule.maxLv
end

function PassCheckModule.CheckBaseRewardCanGet(rewardCid, itemCid, SeasonLv)
	local gotBase = PassCheckModule.CheckRewardIsGot(rewardCid, itemCid, false)
	local reachedLv = SeasonLv <= PassCheckModule.lv

	return not gotBase and reachedLv
end

function PassCheckModule.CheckSuperRewardCanGet(rewardCid, itemCid, SeasonLv)
	local gotSuper = PassCheckModule.CheckRewardIsGot(rewardCid, itemCid, true)
	local reachedLv = SeasonLv <= PassCheckModule.lv
	local gotPass = PassCheckModule.CheckGotSuperPass()

	return not gotSuper and reachedLv and gotPass
end

function PassCheckModule.CheckLvExistRewardCanGet(cfgRewardData)
	return PassCheckModule.CheckBaseRewardCanGet(cfgRewardData.Id, cfgRewardData.FreeReward[1], cfgRewardData.SeasonLv) or PassCheckModule.CheckSuperRewardCanGet(cfgRewardData.Id, cfgRewardData.PayReward[1], cfgRewardData.SeasonLv)
end

function PassCheckModule.CheckExistRewardCanGet()
	if PassCheckModule.state == 0 then
		return false
	end

	for i, v in pairs(PassCheckModule.rewardCid2IndexDic) do
		if PassCheckModule.CheckLvExistRewardCanGet(CfgBattlePassRewardTable[i]) then
			return true
		end
	end

	return false
end

function PassCheckModule.CheckPassIsOpen()
	return PassCheckModule.state == 1
end

function PassCheckModule.ReqGetReward(cids)
	PassCheckModule.lastGetRewardCids = cids
	PassCheckModule.lastGotBaseRewardCids = {}

	for i, v in pairs(cids) do
		local cfgRewardData = CfgBattlePassRewardTable[v]
		local gotBase = PassCheckModule.CheckRewardIsGot(v, cfgRewardData.FreeReward[1], false)

		if gotBase then
			PassCheckModule.lastGotBaseRewardCids[v] = v
		end
	end

	net_battlePasses.getRewards(cids)
end

function PassCheckModule.ReqGetRewardResult()
	local rewardDic = {}

	for i, v in pairs(PassCheckModule.lastGetRewardCids) do
		local cfgRewardData = CfgBattlePassRewardTable[v]
		local baseCid = cfgRewardData.FreeReward[1]
		local baseCount = cfgRewardData.FreeReward[2]
		local superCid = cfgRewardData.PayReward[1]
		local superCount = cfgRewardData.PayReward[2]

		if PassCheckModule.lastGotBaseRewardCids[v] == nil then
			if rewardDic[baseCid] == nil then
				rewardDic[baseCid] = baseCount
			else
				rewardDic[baseCid] = rewardDic[baseCid] + baseCount
			end
		end

		if PassCheckModule.CheckGotSuperPass() then
			if rewardDic[superCid] == nil then
				rewardDic[superCid] = superCount
			else
				rewardDic[superCid] = rewardDic[superCid] + superCount
			end
		end
	end

	local rewards = {}

	for i, v in pairs(rewardDic) do
		rewards[#rewards + 1] = {
			cid = i,
			num = v
		}
	end

	table.sort(rewards, function(a, b)
		return a.cid < b.cid
	end)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	EventDispatcher.Dispatch(EventID.BattlePassGetRewardSuccess)
end

function PassCheckModule.ReqGetLastSeasonRewards()
	local cfgData = CfgDiscreteDataTable[6520054]

	if PassCheckModule.lastSeasonLv <= 0 or PassCheckModule.lastSeasonLv < cfgData.Data[1] then
		return
	end

	PassCheckModule.lastLv = PassCheckModule.lv

	net_battlePasses.getLastSeasonRewards()
end

function PassCheckModule.ReqGetLastSeasonRewardsResult()
	local datum = PassCheckModule.GetRewardDatum(1, PassCheckModule.lastLv + 1, PassCheckModule.lv)
	local rewards = {}

	for i, v in ipairs(datum) do
		rewards[#rewards + 1] = {
			cid = v[1],
			num = v[2]
		}
	end

	if #rewards > 0 then
		UIModule.Open(Constant.UIControllerName.PassCheckNewTipUI, Constant.UILayer.UI, rewards)
	end
end

function PassCheckModule.OnNotifyUpdate(dailyDupPOD)
	PassCheckModule.UpdatePOD(dailyDupPOD)
	EventDispatcher.Dispatch(EventID.BattlePassUpdate)

	if not PassCheckModule.CheckPassIsOpen() then
		UIModule.Close(Constant.UIControllerName.PassCheckUI)
		UIModule.Close(Constant.UIControllerName.PassCheckDealUI)
		UIModule.Close(Constant.UIControllerName.PassCheckFunctionInfoUI)
		UIModule.Close(Constant.UIControllerName.PassCheckRewardListUI)
		UIModule.Close(Constant.UIControllerName.BuyPassCheckLevelUI)
	end
end
