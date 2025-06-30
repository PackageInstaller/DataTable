-- chunkname: @IQIGame\\Module\\ActivityList\\ActivityListModule.lua

local activityViewBase = require("IQIGame.UI.ActivityList.ActivityViewBase")
local strengthActivityView = require("IQIGame.UI.ActivityList.StrengthActivity.StrengthActivityView")
local dupMultipleActivityView = require("IQIGame.UI.ActivityList.DupMultipleActivity.DupMultipleActivityView")
local levelPassActivityView = require("IQIGame.UI.ActivityList.LevelPassActivity.LevelPassActivityView")
local mainLinePassActivityView = require("IQIGame.UI.ActivityList.MainLinePassActivity.MainLinePassActivityView")
local firstRechargeActivityView = require("IQIGame.UI.ActivityList.FirstRechargeActivity.FirstRechargeActivityView")
local DiceGameActivityView = require("IQIGame/UI/ActivityList/DiceGameActivity/DiceGameActivityView")
local NoviceSignActivityView = require("IQIGame/UI/ActivityList/NoviceSignActivity/NoviceSignActivityView")
local lotteryActivityView = require("IQIGame.UI.ActivityList.LotteryActivity.LotteryActivityView")
local battleActivity = require("IQIGame.UI.ActivityList.BattleActivity.BattleActivityView")
local summerSignActivity = require("IQIGame.UI.ActivityList.SummerSignActivity.SummerSignActivity")
local NewSummerActivityView = require("IQIGame/UI/ActiveActivityList/NewSummerActivity/NewSummerActivityView")
local GlobalChannelActivityView = require("IQIGame/UI/ActivityList/GlobalChannelActivity/GlobalChannelActivityView")
local AccRechargeActivityView = require("IQIGame/UI/ActivityList/AccRechargeActivity/AccRechargeActivityView")
local AccRechargeActivityViewItem = require("IQIGame/UI/ActivityList/AccRechargeActivity/AccRechargeActivityViewItem")
local GlobalChannelActivityView = require("IQIGame/UI/ActivityList/GlobalChannelActivity/GlobalChannelActivityView")
local TreasureHuntActivityView = require("IQIGame/UI/ActivityList/TreasureHuntActivity/TreasureHuntActivityView")

ActivityListModule = {}

function ActivityListModule.GetActivityListByTeamID(teamID)
	local tabList = {}

	for k, v in pairsCfg(CfgActivityListTable) do
		if v.ActivityTeam == teamID and ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(v.ShowConditionID)) then
			table.insert(tabList, v)
		end
	end

	table.sort(tabList, function(cfg1, cfg2)
		return cfg1.Sort < cfg2.Sort
	end)

	return tabList
end

function ActivityListModule.GetActivityListCfgIsExist(cfgID, CfgList)
	local isExist = false

	isExist = table.search(CfgList, function(k, v)
		return v.Id == cfgID
	end)

	return isExist
end

function ActivityListModule.GetCommodityDataByActivityID(shopType, activityID)
	local allCommodity = ShopModule.GetAllItemsWithShopType(shopType)
	local commodityData
	local discreteDataTable = CfgDiscreteDataTable[Constant.DiscreteData.PassActivityCommodityID]

	for i = 1, #discreteDataTable.Data, 2 do
		if discreteDataTable.Data[i] == activityID then
			for _, v in pairs(allCommodity) do
				if v.cid == discreteDataTable.Data[i + 1] then
					commodityData = v

					break
				end
			end

			break
		end
	end

	return commodityData
end

function ActivityListModule.GetActivityTaskIsExist(type)
	if type == Constant.ActivityListCfgType.FirstRechargeActivityType then
		return ActivityListModule.GetFirstRechargeTaskIsExist()
	end

	return true
end

function ActivityListModule.GetFirstRechargeTaskIsExist()
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)

	if table.len(taskList) == 0 then
		return false
	end

	for i = 1, #taskList do
		if taskList[i].status == Constant.TaskStatus.doing or taskList[i].status == Constant.TaskStatus.hasDone then
			return true
		end
	end

	return false
end

