-- chunkname: @modules/logic/versionactivity1_5/aizila/rpc/Activity144Rpc.lua

module("modules.logic.versionactivity1_5.aizila.rpc.Activity144Rpc", package.seeall)

local Activity144Rpc = class("Activity144Rpc", BaseRpc)

function Activity144Rpc:sendGet144InfosRequest(actId, callback, callbackObj)
	local req = Activity144Module_pb.Get144InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveGet144InfosReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:getInfosReply(msg)
	end
end

function Activity144Rpc:sendAct144EnterEpisodeRequest(actId, episodeId, callback, callbackObj)
	local req = Activity144Module_pb.Act144EnterEpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveAct144EnterEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:enterEpisodeReply(msg)
	end
end

function Activity144Rpc:sendAct144SelectOptionRequest(actId, option, callback, callbackObj)
	local req = Activity144Module_pb.Act144SelectOptionRequest()

	req.activityId = actId
	req.option = option

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveAct144SelectOptionReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:selectOptionReply(msg)
	end
end

function Activity144Rpc:sendAct144NextDayRequest(actId, callback, callbackObj)
	local req = Activity144Module_pb.Act144NextDayRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveAct144NextDayReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:nextDayReply(msg)
	end
end

function Activity144Rpc:sendAct144SettleEpisodeRequest(actId, callback, callbackObj)
	local req = Activity144Module_pb.Act144SettleEpisodeRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveAct144SettleEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:settleEpisodeReply(msg)
	end
end

function Activity144Rpc:onReceiveAct144SettlePush(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:settlePush(msg)
	end
end

function Activity144Rpc:sendAct144UpgradeEquipRequest(actId, equipId, callback, callbackObj)
	local req = Activity144Module_pb.Act144UpgradeEquipRequest()

	req.activityId = actId
	req.equipId = equipId

	self:sendMsg(req, callback, callbackObj)
end

function Activity144Rpc:onReceiveAct144UpgradeEquipReply(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:upgradeEquipReply(msg)
	end
end

function Activity144Rpc:onReceiveAct144EpisodePush(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:episodePush(msg)
	end
end

function Activity144Rpc:onReceiveAct144ItemChangePush(resultCode, msg)
	if resultCode == 0 then
		AiZiLaController.instance:itemChangePush(msg)
	end
end

Activity144Rpc.instance = Activity144Rpc.New()

return Activity144Rpc
