-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/agent/FunCampAgent.lua

module("logic.extensions.funcamp.agent.FunCampAgent", package.seeall)

local FunCampAgent = class("FunCampAgent", BaseAgent)

function FunCampAgent:sendPM_CB_GetInfoReq(activityId)
	local req = CampBattleExtension_pb.PM_CB_GetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GetInfoRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampGetInfoRes)
	end
end

function FunCampAgent:sendPM_CB_SelectCampReq(activityId, campId)
	local req = CampBattleExtension_pb.PM_CB_SelectCampReq()

	req.activityId = activityId
	req.campId = campId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_SelectCampRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onSelectCampRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampSelectCampRes)
	end
end

function FunCampAgent:sendPM_CB_GetPlayInfoReq(activityId)
	local req = CampBattleExtension_pb.PM_CB_GetPlayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GetPlayInfoRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onGetPlayInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampGetPlayInfoRes)
	end
end

function FunCampAgent:sendPM_CB_DonateCoinsReq(activityId, type, id)
	local req = CampBattleExtension_pb.PM_CB_DonateCoinsReq()

	req.activityId = activityId
	req.type = type
	req.id = id

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_DonateCoinsRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onDonateCoinsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampDonateCoinsRes)
	end
end

function FunCampAgent:sendPM_CB_StartGameReq(activityId, clientKey)
	local req = CampBattleExtension_pb.PM_CB_StartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_StartGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FunCampTouchStartGame, true, msg.serverKey)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FunCampTouchStartGame, false)
	end
end

function FunCampAgent:sendPM_CB_EndGameReq(pairs, encryptedKey)
	local req = CampBattleExtension_pb.PM_CB_EndGameReq()

	req.pairs = pairs
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_EndGameRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onEndGameRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampTouchEndGame)
	end
end

function FunCampAgent:sendPM_CB_FindReq(activityId)
	local req = CampBattleExtension_pb.PM_CB_FindReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_FindRes(status, msg)
	if status == 0 then
		FunCampController.instance:handlePM_CB_FindRes(msg)
	end
end

function FunCampAgent:sendPM_CB_FightReq(activityId, form)
	local req = CampBattleExtension_pb.PM_CB_FightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_FightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FunCampAgent:sendPM_CB_BuyTimeReq(activityId, type)
	local req = CampBattleExtension_pb.PM_CB_BuyTimeReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_BuyTimeRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onBuyTimeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampBuyTimeRes)
	end
end

function FunCampAgent:sendPM_CB_GetRankInfoReq(activityId, campId)
	local req = CampBattleExtension_pb.PM_CB_GetRankInfoReq()

	req.activityId = activityId
	req.campId = campId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GetRankInfoRes(status, msg)
	if status == 0 then
		local cfg = msg

		FunCampController.instance:handlePM_CB_GetRankInfoRes(cfg)
	end
end

function FunCampAgent:sendPM_CB_GainCampPrizeReq(activityId)
	local req = CampBattleExtension_pb.PM_CB_GainCampPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GainCampPrizeRes(status, msg)
	if status == 0 then
		FunCampModel.instance:setHasGainCampPrize()
		GlobalDispatcher:dispatch(GlobalNotify.GainCampPrizeRes)
	end
end

function FunCampAgent:sendPM_CB_GetTaskInfoReq()
	local req = CampBattleExtension_pb.PM_CB_GetTaskInfoReq()

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GetTaskInfoRes(status, msg)
	if status == 0 then
		local tasklist = msg.taskList

		FunCampModel.instance:setTaskInfo(tasklist)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampTaskRes)
	end
end

function FunCampAgent:sendPM_CB_GainTaskPrizeReq(taskId)
	local req = CampBattleExtension_pb.PM_CB_GainTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_GainTaskPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FunCampGetTaskRes)
	end
end

function FunCampAgent:sendPM_CB_ViewReq(viewId)
	local req = CampBattleExtension_pb.PM_CB_ViewReq()

	req.viewId = viewId

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_ViewRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FunCampAgent:handlePM_CB_NotifyFightRes(status, msg)
	if status == 0 then
		local sceneId = msg.sceneId
		local id = msg.id
		local iswin = msg.isWin

		if iswin then
			local info = {}

			info.id = id
			info.sceneId = sceneId

			FunCampModel.instance:setCurNpcAndSceneId(msg)
			FunCampModel.instance:setLastPetState(true)
		end
	end
end

function FunCampAgent:sendPM_CB_BuyDonateTimesReq()
	local req = CampBattleExtension_pb.PM_CB_BuyDonateTimesReq()

	self:sendMsg(req)
end

function FunCampAgent:handlePM_CB_BuyDonateTimesRes(status, msg)
	if status == 0 then
		FunCampModel.instance:onBuyDonateTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FunCampBuyDonateTimesRes)
	end
end

FunCampAgent.instance = FunCampAgent.New()

return FunCampAgent
