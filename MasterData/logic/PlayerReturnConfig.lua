-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/config/PlayerReturnConfig.lua

module("logic.extensions.playerreturn.config.PlayerReturnConfig", package.seeall)

local PlayerReturnConfig = class("PlayerReturnConfig", BaseConfig)

function PlayerReturnConfig:onInit()
	PlayerReturnConfig.super.onInit(self)

	self._activityCfgs = nil
	self._signAllCfgs = nil
	self._plgeAllCfgs = nil
	self._taskAllCfgs = nil
	self._scoreAllCfgs = nil
	self._shopAllCfgs = nil
	self._mainViewCfgs = nil
	self._backActivityCfg = nil
	self._backPrizeCfg = nil
	self._backTaskCfg = nil
end

function PlayerReturnConfig:getNames()
	return {
		"regress_activity",
		"regress_sign_in",
		"regress_privilege",
		"regress_task",
		"regress_task_score_prize",
		"regress_shop",
		"regress_main_view",
		"campaign_invite_activity",
		"campaign_invite_score_prize",
		"campaign_invite_limit",
		"campaign_invite_type_prize",
		"regress_lottery"
	}
end

function PlayerReturnConfig:handleConfig(name, content)
	if name == "regress_activity" then
		self._activityCfgs = content
	elseif name == "regress_sign_in" then
		self._signAllCfgs = content
	elseif name == "regress_privilege" then
		self._plgeAllCfgs = content
	elseif name == "regress_task" then
		self._taskAllCfgs = content
	elseif name == "regress_task_score_prize" then
		self._scoreAllCfgs = content
	elseif name == "regress_shop" then
		self._shopAllCfgs = content
	elseif name == "regress_main_view" then
		self._mainViewCfgs = content
	elseif name == "regress_lottery" then
		self._lotteryAllCfgs = content
	elseif name == "campaign_invite_activity" then
		self._backActivityCfg = content
	elseif name == "campaign_invite_score_prize" then
		self._backPrizeCfg = content
	elseif name == "campaign_invite_type_prize" then
		self._campaign_invite_type_prize = content
	elseif name == "campaign_invite_limit" then
		self._backTaskCfg = content
	end
end

function PlayerReturnConfig:getReturnActivityCfg(actId)
	actId = math.max(checknumber(actId), 1)

	if self._activityCfgs == nil or self._activityCfgs[actId] == nil then
		return
	end

	return self._activityCfgs[actId]
end

function PlayerReturnConfig:getReturnSignCfgs(planId)
	if self._signAllCfgs == nil or self._signAllCfgs[planId] == nil then
		return
	end

	return self._signAllCfgs[planId]
end

function PlayerReturnConfig:getReturnPlgeCfgs(planId, tabId)
	if self._plgeAllCfgs == nil or self._plgeAllCfgs[planId] == nil then
		return
	end

	local list = self._plgeAllCfgs[planId]

	if checknumber(tabId) <= 0 or list[tabId] == nil then
		local realList = {}

		for k, v in pairs(list) do
			table.insert(realList, v)
		end

		table.sort(realList, function(a, b)
			return a.type < b.type
		end)

		return realList
	end

	return list[tabId]
end

function PlayerReturnConfig:getReturnAllTaskCfgs(planId)
	if self._taskAllCfgs == nil or self._taskAllCfgs[planId] == nil then
		return
	end

	return self._taskAllCfgs[planId]
end

function PlayerReturnConfig:getReturnSingleTaskCfg(planId, taskId)
	local list = self:getReturnAllTaskCfgs(planId)

	if list == nil or list[taskId] == nil then
		return
	end

	return list[taskId]
end

function PlayerReturnConfig:getReturnScoreCfgs(planId)
	if self._scoreAllCfgs == nil or self._scoreAllCfgs[planId] == nil then
		return
	end

	return self._scoreAllCfgs[planId]
end

function PlayerReturnConfig:getReturnShopCfgs(planId, shopId)
	if self._shopAllCfgs == nil or self._shopAllCfgs[planId] == nil then
		return
	end

	local list = self._shopAllCfgs[planId]

	if checknumber(shopId) <= 0 or list[shopId] == nil then
		return list
	end

	return list[shopId]
end

function PlayerReturnConfig:getReturnMainViewCfgs(actId, tabId)
	if self._mainViewCfgs == nil or self._mainViewCfgs[actId] == nil then
		return
	end

	local list = self._mainViewCfgs[actId]

	if checknumber(tabId) <= 0 or list[tabId] == nil then
		return list
	end

	return list[tabId]
end

function PlayerReturnConfig:getReturnLotteryCfgs(planId, index)
	if self._lotteryAllCfgs == nil or self._lotteryAllCfgs[planId] == nil then
		return
	end

	local list = self._lotteryAllCfgs[planId]

	if checknumber(index) <= 0 or list[index] == nil then
		return list
	end

	return list[index]
end

function PlayerReturnConfig:getOpenActivityId()
	PlayerReturnModel.instance.backActId = nil

	if self._backActivityCfg == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(PlayerReturnModel.instance.backActType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			PlayerReturnModel.instance.backActId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function PlayerReturnConfig:getBackActivityCfg(actId)
	if self._backActivityCfg == nil or self._backActivityCfg[actId] == nil then
		return
	end

	return self._backActivityCfg[actId]
end

function PlayerReturnConfig:getBackPrizeCfg(planId)
	if self._backPrizeCfg == nil or self._backPrizeCfg[planId] == nil then
		return
	end

	return self._backPrizeCfg[planId]
end

function PlayerReturnConfig:getTypePrizeCfg(activityId)
	return self._campaign_invite_type_prize[activityId]
end

function PlayerReturnConfig:getTypePrizeData(activityId, prizeId)
	if self._campaign_invite_type_prize[activityId] then
		return self._campaign_invite_type_prize[activityId][prizeId]
	end
end

function PlayerReturnConfig:getBackTaskCfg(planId)
	if self._backTaskCfg == nil or self._backTaskCfg[planId] == nil then
		return
	end

	return self._backTaskCfg[planId]
end

PlayerReturnConfig.instance = PlayerReturnConfig.New()

return PlayerReturnConfig
