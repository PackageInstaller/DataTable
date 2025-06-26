-- chunkname: @IQIGame\\Module\\ActivityPass\\ActivityPassModule.lua

ActivityPassModule = {}

function ActivityPassModule.Initialize()
	ActivityPassModule._InitData()
end

function ActivityPassModule._InitData()
	ActivityPassModule._CreatePassInfo()
	ActivityPassModule._CreatePassRewardList()
	ActivityPassModule._CreateBuyPassInfo()
	ActivityPassModule._CreateBuyPassExpInfo()
end

function ActivityPassModule.ShutDown()
	ActivityPassModule._CreatePassInfo()
end

function ActivityPassModule._CreatePassInfo()
	ActivityPassModule.vipExp = 0
	ActivityPassModule.openTime = ""
	ActivityPassModule.passExp = 0
	ActivityPassModule.passLevel = 0
	ActivityPassModule.isOpen = false
	ActivityPassModule.passLevelRewardList = nil
	ActivityPassModule.buyPassInfo = nil
	ActivityPassModule.buyPassExpInfo = nil
	ActivityPassModule.finishTasks = nil
	ActivityPassModule.extraRewardList = nil
end

function ActivityPassModule.GetPassLevelTaskList()
	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalLevelReward)

	table.sort(list, function(a, b)
		return a.cid < b.cid
	end)

	return list
end

function ActivityPassModule.GetHighLevelTaskWithNormalID(id)
	return TaskSystemModule.GetTaskByConfig(ActivityPassModule.GetHighLevelIDWithNormalID(id))
end

function ActivityPassModule.GetHighLevelIDWithNormalID(id)
	return id + 100
end

function ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()
	local buyHigh = false
	local buySuper = false
	local passCfgInfo = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.ActivityPassInfo)

	if WarehouseModule.FindItemForCid(passCfgInfo.normalItemID) then
		buyHigh = true
	end

	if WarehouseModule.FindItemForCid(passCfgInfo.HighItemID) then
		buySuper = true
	end

	return buyHigh, buySuper
end

function ActivityPassModule.GetIsPay()
	local buyHigh = ActivityPassModule.GetHadBuyPassTypes_MultipleReturn()

	return buyHigh
end

function ActivityPassModule.GetExtraRewardTaskData()
	local list = {}

	for _, v in pairs(TaskSystemModule.taskSystemDataDic) do
		if TaskSystemModule.CheckTaskMainTypeAndExtendType(v.cid, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_ApexLevelReward) then
			list = Clone(v)

			return list
		end
	end
end

function ActivityPassModule._CreatePassRewardList()
	ActivityPassModule.passLevelRewardList = {}
	ActivityPassModule.extraRewardList = {}

	for _, v in pairsCfg(CfgTaskTable) do
		if TaskSystemModule.MatchTask(v, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_NormalLevelReward) then
			local data = {}

			data.Normal = v
			data.High = CfgTaskTable[v.Id + 100]

			table.insert(ActivityPassModule.passLevelRewardList, data)
		end

		if TaskSystemModule.MatchTask(v, Constant.MainTaskType.Pass, Constant.ExtendTaskType.Pass_ApexLevelReward) then
			table.insert(ActivityPassModule.extraRewardList, v)
		end
	end

	table.sort(ActivityPassModule.passLevelRewardList, function(a, b)
		return a.Normal.NeedSchedule < b.Normal.NeedSchedule
	end)
end

function ActivityPassModule._CreateBuyPassInfo()
	local shopID = ActivityPassModule.GetPassShopID(Constant.passShopType.pass)

	ActivityPassModule.buyPassInfo = ShopModule.findByCommodityByShopId(shopID)

	table.sort(ActivityPassModule.buyPassInfo, function(a, b)
		return a.Price[1][2] < b.Price[1][2]
	end)
end

function ActivityPassModule._CreateBuyPassExpInfo()
	ActivityPassModule.buyPassExpInfo = {}

	local shopID = ActivityPassModule.GetPassShopID(Constant.passShopType.passExp)

	ActivityPassModule.buyPassExpInfo = ShopModule.findByCommodityByShopId(shopID)
end

function ActivityPassModule._ArrayToHashTable(Arr)
	local set = {}

	for _, v in pairsCfg(Arr) do
		set[tonumber(v)] = tonumber(v)
	end

	return set
end

