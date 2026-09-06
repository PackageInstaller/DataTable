-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/controller/EternalCityController.lua

module("logic.extensions.eternalcity.controller.EternalCityController", package.seeall)

local EternalCityController = class("EternalCityController", BaseController)

function EternalCityController:onInit()
	return
end

function EternalCityController:onReset()
	self._onlyIdInPlace = nil
	self._onlyIdInUnequip = nil
	self._onlyIdInMove = nil
	self._onlyIdInCraft = nil
end

function EternalCityController:sendPM_EternalCityInfoReq(activityId)
	EternalCityAgent.instance:sendPM_EternalCityInfoReq(activityId)
end

function EternalCityController:handlePM_EternalCityInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityInfoRes(msg)
	self:updateRedOfPetShop(msg.activityId)
	self:updateRedOfProsperity(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityInfoRes)
end

function EternalCityController:sendPM_EternalCityRecruitReq(activityId, poolId)
	EternalCityAgent.instance:sendPM_EternalCityRecruitReq(activityId, poolId)
end

function EternalCityController:handlePM_EternalCityRecruitRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityRecruitRes(msg)
	self:updateRedOfPetShop(msg.activityId)
	self:updateRedOfProsperity(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityRecruitRes)
end

function EternalCityController:sendPM_EternalCityRefreshPoolReq(activityId)
	EternalCityAgent.instance:sendPM_EternalCityRefreshPoolReq(activityId)
end

function EternalCityController:handlePM_EternalCityRefreshPoolRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityRefreshPoolRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityRefreshPoolRes)
end

function EternalCityController:sendPM_EternalCityStageClgReq(activityId, form_pb, stageId)
	EternalCityAgent.instance:sendPM_EternalCityStageClgReq(activityId, form_pb, stageId)
end

function EternalCityController:handlePM_EternalCityStageClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityStageClgRes)
end

function EternalCityController:sendPM_EternalCityBossClgReq(activityId, form_pb)
	EternalCityAgent.instance:sendPM_EternalCityBossClgReq(activityId, form_pb)
end

function EternalCityController:handlePM_EternalCityBossClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityBossClgRes)
end

function EternalCityController:sendPM_EternalCityBuyBuildingReq(activityId, buildingId, num)
	EternalCityAgent.instance:sendPM_EternalCityBuyBuildingReq(activityId, buildingId, num)
end

function EternalCityController:handlePM_EternalCityBuyBuildingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityBuyBuildingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityBuyBuildingRes, msg)
end

function EternalCityController:sendPM_EternalCitySaleBuildingReq(activityId, buildingId, level, num)
	EternalCityAgent.instance:sendPM_EternalCitySaleBuildingReq(activityId, buildingId, level, num)
end

function EternalCityController:handlePM_EternalCitySaleBuildingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCitySaleBuildingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCitySaleBuildingRes, msg)
end

function EternalCityController:sendPM_EternalCityCraftBuildingReq(activityId, buildingId, craftLevel, oldPos, newPos, onlyId)
	if self._onlyIdInCraft then
		EternalCityAgent.instance:sendPM_EternalCityCraftBuildingReq(0, 0, 0, nil, nil)
	else
		self._onlyIdInCraft = onlyId

		EternalCityAgent.instance:sendPM_EternalCityCraftBuildingReq(activityId, buildingId, craftLevel, oldPos, newPos)
	end
end

function EternalCityController:handlePM_EternalCityCraftBuildingRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_EternalCityCraftBuildingRes(msg)
	end

	local onlyId = self._onlyIdInCraft

	self._onlyIdInCraft = nil

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityCraftBuildingRes, status, msg, onlyId)
end

function EternalCityController:sendPM_EternalCityPlaceBuildingReq(activityId, buildingId, level, x, y, onlyId)
	if self._onlyIdInPlace then
		EternalCityAgent.instance:sendPM_EternalCityPlaceBuildingReq(0, 0, 0, 0, 0)
	else
		self._onlyIdInPlace = onlyId

		EternalCityAgent.instance:sendPM_EternalCityPlaceBuildingReq(activityId, buildingId, level, x, y)
	end
end

function EternalCityController:handlePM_EternalCityPlaceBuildingRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_EternalCityPlaceBuildingRes(msg)
		self:updateRedOfProsperity(msg.activityId)
	end

	local onlyId = self._onlyIdInPlace

	self._onlyIdInPlace = nil

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityPlaceBuildingRes, status, msg, onlyId)
end

function EternalCityController:sendPM_EternalCityUnequipBuildingReq(activityId, buildingId, level, x, y, onlyId)
	if self._onlyIdInUnequip then
		EternalCityAgent.instance:sendPM_EternalCityUnequipBuildingReq(0, 0, 0, 0, 0)
	else
		self._onlyIdInUnequip = onlyId

		EternalCityAgent.instance:sendPM_EternalCityUnequipBuildingReq(activityId, buildingId, level, x, y)
	end
end

function EternalCityController:handlePM_EternalCityUnequipBuildingRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_EternalCityUnequipBuildingRes(msg)
	end

	local onlyId = self._onlyIdInUnequip

	self._onlyIdInUnequip = nil

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityUnequipBuildingRes, status, msg, onlyId)
end

