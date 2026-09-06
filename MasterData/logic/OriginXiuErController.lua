-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/controller/OriginXiuErController.lua

module("logic.extensions.originxiuer.controller.OriginXiuErController", package.seeall)

local OriginXiuErController = class("OriginXiuErController", BaseController)

OriginXiuErController.instance = OriginXiuErController.New()
OriginXiuErController.XIU_ER_PET_STATE = {
	YOU_HUN = 0,
	SUO_LIAN = 2,
	LIAN_DAO = 1
}

function OriginXiuErController:sendPM_OriginXiuErInfoReq(activityId)
	OriginXiuErAgent.instance:sendPM_OriginXiuErInfoReq(activityId)
end

function OriginXiuErController:handlePM_OriginXiuErInfoRes(msg)
	OriginXiuErModel.instance:handlePM_OriginXiuErInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginXiuErInfoRes)
end

function OriginXiuErController:sendPM_OriginXiuErResetReq(activityId)
	OriginXiuErAgent.instance:sendPM_OriginXiuErResetReq(activityId)
end

function OriginXiuErController:handlePM_OriginXiuErResetRes(msg)
	OriginXiuErModel.instance:handlePM_OriginXiuErResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginXiuErResetRes)
end

function OriginXiuErController:sendPM_OriginXiuErChallengeReq(activityId, form, stageId)
	OriginXiuErAgent.instance:sendPM_OriginXiuErChallengeReq(activityId, form, stageId)
end

function OriginXiuErController:handlePM_OriginXiuErNotifyChallengeRes(msg)
	if msg.isWin then
		-- block empty
	end
end

function OriginXiuErController:enterBattleClg(activityId, stageId)
	local customFmtMo = OriginXiuErModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginXiuErController:getLockAndUnlockPetPair(activityId)
	local actCfg = OriginXiuErConfig.instance:getActCfg(activityId)
	local info = OriginXiuErModel.instance:getInfo(activityId)
	local banNeedMarkNum = actCfg.banNeedMarkNum
	local unLockPetList = {}
	local lockPetList = {}

	if info then
		for k, pair in ipairs(info.raceIdToMarkNum) do
			local num = pair.right

			if num < banNeedMarkNum then
				table.insert(unLockPetList, pair)
			else
				table.insert(lockPetList, pair)
			end
		end
	end

	return lockPetList, unLockPetList
end

function OriginXiuErController:getLockAndUnlockPetMap(activityId)
	local actCfg = OriginXiuErConfig.instance:getActCfg(activityId)
	local info = OriginXiuErModel.instance:getInfo(activityId)
	local banNeedMarkNum = actCfg.banNeedMarkNum
	local unLockPetMap = {}
	local lockPetMap = {}

	if info then
		for k, pair in ipairs(info.raceIdToMarkNum) do
			local num = pair.right

			if num < banNeedMarkNum then
				unLockPetMap[pair.left] = pair.right
			else
				lockPetMap[pair.left] = pair.right
			end
		end
	end

	return lockPetMap, unLockPetMap
end

return OriginXiuErController
