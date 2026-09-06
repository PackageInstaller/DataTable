-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/controller/MazeGameController.lua

module("logic.extensions.mazegame.controller.MazeGameController", package.seeall)

local MazeGameController = class("MazeGameController", BaseController)

MazeGameController.GAME_TYPE = {
	NORMAL = 1,
	WUJIN = 2
}

function MazeGameController:onInit()
	self:onReset()
end

function MazeGameController:onReset()
	return
end

function MazeGameController:sendPM_MazeGameInfoReq(activityId)
	MazeGameAgent.instance:sendPM_MazeGameInfoReq(activityId)
end

function MazeGameController:handlePM_MazeGameInfoRes(status, msg)
	if status == 0 then
		MazeGameModel.instance:handlePM_MazeGameInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_MazeGameInfoRes)
end

function MazeGameController:sendPM_MazeGameStartGameReq(activityId, stageId)
	local clientKey = MazeGameModel.instance:getClientKey(activityId)

	MazeGameAgent.instance:sendPM_MazeGameStartGameReq(activityId, clientKey, stageId)
end

function MazeGameController:handlePM_MazeGameStartGameRes(status, msg)
	if status == 0 then
		MazeGameModel.instance:handlePM_MazeGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_MazeGameStartGameRes, msg.stageId)
end

function MazeGameController:sendPM_MazeGameEndGameReq(activityId, stageId, passOrNotNum)
	local encryptedKey = MazeGameModel.instance:getEncryptedKey(activityId, passOrNotNum)

	MazeGameAgent.instance:sendPM_MazeGameEndGameReq(activityId, stageId, passOrNotNum, encryptedKey)
end

function MazeGameController:handlePM_MazeGameEndGameRes(status, msg)
	if status == 0 then
		MazeGameModel.instance:handlePM_MazeGameEndGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_MazeGameEndGameRes)
end

function MazeGameController:stageIsInTime(activityId, stageId)
	local stageCfg = MazeGameConfig.instance:getStageCfgById(activityId, stageId)
	local startTime = stageCfg.startTime
	local startTimeStamp = GameUtil.string2time(startTime)
	local curTimeStamp = ServerTime.now()

	return startTimeStamp <= curTimeStamp
end

function MazeGameController:getRewardTiTanStr(activityId, stageId)
	local stageCfg = MazeGameConfig.instance:getStageCfgById(activityId, stageId)
	local actCfg = MazeGameConfig.instance:getActCfg(activityId)
	local titanProgressActivityId = actCfg.titanProgressActivityId
	local tiTanCfgs = OriginFightConfig.instance:getTiTanCfgs(titanProgressActivityId)
	local rewardStr = "["

	for i, tiTanIdx in ipairs(stageCfg.elementalTitanList) do
		local curTiTanCfg = tiTanCfgs[tiTanIdx]

		if curTiTanCfg then
			if not curTiTanCfg.name then
				local tiTanName = ""

				rewardStr = i == #stageCfg.elementalTitanList and rewardStr .. string.format("%s", tiTanName) or rewardStr .. string.format("%s、", tiTanName)
			end
		end
	end

	rewardStr = rewardStr .. "]"

	return rewardStr
end

function MazeGameController:hasPassAllStage(activityId)
	local info = MazeGameModel.instance:getInfo(activityId)

	if info then
		if not info.passStageIds then
			local passStageIds = {}
			local stageCfgs = MazeGameConfig.instance:getStageCfgs(activityId)
			local totalStageNum = #stageCfgs

			return totalStageNum <= #passStageIds
		end
	end
end

MazeGameController.instance = MazeGameController.New()

return MazeGameController