function ActivityPassModule._TaskSortFunction(a, b)
	if a.status == Constant.passTaskStatus.hasDone and b.status ~= Constant.passTaskStatus.hasDone then
		return true
	elseif a.status ~= Constant.passTaskStatus.hasDone and b.status == Constant.passTaskStatus.hasDone then
		return false
	elseif a.status == Constant.passTaskStatus.hasDone and b.status == Constant.passTaskStatus.hasDone then
		return a.cid < b.cid
	elseif a.status ~= Constant.passTaskStatus.hasDone and b.status ~= Constant.passTaskStatus.hasDone then
		if a.status == Constant.passTaskStatus.hadGot then
			return false
		elseif b.status == Constant.passTaskStatus.hadGot then
			return true
		end
	end

	return a.cid < b.cid
end

function ActivityPassModule.GetPassRewardList()
	return ActivityPassModule.passLevelRewardList
end

function ActivityPassModule.GetBuyPassInfo()
	return ActivityPassModule.buyPassInfo
end

function ActivityPassModule.GetBuyPassExpInfo()
	return ActivityPassModule.buyPassExpInfo
end

function ActivityPassModule.GetPassMaxLevel()
	return getCfgTableLength(CfgPassLevelTable) - 1
end

function ActivityPassModule.GetPassLvIsMax()
	return ActivityPassModule.passLevel >= ActivityPassModule.GetPassMaxLevel()
end

function ActivityPassModule.GetTaskInfo(type)
	return
end

function ActivityPassModule.GetPassGiftReward(itemID)
	local cfgItemData = CfgUtil.GetItemCfgDataWithID(itemID)
	local ActionParamNormal = UIUtil.GetConfigArr(cfgItemData.ActionParams)
	local ActionParamLengthNormal = #ActionParamNormal
	local itemData = {}
	local index = 1

	for i = 1, ActionParamLengthNormal do
		local cid = ActionParamNormal[i][1]
		local itemCfg = CfgUtil.GetItemCfgDataWithID(cid)

		if itemCfg.IsHide ~= Constant.ItemHideType.All then
			local number = ActionParamNormal[i][2]

			itemData[index] = {
				ActionParam = ActionParamNormal[i],
				ItemData = ItemData.CreateByCIDAndNumber(cid, number)
			}
			index = index + 1
		end
	end

	return itemData
end

function ActivityPassModule.GetPassRewardWithLvRange(left, right)
	local rewardList = {}

	if left <= 1 then
		left = 1
	end

	local RewardLen = getCfgTableLength(ActivityPassModule.passLevelRewardList)

	if RewardLen <= right then
		right = RewardLen
	end

	for i = left, right do
		local tb = Clone(ActivityPassModule.passLevelRewardList[i])

		if not ActivityPassModule.GetIsPay() then
			tb.High = nil
		end

		table.insert(rewardList, tb)
	end

	local set = {}
	local itemList = {}
	local index = 1

	for _, v in pairs(rewardList) do
		for _, v2 in pairs(v) do
			local ActionParamNormal = UIUtil.GetConfigArr(v2.ActionParam)
			local ActionParamLengthNormal = getCfgTableLength(ActionParamNormal)

			for i = 1, ActionParamLengthNormal do
				if set[ActionParamNormal[i][1]] then
					set[ActionParamNormal[i][1]] = set[ActionParamNormal[i][1]] + ActionParamNormal[i][2]
				else
					local cid = ActionParamNormal[i][1]
					local number = ActionParamNormal[i][2]

					itemList[index] = {
						ActionParam = ActionParamNormal[i],
						ItemData = ItemData.CreateByCIDAndNumber(cid, number)
					}
					index = index + 1
					set[ActionParamNormal[i][1]] = ActionParamNormal[i][2]
				end
			end
		end
	end

	for _, v in pairs(itemList) do
		if set[v.ActionParam[1]] then
			v.ActionParam[2] = set[v.ActionParam[1]]
			v.ItemData.num = set[v.ActionParam[1]]
		end
	end

	return itemList
end

function ActivityPassModule.GetTaskInfoWithID(ID)
	return CfgTaskTable[ID]
end

function ActivityPassModule.GetLvExp(lv)
	return CfgPassLevelTable[lv + 1].Exp
end

function ActivityPassModule.GetWeekExpMax()
	return CfgDiscreteDataTable[Constant.passWeeklyExpMaxID].Data[1]
end

