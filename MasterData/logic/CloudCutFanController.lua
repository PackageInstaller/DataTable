-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/controller/CloudCutFanController.lua

module("logic.extensions.cloudcutfan.controller.CloudCutFanController", package.seeall)

local CloudCutFanController = class("CloudCutFanController", BaseController)

function CloudCutFanController:onInit()
	self:onReset()
end

function CloudCutFanController:onReset()
	self._curFmtMoMap = {}
end

function CloudCutFanController:getDefaultActivityId()
	return 615001
end

function CloudCutFanController:getUseMatPicUrl(picPath)
	local truePath = string.format("ui/bigbg/views/cloudcutfan/%s.png", picPath)

	if Framework.OSDef.isEditor and not GoUtil.IsAssetExist(truePath) then
		printError("资源不存在：", truePath)

		return ""
	end

	return truePath
end

function CloudCutFanController:isRPActive(activityId)
	local info = CloudCutFanModel.instance:getInfo(activityId)

	if info then
		local actCfg = CloudCutFanConfig.instance:getActCfgByActId(activityId) or {}
		local allFanFaceCfgs = CloudCutFanConfig.instance:getAllFanFaceCfgs(activityId) or {}
		local allFanMakeCfgs = CloudCutFanConfig.instance:getAllFanMakeCfgs(activityId) or {}
		local prizeCfgs = CloudCutFanConfig.instance:getAllChallengePrizeCfgs(activityId) or {}
		local unLockCount = CloudCutFanModel.instance:getTotalUnlockCount(activityId)
		local allCount = #allFanFaceCfgs + #allFanMakeCfgs

		if unLockCount < allCount then
			if not info.todayCraftUsedCount then
				local todayCraftUsedCount = 0

				if not actCfg.dailyCraftCount then
					local dailyCraftLimit = 0

					if todayCraftUsedCount < dailyCraftLimit then
						return true
					end

					if not info.todayRepairedFace then
						local isTodayRepairedFace = false

						if not isTodayRepairedFace then
							return true
						end
					end
				end
			end
		end

		if not info.gainedPrizeIdMap then
			local gainedPrizeIdMap = {}

			for _, prizeCfg in ipairs(prizeCfgs) do
				if not prizeCfg.prizeId then
					if gainedPrizeIdMap[prizeCfg.prizeId] ~= true then
						if not prizeCfg.needUnLockCount then
							if prizeCfg.needUnLockCount <= unLockCount then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function CloudCutFanController:enterFmtMo(activityId, isPreView)
	local fmtmo = self._curFmtMoMap[activityId]

	if fmtmo == nil then
		fmtmo = CloudCutFanFmtMo.New()
		self._curFmtMoMap[activityId] = fmtmo
	end

	fmtmo:initParams(activityId, isPreView)
	CustomFmtController.instance:showMissionView(fmtmo)
end

function CloudCutFanController:getInfo(activityId)
	CloudCutFanAgent.instance:sendPM_CloudCutFanInfoReq(activityId)
end

function CloudCutFanController:handlePM_CloudCutFanInfoRes(msg)
	CloudCutFanModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanInfoRes)
end

function CloudCutFanController:bossClg(activityId, isPreview, form_pb)
	BattleFacade.instance:registerResultHandler(function()
		return self:_onBattleEnd(activityId)
	end)
	CloudCutFanAgent.instance:sendPM_CloudCutFanBossClgReq(activityId, isPreview, form_pb)
end

function CloudCutFanController:handlePM_CloudCutFanBossClgRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanBossClgRes)
end

function CloudCutFanController:makeFan(activityId, face, frame, tail)
	CloudCutFanAgent.instance:sendPM_CloudCutFanMakeFanReq(activityId, face, frame, tail)
end

function CloudCutFanController:handlePM_CloudCutFanMakeFanRes(msg)
	CloudCutFanModel.instance:onMakeFan(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanMakeFanRes)
end

function CloudCutFanController:unLockFace(activityId, faceId)
	CloudCutFanAgent.instance:sendPM_CloudCutFanUnLockFaceReq(activityId, faceId)
end

function CloudCutFanController:handlePM_CloudCutFanUnLockFaceRes(msg)
	CloudCutFanModel.instance:onUnLockFace(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanUnLockFaceRes)
end

function CloudCutFanController:getRewardPrize(activityId)
	CloudCutFanAgent.instance:sendPM_CloudCutFanGetRewardPrizeReq(activityId)
end

function CloudCutFanController:handlePM_CloudCutFanGetRewardPrizeRes(msg)
	CloudCutFanModel.instance:onGetRewardPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanGetRewardPrizeRes)
end

function CloudCutFanController:handlePM_CloudCutFanNotifyBossClgRes(msg)
	CloudCutFanModel.instance:onNotifyBossClg(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_CloudCutFanNotifyBossClgRes)
end

function CloudCutFanController:_onBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = CloudCutFanModel.instance:getLastClgResult(activityId)
	local settleDesc = langPara("对敌方造成的总伤害；<color=#20b376>%s</color>", (lastFightInfo or nil) and checknumber(lastFightInfo.damage))

	BattleSettlementController.instance:addConditionElement(settleDesc)
	UIStateManager.instance:push(ViewName.BattleSettlementSuccess)

	return true
end

CloudCutFanController.instance = CloudCutFanController.New()

return CloudCutFanController
