-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/controller/GoldenTowerLotteryController.lua

module("logic.extensions.goldentowerlottery.controller.GoldenTowerLotteryController", package.seeall)

local GoldenTowerLotteryController = class("GoldenTowerLotteryController", BaseController)

function GoldenTowerLotteryController:onInit()
	self:onReset()
end

function GoldenTowerLotteryController:onReset()
	return
end

function GoldenTowerLotteryController:sendPM_GoldenTowerLotteryGetInfoReq(activityId)
	GoldenTowerLotteryAgent.instance:sendPM_GoldenTowerLotteryGetInfoReq(activityId)
end

function GoldenTowerLotteryController:handlePM_GoldenTowerLotteryGetInfoRes(msg)
	GoldenTowerLotteryModel.instance:handlePM_GoldenTowerLotteryGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoldenTowerLotteryGetInfoRes)
end

function GoldenTowerLotteryController:sendPM_GoldenTowerLotteryLotteryReq(activityId, poolId)
	GoldenTowerLotteryAgent.instance:sendPM_GoldenTowerLotteryLotteryReq(activityId, poolId)
end

function GoldenTowerLotteryController:handlePM_GoldenTowerLotteryLotteryRes(msg)
	if checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GoldenTowerLotteryModel.instance:pushChangeSetId(msg.changeSetId)
	end

	GoldenTowerLotteryModel.instance:handlePM_GoldenTowerLotteryLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_GoldenTowerLotteryLotteryRes, msg.prizeId)
end

function GoldenTowerLotteryController:getCanLotteryPrizeIdList(activityId, poolId, tier)
	local curPoolInfo = GoldenTowerLotteryModel.instance:getPoolInfo(activityId, poolId) or {}
	local gainPrizeMap = GoldenTowerLotteryModel.instance:getPrizeGainTimesMap(activityId, poolId) or {}
	local canLotteryList = {}

	if checknumber(curPoolInfo.curTier) > 0 then
		if not curPoolInfo.curTier then
			local curTier = 1

			if curTier == tier then
				local poolCfg = GoldenTowerLotteryConfig.instance:getPoolCfg(activityId, poolId) or {}
				local tierPlanId = checknumber(poolCfg.tierPlanId)
				local tierPlanCfg = GoldenTowerLotteryConfig.instance:getTierPlanCfg(tierPlanId, tier) or {}
				local prizePlanId = checknumber(tierPlanCfg.prizePlanId)
				local prizePlanCfgs = GoldenTowerLotteryConfig.instance:getPrizePlanCfgs(prizePlanId) or {}

				for i, cfg in ipairs(prizePlanCfgs) do
					local hasGainedNum = checknumber(gainPrizeMap[cfg.prizeId])
					local gainLimit = cfg.gainLimit

					if hasGainedNum < gainLimit then
						table.insert(canLotteryList, cfg.prizeId)
					end
				end
			end

			return canLotteryList
		end
	end
end

function GoldenTowerLotteryController:hasGetAllGetPrize(activityId, poolId, curTier)
	local poolCfg = GoldenTowerLotteryConfig.instance:getPoolCfg(activityId, poolId) or {}
	local tierPlanId = checknumber(poolCfg.tierPlanId)
	local tierPlanCfg = GoldenTowerLotteryConfig.instance:getTierPlanCfg(tierPlanId, curTier) or {}
	local prizePlanId = checknumber(tierPlanCfg.prizePlanId)
	local prizeGainTimesMap = GoldenTowerLotteryModel.instance:getPrizeGainTimesMap(activityId, poolId) or {}

	for prizeId, v in pairs(prizeGainTimesMap) do
		local prizeCfg = GoldenTowerLotteryConfig.instance:getPrizePlanCfg(prizePlanId, prizeId)

		if prizeCfg then
			if not prizeCfg.gainAll then
				local gainAll = false

				if gainAll then
					return true
				end
			end
		end
	end

	return false
end

GoldenTowerLotteryController.instance = GoldenTowerLotteryController.New()

return GoldenTowerLotteryController
