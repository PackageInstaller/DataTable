-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/controller/OriginFightController.lua

module("logic.extensions.originfight.controller.OriginFightController", package.seeall)

local OriginFightController = class("OriginFightController", BaseController)

OriginFightController.GOD_FAVOR_ENUM = {
	YUAN_CHU = 2,
	MING_YUAN = 5,
	ZHI_XU = 6,
	YONG_HENG = 7,
	SHI_ZU = 4,
	DAO_YING = 1,
	KONG_LING = 3
}

function OriginFightController:sendPM_OriginFightInfoReq(activityId)
	OriginFightAgent.instance:sendPM_OriginFightInfoReq(activityId)
end

function OriginFightController:handlePM_OriginFightInfoRes(msg)
	OriginFightModel.instance:handlePM_OriginFightInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginFightInfoRes)
end

function OriginFightController:sendPM_OriginFightGainPrizeReq(activityId)
	OriginFightAgent.instance:sendPM_OriginFightGainPrizeReq(activityId)
end

function OriginFightController:handlePM_OriginFightGainPrizeRes(msg)
	OriginFightModel.instance:handlePM_OriginFightGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginFightGainPrizeRes)
end

function OriginFightController:sendPM_OriginFightCommonGodFavorReq(activityId, godFavorId)
	OriginFightAgent.instance:sendPM_OriginFightCommonGodFavorReq(activityId, godFavorId)
end

function OriginFightController:handlePM_OriginFightCommonGodFavorRes(msg)
	OriginFightModel.instance:handlePM_OriginFightCommonGodFavorRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginFightCommonGodFavorRes, msg.godFavorId)
end

function OriginFightController:sendPM_OriginFightCollectTitanReq(activityId)
	OriginFightAgent.instance:sendPM_OriginFightCollectTitanReq(activityId)
end

function OriginFightController:sendPM_OriginFightCollectTitanReq(activityId)
	OriginFightAgent.instance:sendPM_OriginFightCollectTitanReq(activityId)
end

function OriginFightController:handlePM_OriginFightCollectTitanRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginFightCollectTitanRes)
end

function OriginFightController:sendPM_OriginFightBattleReq(activityId, form, godFavorId)
	OriginFightAgent.instance:sendPM_OriginFightBattleReq(activityId, form, godFavorId)
end

function OriginFightController:handlePM_OriginFightNotifyBattleRes(msg)
	if msg.isWin then
		local activityId = msg.activityId
		local godFavorId = msg.godFavorId
		local godFavorCfg = OriginFightConfig.instance:getGodFavorCfgById(activityId, godFavorId)

		if godFavorCfg then
			OriginFightModel.instance:pushStoryId(godFavorCfg.storyId)
		end
	end
end

function OriginFightController:enterBattleClg(activityId)
	local customFmtMo = OriginFightModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginFightController:checkAllGodFavorFinish(activityId)
	local info = OriginFightModel.instance:getInfo(activityId)
	local godFavorCfgs = OriginFightConfig.instance:getGodFavorCfgs(activityId)
	local hasSummonGodFavorIds = info.hasSummonGodFavorIds
	local hasSummonGodFavorNum = #hasSummonGodFavorIds
	local godFavorNum = #godFavorCfgs

	return godFavorNum <= hasSummonGodFavorNum
end

function OriginFightController:allTiTanFinish(activityId)
	local tiTanCfgs = OriginFightConfig.instance:getTiTanCfgs(activityId)
	local actCfg = OriginFightConfig.instance:getActCfg(activityId)
	local tiTanGameActId = actCfg.gainTitanActivityId
	local allStageHasPass = MazeGameController.instance:hasPassAllStage(tiTanGameActId)

	if allStageHasPass then
		for i, cfg in ipairs(tiTanCfgs) do
			local curProgress = WorldProgressPrizeController.instance:getProgress(activityId, cfg.progressId)
			local hasFinishProgress = curProgress >= cfg.maxProgress

			if not hasFinishProgress then
				return false
			end
		end

		return true
	end

	return false
end

OriginFightController.instance = OriginFightController.New()

return OriginFightController
