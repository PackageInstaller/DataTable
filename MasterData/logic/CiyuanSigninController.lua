-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/controller/CiyuanSigninController.lua

module("logic.extensions.ciyuansignin.controller.CiyuanSigninController", package.seeall)

local CiyuanSigninController = class("CiyuanSigninController", BaseController)

function CiyuanSigninController:onInit()
	self:onReset()
end

function CiyuanSigninController:onReset()
	return
end

function CiyuanSigninController:sendPM_CiyuanSigninGetInfoReq(activityId)
	CiyuanSigninAgent.instance:sendPM_CiyuanSigninGetInfoReq(activityId)
end

function CiyuanSigninController:handlePM_CiyuanSigninGetInfoRes(status, msg)
	CiyuanSigninModel.instance:handlePM_CiyuanSigninGetInfoRes(msg)
	self:refreshRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CiyuanSigninGetInfoRes, msg)
end

function CiyuanSigninController:sendPM_CiyuanSigninGainPrizeReq(activityId)
	CiyuanSigninAgent.instance:sendPM_CiyuanSigninGainPrizeReq(activityId)
end

function CiyuanSigninController:handlePM_CiyuanSigninGainPrizeRes(status, msg)
	CiyuanSigninModel.instance:handlePM_CiyuanSigninGainPrizeRes(msg)
	self:refreshRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CiyuanSigninGainPrizeRes, msg)
end

function CiyuanSigninController:sendPM_CiyuanSigninBuyMakeUpReq(activityId, days)
	CiyuanSigninAgent.instance:sendPM_CiyuanSigninBuyMakeUpReq(activityId, days)
end

function CiyuanSigninController:handlePM_CiyuanSigninBuyMakeUpRes(status, msg)
	CiyuanSigninModel.instance:handlePM_CiyuanSigninBuyMakeUpRes(msg)
	self:sendPM_CiyuanSigninGetInfoReq(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CiyuanSigninBuyMakeUpRes, msg)
end

function CiyuanSigninController:hasDimensionHeartBenefit(activityId)
	local cfg = CiyuanSigninConfig.instance:getActivityCfg(activityId)

	if cfg then
		if not cfg.divineDragonRaceId then
			local divineDragonRaceId = 14016

			if cfg then
				if not cfg.ciyuanDragonRaceId then
					local ciyuanDragonRaceId = 10313
					local isHasPet = HandbookModel.instance:isHasPet(divineDragonRaceId) and not HandbookModel.instance:isHasPet(ciyuanDragonRaceId)

					if cfg then
						local matType, matId, _ = MaterialMgr.getMatParams(cfg.ciyuanHeartItemType or "")
						local hasHeart = MaterialModel.instance:getMaterialsNumber(matType, matId) > 0

						return isHasPet or hasHeart
					end
				end
			end
		end
	end
end

function CiyuanSigninController:getRedPointId(activityId)
	local cfg = CiyuanSigninConfig.instance:getActivityCfg(activityId)

	return checknumber(cfg and cfg.redPointType)
end

function CiyuanSigninController:refreshRedPoint(activityId)
	local redPointId = self:getRedPointId(activityId)

	if redPointId > 0 then
		RedPointController.instance:setRedPointInfo(redPointId, self:canGainAnyPrize(activityId))
	end
end

function CiyuanSigninController:getBenefitDesc(activityId)
	local cfg = CiyuanSigninConfig.instance:getPlayerTypeCfg(activityId, self:getPlayerType(activityId))

	if cfg and not string.nilorempty(cfg.benefitDesc) then
		return cfg.benefitDesc
	end

	return ""
end

function CiyuanSigninController:getPlayerType(activityId)
	local cfg = CiyuanSigninConfig.instance:getActivityCfg(activityId)

	if cfg then
		if not cfg.ciyuanDragonRaceId then
			local raceId = 10313

			if HandbookModel.instance:isHasPet(raceId) then
				return CiyuanSigninConfig.PlayerType.DimensionDragon
			end

			if self:hasDimensionHeartBenefit(activityId) then
				return CiyuanSigninConfig.PlayerType.DimensionHeart
			end

			return CiyuanSigninConfig.PlayerType.None
		end
	end