function ActivityListModule.GetActivityListGameobjectLuaByType(type, obj)
	if type == Constant.ActivityListCfgType.StrengthActivityType then
		return activityViewBase.New(obj, strengthActivityView)
	elseif type == Constant.ActivityListCfgType.LevelPassActivityType then
		return activityViewBase.New(obj, levelPassActivityView)
	elseif type == Constant.ActivityListCfgType.DupMultipleActivityType then
		return activityViewBase.New(obj, dupMultipleActivityView)
	elseif type == Constant.ActivityListCfgType.MainLinePassActivityType then
		return activityViewBase.New(obj, mainLinePassActivityView)
	elseif type == Constant.ActivityListCfgType.FirstRechargeActivityType then
		return activityViewBase.New(obj, firstRechargeActivityView)
	elseif type == Constant.ActivityListCfgType.DiceGameActivityType then
		return activityViewBase.New(obj, DiceGameActivityView)
	elseif type == Constant.ActivityListCfgType.NoviceSignActivityType then
		return activityViewBase.New(obj, NoviceSignActivityView)
	elseif type == Constant.ActivityListCfgType.LotteryActivityType then
		return activityViewBase.New(obj, lotteryActivityView)
	elseif type == Constant.ActivityListCfgType.BattleActivityType then
		return activityViewBase.New(obj, battleActivity)
	elseif type == Constant.ActivityListCfgType.SummerSignActivityType then
		return activityViewBase.New(obj, summerSignActivity)
	elseif type == Constant.ActivityListCfgType.GlobalChannelActivity then
		return activityViewBase.New(obj, GlobalChannelActivityView)
	elseif type == Constant.ActivityListCfgType.AccRechargeActivity then
		return activityViewBase.New(obj, AccRechargeActivityView)
	elseif type == Constant.ActivityListCfgType.TreasureHuntActivity then
		return activityViewBase.New(obj, TreasureHuntActivityView)
	end

	return activityViewBase.New(obj, activityViewBase)
end

function ActivityListModule.GetRedDotTypeByType(activityListCfg)
	local type = activityListCfg.ActivityType

	if type == Constant.ActivityListCfgType.StrengthActivityType then
		return RedDotModule.CheckRedDot_StrengthSupplyIsCanReceive()
	elseif type == Constant.ActivityListCfgType.LevelPassActivityType then
		return RedDotModule.CheckRedDot_LevelPassIsCanReceive(activityListCfg)
	elseif type == Constant.ActivityListCfgType.MainLinePassActivityType then
		return RedDotModule.CheckRedDot_MainLinePassIsCanReceive(activityListCfg)
	elseif type == Constant.ActivityListCfgType.FirstRechargeActivityType then
		return RedDotModule.CheckRedDot_FirstRecharge()
	elseif type == Constant.ActivityListCfgType.DiceGameActivityType then
		return RedDotModule.CheckRedDot_DiceGame()
	elseif type == Constant.ActivityListCfgType.NoviceSignActivityType then
		return RedDotModule.CheckRedDot_NoviceSign()
	elseif type == Constant.ActivityListCfgType.BattleActivityType then
		return RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.BattleActivity) >= 1
	elseif type == Constant.ActivityListCfgType.SummerSignActivityType then
		return RedDotModule.CheckRedDot_SummerSign()
	elseif type == Constant.ActivityListCfgType.AccRechargeActivity then
		return RedDotModule.CheckRedDot_AccRecharge()
	elseif type == Constant.ActivityListCfgType.GlobalChannelActivity then
		return RedDotModule.CheckRedDot_GlobalChannelActivity()
	end

	return false
end

function ActivityListModule.GetAccChargeActivityDataList(activityCid)
	local list = {}

	ForPairs(CfgActivityChargeTable, function(_cid, _cfg)
		if _cfg.Activityid ~= activityCid then
			return
		end
	end)
end

function ActivityListModule.HasUnclaimedAccRechargeRewards(activityId)
	return AccRechargeActivityViewItem:HasUnclaimedRewards(activityId)
end

function ActivityListModule.HasUnclaimedItemsInGlobalChannelActivity(activityId)
	return GlobalChannelActivityView:HasRewardsToClaim(activityId)
end
