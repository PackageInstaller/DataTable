-- chunkname: @modules/logic/versionactivity1_2/yaxian/rpc/Activity115Rpc.lua

module("modules.logic.versionactivity1_2.yaxian.rpc.Activity115Rpc", package.seeall)

local Activity115Rpc = class("Activity115Rpc", BaseRpc)

function Activity115Rpc:sendGetAct115InfoRequest(actId, callback, callbackObj)
	local req = Activity115Module_pb.GetAct115InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveGetAct115InfoReply(resultCode, msg)
	if resultCode == 0 then
		YaXianModel.instance:updateInfo(msg)
	end
end

function Activity115Rpc:sendAct115StartEpisodeRequest(acdId, episodeId, callback, callbackObj)
	local req = Activity115Module_pb.Act115StartEpisodeRequest()

	req.activityId = acdId
	req.id = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveAct115StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		YaXianGameController.instance:initMapByMapMsg(msg.activityId, msg.map)
	end
end

function Activity115Rpc:sendAct115BeginRoundRequest(actId, operationsList, callback, callbackObj)
	local req = Activity115Module_pb.Act115BeginRoundRequest()

	req.activityId = actId

	for _, opt in ipairs(operationsList) do
		local optSvrData = req.operations:add()

		optSvrData.id = opt.id
		optSvrData.moveDirection = opt.dir
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveAct115BeginRoundReply(resultCode, msg)
	return
end

function Activity115Rpc:onReceiveAct115StepPush(resultCode, msg)
	if resultCode == 0 and YaXianGameEnum.ActivityId == msg.activityId then
		local stepMgr = YaXianGameController.instance.stepMgr

		if stepMgr then
			stepMgr:insertStepList(msg.steps)
		end
	end
end

function Activity115Rpc:sendAct115EventEndRequest(actId, callback, callbackObj)
	local req = Activity115Module_pb.Act115EventEndRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveAct115EventEndReply(resultCode, msg)
	return
end

function Activity115Rpc:sendAct115AbortRequest(actId, callback, callbackObj)
	local req = Activity115Module_pb.Act115AbortRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveAct115AbortReply()
	return
end

function Activity115Rpc:sendAct115BonusRequest(actId)
	local req = Activity115Module_pb.Act115BonusRequest()

	req.activityId = actId or YaXianEnum.ActivityId

	self:sendMsg(req)
end

function Activity115Rpc:onReceiveAct115BonusReply(code, msg)
	if code == 0 then
		YaXianModel.instance:updateGetBonusId(msg.hasGetBonusIds)
	end
end

function Activity115Rpc:sendAct115UseSkillRequest(actId, skillId, callback, callbackObj)
	local req = Activity115Module_pb.Act115UseSkillRequest()

	req.activityId = actId
	req.skillId = skillId

	self:sendMsg(req, callback, callbackObj)
end

function Activity115Rpc:onReceiveAct115UseSkillReply(code, msg)
	if code == 0 then
		local data = cjson.decode(msg.interactObject.data)

		if YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(data.skills) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
		end

		if YaXianGameModel.instance:updateEffectsAndCheckHasChange(data.effects) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
		end
	end
end

function Activity115Rpc:sendAct115RevertRequest(actId)
	local req = Activity115Module_pb.Act115RevertRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity115Rpc:onReceiveAct115RevertReply(code, msg)
	if code == 0 then
		YaXianGameModel.instance:initServerDataByServerData(msg.map)
		YaXianGameController.instance.state:setCurEvent(msg.map.currentEvent)
		YaXianGameController.instance:stopRunningStep()
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnRevert)
	end
end

Activity115Rpc.instance = Activity115Rpc.New()

return Activity115Rpc