end

function CiyuanSigninController:getMakeUpCostInfo(activityId, days)
	local cfg = CiyuanSigninConfig.instance:getPlayerTypeCfg(activityId, self:getPlayerType(activityId))

	if cfg then
		if not cfg.cost then
			local costStr = ""
			local matType, matId, matNum = MaterialMgr.getMatParams(costStr)

			days = math.max(checknumber(days), 0)

			return {
				costStr = costStr,
				matType = matType,
				matId = matId,
				matNum = matNum * days,
				days = days
			}
		end
	end
end

function CiyuanSigninController:getRemainingMakeUpDayCount(activityId)
	return math.max(CiyuanSigninConfig.instance:getMaxSignDay(activityId) - CiyuanSigninModel.instance:getSignedDayCount(activityId), 0)
end

function CiyuanSigninController:canBuyMakeUp(activityId)
	return self:getRemainingMakeUpDayCount(activityId) > 0
end

function CiyuanSigninController:canGainAnyPrize(activityId)
	for _, dayInfo in ipairs(CiyuanSigninModel.instance:getDayInfos(activityId)) do
		if not dayInfo.hasGainPrize then
			return true
		end
	end

	return false
end

function CiyuanSigninController:isSignedDay(activityId, day)
	return CiyuanSigninModel.instance:getDayInfo(activityId, day) ~= nil
end

function CiyuanSigninController:isGainPrizeDay(activityId, day)
	local dayInfo = CiyuanSigninModel.instance:getDayInfo(activityId, day)

	return (dayInfo or nil) and (dayInfo.hasGainPrize or false)
end

function CiyuanSigninController:canGainPrizeDay(activityId, day)
	local dayInfo = CiyuanSigninModel.instance:getDayInfo(activityId, day)

	if dayInfo then
		return not dayInfo.hasGainPrize
	end

	return false
end

function CiyuanSigninController:getSignRewardDayCfg(activityId, day)
	local dayInfo = CiyuanSigninModel.instance:getDayInfo(activityId, day)

	if dayInfo then
		if not dayInfo.playerType then
			local playerType = self:getPlayerType(activityId)
			local cfg = CiyuanSigninConfig.instance:getSignRewardCfg(activityId, playerType, day)

			if cfg and cfg.crossActivityLockId and cfg.crossActivityLockId > 0 then
				local lockIds = CiyuanSigninModel.instance:getLockIdSet(activityId)

				if lockIds[cfg.crossActivityLockId] then
					local lockPrize = cfg.crossActivityLockPrize

					if not string.nilorempty(lockPrize) then
						cfg = {
							activityId = cfg.activityId,
							day = cfg.day,
							playerType = cfg.playerType,
							prize = lockPrize,
							isBigPrize = cfg.isBigPrize
						}
					end
				end
			end

			return cfg
		end
	end
end

function CiyuanSigninController:getSignRewardList(activityId)
	local rewardList = {}
	local maxSignDay = CiyuanSigninConfig.instance:getMaxSignDay(activityId)

	for day = 1, maxSignDay do
		local cfg = self:getSignRewardDayCfg(activityId, day)

		if cfg then
			rewardList[#rewardList + 1] = cfg
		end
	end

	return rewardList
end

function CiyuanSigninController:getMakeUpRewardList(activityId, days)
	local rewardList = {}
	local startDay = CiyuanSigninModel.instance:getSignedDayCount(activityId)
	local endDay = math.min(startDay + math.max(checknumber(days), 0), CiyuanSigninConfig.instance:getMaxSignDay(activityId))

	for day = startDay + 1, endDay do
		local cfg = self:getSignRewardDayCfg(activityId, day)

		if cfg then
			rewardList[#rewardList + 1] = cfg
		end
	end

	return rewardList
end

CiyuanSigninController.instance = CiyuanSigninController.New()

return CiyuanSigninController
