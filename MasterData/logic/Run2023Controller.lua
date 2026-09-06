-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/controller/Run2023Controller.lua

module("logic.extensions.run2023.controller.Run2023Controller", package.seeall)

local Run2023Controller = class("Run2023Controller", BaseController)

function Run2023Controller:ctor()
	return
end

function Run2023Controller:onInit()
	return
end

function Run2023Controller:onReset()
	Run2023Model.instance:onReset()
end

function Run2023Controller:sendGameInfoReq(activityId)
	IntoTheCarAgent.instance:sendPM_IntoTheCarGameInfoReq(activityId)
end

function Run2023Controller:handleGameInfoRes(status, msg)
	if status == 0 then
		Run2023Model.instance:handleGameInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RunGameGetInfoRes)
	end
end

function Run2023Controller:sendStartGameReq(activityId, clientKey)
	IntoTheCarAgent.instance:sendPM_IntoTheCarStartGameReq(activityId, clientKey)
end

function Run2023Controller:handleStartGameRes(status, msg)
	if status == 0 then
		Run2023Model.instance:handleStartGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RunGameStart)
	end
end

function Run2023Controller:sendEndGameReq(activityId, useTime, encryptedKey)
	IntoTheCarAgent.instance:sendPM_IntoTheCarEndGameReq(activityId, useTime, encryptedKey)
end

function Run2023Controller:handleEndGameRes(status, msg)
	if status == 0 then
		Run2023Model.instance:handleEndGameRes()

		local changeSetId = checknumber(msg.changeSetId)
		local matMos = MaterialModel.instance:getMaterialMos(changeSetId)
		local prizeStrList = {}

		for _, mo in ipairs(matMos) do
			local prizeStr = mo:toString()

			table.insert(prizeStrList, prizeStr)
		end

		MaterialController.instance:saveChangeSetToTemp(changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.RunGameEndRes, changeSetId, prizeStrList)
	end
end

function Run2023Controller:sendPM_IntoTheCarUnLockLabelReq(activityId)
	IntoTheCarAgent.instance:sendPM_IntoTheCarUnLockLabelReq(activityId)
end

function Run2023Controller:handlePM_IntoTheCarUnLockLabelRes(status, msg)
	if status == 0 then
		Run2023Model.instance:setUnlockedLabelId(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UnLockedLabel)
	end
end

function Run2023Controller:sendPM_IntoTheCarSweepGameReq(activityId, sweepTimes)
	IntoTheCarAgent.instance:sendPM_IntoTheCarSweepGameReq(activityId, sweepTimes)
end

function Run2023Controller:handlePM_IntoTheCarSweepGameRes(msg)
	Run2023Model.instance:handlePM_IntoTheCarSweepGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RunGameSweepGameRes)
end

Run2023Controller.instance = Run2023Controller.New()

return Run2023Controller
