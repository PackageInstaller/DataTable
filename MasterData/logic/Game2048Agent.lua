-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/agent/Game2048Agent.lua

module("logic.extensions.numberpuzzlegame.agent.Game2048Agent", package.seeall)

local Game2048Agent = class("Game2048Agent", BaseAgent)

function Game2048Agent:sendPM_2048InfoReq(activityId)
	local req = Game2048Extension_pb.PM_2048InfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048InfoRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048InfoRes(msg)
	end
end

function Game2048Agent:sendPM_2048StartGameReq(activityId, mode, stageId, clientKey)
	local req = Game2048Extension_pb.PM_2048StartGameReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048StartGameRes(status, msg)
	NumberPuzzleGameController.instance:handlePM_2048StartGameRes(status, msg)
end

function Game2048Agent:sendPM_2048EndGameReq(activityId, mode, stageId, isPass, score, encryptedKey, maxGridId, extremeUsedEnergy)
	local req = Game2048Extension_pb.PM_2048EndGameReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId
	req.isPass = isPass
	req.score = score
	req.encryptedKey = encryptedKey
	req.maxGridId = maxGridId
	req.extremeUsedEnergy = extremeUsedEnergy

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048EndGameRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048EndGameRes(msg)
	end
end

function Game2048Agent:sendPM_2048EndRankReq(activityId)
	local req = Game2048Extension_pb.PM_2048EndRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048EndRankRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048EndRankRes(msg)
	end
end

function Game2048Agent:sendPM_2048OpenHangingEfficiencyReq(activityId, gridId)
	local req = Game2048Extension_pb.PM_2048OpenHangingEfficiencyReq()

	req.activityId = activityId
	req.gridId = gridId

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048OpenHangingEfficiencyRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048OpenHangingEfficiencyRes(msg)
	end
end

function Game2048Agent:sendPM_2048ExtremeGainPrizeReq(activityId)
	local req = Game2048Extension_pb.PM_2048ExtremeGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048ExtremeGainPrizeRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048ExtremeGainPrizeRes(msg)
	end
end

function Game2048Agent:sendPM_2048ExtremeRankReq(activityId)
	local req = Game2048Extension_pb.PM_2048ExtremeRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function Game2048Agent:handlePM_2048ExtremeRankRes(status, msg)
	if status == 0 then
		NumberPuzzleGameController.instance:handlePM_2048ExtremeRankRes(msg)
	end
end

Game2048Agent.instance = Game2048Agent.New()

return Game2048Agent