function EternalCityController:sendPM_EternalCityMoveBuildingReq(activityId, buildingId, level, oldX, oldY, newX, newY, onlyId)
	if self._onlyIdInMove then
		EternalCityAgent.instance:sendPM_EternalCityMoveBuildingReq(0, 0, 0, 0, 0, 0, 0)
	else
		self._onlyIdInMove = onlyId

		EternalCityAgent.instance:sendPM_EternalCityMoveBuildingReq(activityId, buildingId, level, oldX, oldY, newX, newY)
	end
end

function EternalCityController:handlePM_EternalCityMoveBuildingRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_EternalCityMoveBuildingRes(msg)
	end

	local onlyId = self._onlyIdInMove

	self._onlyIdInMove = nil

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityMoveBuildingRes, status, msg, onlyId)
end

function EternalCityController:sendPM_EternalCityOperaPetReq(activityId, buildingId, level, x, y, petIds)
	EternalCityAgent.instance:sendPM_EternalCityOperaPetReq(activityId, buildingId, level, x, y, petIds)
end

function EternalCityController:handlePM_EternalCityOperaPetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityOperaPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityOperaPetRes, msg)
end

function EternalCityController:sendPM_EternalCityGainProfitReq(activityId)
	EternalCityAgent.instance:sendPM_EternalCityGainProfitReq(activityId)
end

function EternalCityController:handlePM_EternalCityGainProfitRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityGainProfitRes(msg)
	self:updateRedOfProsperity(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityGainProfitRes)
end

function EternalCityController:sendPM_EternalCityRankViewReq(activityId)
	EternalCityAgent.instance:sendPM_EternalCityRankViewReq(activityId)
end

function EternalCityController:handlePM_EternalCityRankViewRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityRankViewRes, msg)
end

function EternalCityController:sendPM_EternalCityOperaPoolReq(activityId, poolId, operaType)
	EternalCityAgent.instance:sendPM_EternalCityOperaPoolReq(activityId, poolId, operaType)
end

function EternalCityController:handlePM_EternalCityOperaPoolRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityOperaPoolRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityOperaPoolRes, msg)
end

function EternalCityController:handlePM_EternalCityNotifyStageClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityNotifyStageClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityNotifyStageClgRes)
end

function EternalCityController:handlePM_EternalCityNotifyBossClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityNotifyBossClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityNotifyBossClgRes)
end

function EternalCityController:handlePM_EternalCityNotifyProsperityChangeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_EternalCityNotifyProsperityChangeRes(msg)
	self:updateRedOfProsperity(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_EternalCityNotifyProsperityChangeRes)
end

function EternalCityController:updateRedOfPetShop(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local subMo = self:getSubMo(activityId)

		isActivated = subMo:isEnoughRecruitTimes()
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ETERNALCITY_PETSHOP, isActivated)
end

function EternalCityController:updateRedOfProsperity(activityId)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ETERNALCITY_PROSPERITY, (isInTime or nil) and self:isCanGainProfit(activityId))
end

function EternalCityController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalCity)
end

function EternalCityController:getSubMo(activityId)
	return EternalCityModel.instance:getSubMo(activityId)
end

function EternalCityController:enterStageBattle(activityId, stageId)
	local fmtMo = EternalCityModel.instance:getStageClgFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function EternalCityController:enterBossBattle(activityId, bossId)
	local fmtMo = EternalCityModel.instance:getBossClgFmtMo()

	fmtMo:updateCfg(activityId, bossId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function EternalCityController:getCurBossId(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EternalCity, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now()) - 1
	local cfg = EternalCityConfig.instance:getBossDatas(activityId) or {}
	local length = #cfg

	if length > 0 then
		return (day - 1) % length + 1
	else
		return 0
	end
end

function EternalCityController:isCanGainProfit(activityId)
	local subMo = self:getSubMo(activityId)
	local diffMin = self:getGainProfitDiffMin(activityId)
	local interval = subMo:getGainProfitInterval()
	local isCanGain = interval <= diffMin

	if isCanGain then
		local historyMaxProsperity = subMo:getHistoryMaxProsperity()
		local data = EternalCityConfig.instance:getProsperityDataByProsperity(activityId, historyMaxProsperity)

		if data then
			local diffMin = EternalCityController.instance:getGainProfitDiffMin(activityId)
			local matMo = subMo:getProsperityRewardMat(data.prosperity)

			if matMo then
				if not matMo.matNum then
					local matNum = 0

					isCanGain = diffMin * matNum > 0
				end
			end
		end
	end

	return isCanGain
end

function EternalCityController:getGainProfitDiffMin(activityId)
	local result = 0
	local subMo = self:getSubMo(activityId)
	local historyMaxProsperity = subMo:getHistoryMaxProsperity()
	local data = EternalCityConfig.instance:getProsperityDataByProsperity(activityId, historyMaxProsperity)

	if data then
		local last = subMo:getLastGainProfitTime()
		local now = ServerTime.now() * 1000

		result = Mathf.Floor(Mathf.Max(0, (now - last) / 1000 / 60))
		result = Mathf.Min(result, data.maxStoreRewardTime)
	end

	return result
end

EternalCityController.instance = EternalCityController.New()

return EternalCityController