function ActivityPassModule.GetExtraMaxExp()
	return CfgDiscreteDataTable[Constant.passExtraExpMaxID].Data[1]
end

function ActivityPassModule.GetExtraReward()
	return ActivityPassModule.extraRewardList
end

function ActivityPassModule.GetExtraLv(lv)
	return CfgPassLevelTable[lv + 1].BigReward
end

function ActivityPassModule.CheckTaskIsFinished(taskID)
	return TaskSystemModule.GetFinishedTaskWithID(taskID)
end

function ActivityPassModule.ShowGetItems(shows)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows)
end

function ActivityPassModule.GetResidueTime()
	local serverTime = PlayerModule.GetServerTime()
	local openTime = ActivityPassModule.openTime / 1000
	local hasOpenTime = serverTime - openTime
	local activityData = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_Normal
	})
	local ResidueTime = CfgActivityTable[activityData[1].cid].Duration[1] - hasOpenTime

	return ResidueTime
end

function ActivityPassModule.GetItemNameWithID(ID)
	return CfgItemTable[ID].Name
end

function ActivityPassModule.GetPassShopID(shopType)
	for i, v in pairsCfg(CfgShopTable) do
		if v.Type == shopType then
			return i
		end
	end
end

function ActivityPassModule.GetPassCommodityID(passCommodityID)
	local cfgCommodityData = ShopModule.GetShopCommodityDataWithShopType(Constant.passShopType.pass)
	local TeamId = cfgCommodityData[passCommodityID]

	for _, v in pairsCfg(CfgCommodityTable) do
		local cfg = v

		if cfg.Team == TeamId then
			return cfg.Id
		end
	end
end

function ActivityPassModule.RemovePassTask(taskID)
	return
end

function ActivityPassModule.passTaskInfoRefresh(tasks)
	return
end

function ActivityPassModule.GetActivityPassCommodityData(commodityID)
	local allCommodity = ShopModule.GetAllItemsWithShopType(Constant.ShopType.PassShop.Type)

	for _, v in pairs(allCommodity) do
		if v.cid == commodityID then
			return v
		end
	end

	return nil
end

function ActivityModule.GetActivityPassCommodityCanBuy(commodityID, lv)
	local commodityCfg = CfgCommodityTable[commodityID]
	local checkResult = false
	local maxBuyLv = 0

	for _, conditonId in pairs(commodityCfg.BuyConditionId) do
		local conditionCfg = CfgConditionTable[conditonId]

		if conditionCfg.SubType[1] == Constant.ConditionConstant.SUB_TYPE_ActivityPassLv then
			checkResult = lv < conditionCfg.Value[1]
			maxBuyLv = conditionCfg.Value[1]

			break
		end
	end

	return checkResult, maxBuyLv
end

function ActivityPassModule.SendTask(cids)
	if not ActivityPassModule.isOpen then
		NoticeModule.ShowNoticeByType(1, ActivityPassApi:ActivityIsOver())

		return
	end

	net_task.submit(cids)
end

function ActivityPassModule.SubmitTask(cids)
	net_task.submit(cids)
end

function ActivityPassModule.submitTypePassTask(types)
	if not ActivityPassModule.isOpen then
		NoticeModule.ShowNoticeByType(1, ActivityPassApi:ActivityIsOver())

		return
	end

	TaskSystemModule.SubmitTaskForType(types)
end

function ActivityPassModule.SendPassBuy(id, num)
	if not ActivityPassModule.isOpen then
		NoticeModule.ShowNoticeByType(1, ActivityPassApi:ActivityIsOver())

		return
	end

	ShopModule.BuyItemRequest(id, num)
end

function ActivityPassModule.notifyPass(passPOD)
	ActivityPassModule.vipExp = passPOD.vipExp
	ActivityPassModule.openTime = passPOD.openTime
	ActivityPassModule.passLevel = passPOD.passLevel
	ActivityPassModule.isOpen = passPOD.state
	ActivityPassModule.passExp = passPOD.passExp

	if passPOD.state then
		log("通行证-->通行证开启状态：true")
	else
		log("通行证-->通行证开启状态：false")
	end

	EventDispatcher.Dispatch(EventID.ActivityPassUIActive, passPOD.state)
	EventDispatcher.Dispatch(EventID.ActivityPassUIRefreshPassInfo)
end

function ActivityPassModule.Reload(passPOD)
	ActivityPassModule.notifyPass(passPOD)
end
