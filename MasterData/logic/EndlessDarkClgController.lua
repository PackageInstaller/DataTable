-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/controller/EndlessDarkClgController.lua

module("logic.extensions.endlessdark.controller.EndlessDarkClgController", package.seeall)

local EndlessDarkClgController = class("EndlessDarkClgController", BaseController)

function EndlessDarkClgController:ctor()
	self._activityId = 0
end

function EndlessDarkClgController:onInit()
	self:onReset()
end

function EndlessDarkClgController:onReset()
	return
end

function EndlessDarkClgController:sendPM_EndlessDarkClgGetInfoReq(activityId)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgGetInfoReq(activityId)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgGetInfoRes(status, msg)
	if status == 0 then
		EndlessDarkClgModel.instance:handlePM_EndlessDarkClgGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgGetInfoRes)
end

function EndlessDarkClgController:sendPM_EndlessDarkClgStartFightReq(activityId, form)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgStartFightReq(activityId, form)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgStartFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgStartFightRes)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgNotifyFightRes(status, msg)
	if msg.isWin then
		ChopKingModel.instance:saveRogueChallengeInfo(msg)

		if msg.isFinish == false then
			BattleFacade.instance:registerResultHandler(function()
				BattleFacade.instance:startContinuousBattle()
				self:sendPM_EndlessDarkClgContinueFightReq(msg.activityId)

				return true
			end, self)
		else
			BattleFacade.instance:registerResultHandler(function()
				ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

				return false
			end, self)
		end
	else
		BattleFacade.instance:registerResultHandler(function()
			ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)

			return false
		end, self)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgNotifyFightRes)
end

function EndlessDarkClgController:sendPM_EndlessDarkClgStartFightReq(activityId, form)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgStartFightReq(activityId, form)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgStartFightRes(status, msg)
	if status == 0 then
		EndlessDarkClgModel.instance:handlePM_EndlessDarkClgStartFightRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgStartFightRes)
end

function EndlessDarkClgController:sendPM_EndlessDarkClgContinueFightReq(activityId)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgContinueFightReq(activityId)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgContinueFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgContinueFightRes)
end

function EndlessDarkClgController:sendPM_EndlessDarkClgViewRankReq(activityId)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgViewRankReq(activityId)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgViewRankRes(status, msg)
	if status == 0 then
		EndlessDarkClgModel.instance:handlePM_EndlessDarkClgViewRankRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgViewRankRes, msg)
end

function EndlessDarkClgController:sendPM_EndlessDarkClgUpgradeBuffReq(activityId, buffType)
	EndlessDarkClgAgent.instance:sendPM_EndlessDarkClgUpgradeBuffReq(activityId, buffType)
end

function EndlessDarkClgController:handlePM_EndlessDarkClgUpgradeBuffRes(status, msg)
	if status == 0 then
		EndlessDarkClgModel.instance:handlePM_EndlessDarkClgUpgradeBuffRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EndlessDarkClgUpgradeBuffRes)
end

function EndlessDarkClgController:enterBattleClg(activityId, waveId, stageId)
	local customFmtMo = EndlessDarkClgModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, waveId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function EndlessDarkClgController:getCurFinishPrizeId(activityId)
	local info = EndlessDarkClgModel.instance:getInfo(activityId) or {}

	return checknumber(info.stageId)
end

function EndlessDarkClgController:getRewardList(activityId, rank)
	local rankPrizeCfgs = EndlessDarkClgConfig.instance:getRankPrizeCfg(activityId) or {}
	local rewardList = {}

	for i, cfg in pairs(rankPrizeCfgs) do
		local rankRange = cfg.rankRange

		if rank >= rankRange[1] and rank <= rankRange[2] then
			local prize = cfg.prize
			local arr = string.split(prize, "#")

			for i, prizeStr in ipairs(arr) do
				table.insert(rewardList, prizeStr)
			end

			return rewardList
		end
	end

	return rewardList
end

EndlessDarkClgController.instance = EndlessDarkClgController.New()

return EndlessDarkClgController
