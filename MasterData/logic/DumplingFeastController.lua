-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/controller/DumplingFeastController.lua

module("logic.extensions.dumplingfeast.controller.DumplingFeastController", package.seeall)

local DumplingFeastController = class("DumplingFeastController", BaseController)

function DumplingFeastController:onInit()
	return
end

function DumplingFeastController:onReset()
	return
end

function DumplingFeastController:sendPM_DumplingFeastInfoReq(activityId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastInfoReq(activityId)
end

function DumplingFeastController:handlePM_DumplingFeastInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastInfoRes(msg)
	self:updateRedOfIntimacy(msg.activityId)
	self:updateRedOfBossDamage(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastInfoRes)
end

function DumplingFeastController:sendPM_DumplingFeastRollDoughReq(activityId, seconds)
	DumplingFeastAgent.instance:sendPM_DumplingFeastRollDoughReq(activityId, seconds)
end

function DumplingFeastController:handlePM_DumplingFeastRollDoughRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastRollDoughRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastRollDoughRes)
end

function DumplingFeastController:sendPM_DumplingFeastStuffFillingReq(activityId, fillingId, seconds)
	DumplingFeastAgent.instance:sendPM_DumplingFeastStuffFillingReq(activityId, fillingId, seconds)
end

function DumplingFeastController:handlePM_DumplingFeastStuffFillingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastStuffFillingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastStuffFillingRes)
end

function DumplingFeastController:sendPM_DumplingFeastBoilDumplingReq(activityId, potId, dumplingId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastBoilDumplingReq(activityId, potId, dumplingId)
end

function DumplingFeastController:handlePM_DumplingFeastBoilDumplingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastBoilDumplingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastBoilDumplingRes, msg)
end

function DumplingFeastController:sendPM_DumplingFeastTakeOutDumplingReq(activityId, potId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastTakeOutDumplingReq(activityId, potId)
end

function DumplingFeastController:handlePM_DumplingFeastTakeOutDumplingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastTakeOutDumplingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastTakeOutDumplingRes, msg)
end

function DumplingFeastController:sendPM_DumplingFeastGainDumplingReq(activityId, bowlId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastGainDumplingReq(activityId, bowlId)
end

function DumplingFeastController:handlePM_DumplingFeastGainDumplingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastGainDumplingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastGainDumplingRes, msg)
end

function DumplingFeastController:sendPM_DumplingFeastFeedReq(activityId, raceId, dumplingInfoList)
	DumplingFeastAgent.instance:sendPM_DumplingFeastFeedReq(activityId, raceId, dumplingInfoList)
end

function DumplingFeastController:handlePM_DumplingFeastFeedRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastFeedRes(msg)
	self:updateRedOfIntimacy(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastFeedRes)
end

function DumplingFeastController:sendPM_DumplingFeastGainDamageProgressReq(activityId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastGainDamageProgressReq(activityId)
end

function DumplingFeastController:handlePM_DumplingFeastGainDamageProgressRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastGainDamageProgressRes(msg)
	self:updateRedOfBossDamage(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastGainDamageProgressRes)
end

function DumplingFeastController:sendPM_DumplingFeastGainIntimacyProgressReq(activityId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastGainIntimacyProgressReq(activityId)
end

function DumplingFeastController:handlePM_DumplingFeastGainIntimacyProgressRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastGainIntimacyProgressRes(msg)
	self:updateRedOfIntimacy(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastGainIntimacyProgressRes)
end

function DumplingFeastController:sendPM_DumplingFeastBossClgReq(activityId, form, isTrial)
	DumplingFeastAgent.instance:sendPM_DumplingFeastBossClgReq(activityId, form, isTrial)
end

function DumplingFeastController:handlePM_DumplingFeastBossClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastBossClgRes)
end

function DumplingFeastController:handlePM_DumplingFeastNotifyBossClgRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastNotifyBossClgRes(msg)
	self:updateRedOfBossDamage(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastNotifyBossClgRes)
end

function DumplingFeastController:sendPM_DumplingFeastRankViewReq(activityId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastRankViewReq(activityId)
end

function DumplingFeastController:handlePM_DumplingFeastRankViewRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastRankViewRes, msg)
end

function DumplingFeastController:sendPM_DumplingFeastOneClickMakeDumplingReq(activityId, num, dumplingId)
	DumplingFeastAgent.instance:sendPM_DumplingFeastOneClickMakeDumplingReq(activityId, num, dumplingId)
end

function DumplingFeastController:handlePM_DumplingFeastOneClickMakeDumplingRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DumplingFeastOneClickMakeDumplingRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DumplingFeastOneClickMakeDumplingRes, msg)
end

function DumplingFeastController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DumplingFeast)
end

function DumplingFeastController:getSubMo(activityId)
	return DumplingFeastModel.instance:getSubMo(activityId)
end

function DumplingFeastController:enterBossBattle(activityId, isTrial)
	local fmtMo = DumplingFeastModel.instance:getFmtMo(activityId)

	fmtMo:updateCfg(activityId, isTrial)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DumplingFeastController:updateRedOfIntimacy(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local subMo = self:getSubMo(activityId)
		local dataList = DumplingFeastConfig.instance:getIntimacyProgressDatas(activityId)

		for _, data in ipairs(dataList) do
			if subMo:isCanGetPrizeInIntimacy(data.progressId) then
				isActivated = true

				break
			end

			if not subMo:isEnoughGetPrizeInIntimacy(data.progressId) then
				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DUMMPLINGFEAST_INTIMACY_PRIZE, isActivated)
end

function DumplingFeastController:updateRedOfBossDamage(activityId)
	local isActivated = false
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if isInTime then
		local subMo = self:getSubMo(activityId)
		local dataList = DumplingFeastConfig.instance:getDamageProgressDatas(activityId)

		for _, data in ipairs(dataList) do
			if subMo:isCanGetPrizeInDamage(data.progressId) then
				isActivated = true

				break
			end

			if not subMo:isEnoughGetPrizeInDamage(data.progressId) then
				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DUMMPLINGFEAST_BOSS_DAMAGE_PRIZE, isActivated)
end

DumplingFeastController.instance = DumplingFeastController.New()

return DumplingFeastController
