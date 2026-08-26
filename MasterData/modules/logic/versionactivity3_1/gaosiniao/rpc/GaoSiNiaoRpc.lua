-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/rpc/GaoSiNiaoRpc.lua

module("modules.logic.versionactivity3_1.gaosiniao.rpc.GaoSiNiaoRpc", package.seeall)

local GaoSiNiaoRpc = class("GaoSiNiaoRpc", Activity210Rpc)

function GaoSiNiaoRpc:ctor()
	Activity210Rpc.instance = self
end

function GaoSiNiaoRpc:_actId()
	return GaoSiNiaoController.instance:actId()
end

function GaoSiNiaoRpc:_taskType()
	return GaoSiNiaoController.instance:taskType()
end

function GaoSiNiaoRpc:_isValid(resultCode, msg)
	local activityId = msg.activityId

	if self:_actId() ~= activityId then
		return false
	end

	if resultCode ~= 0 then
		return false
	end

	return true
end

function GaoSiNiaoRpc:sendGetAct210InfoRequest(callback, cbObj)
	return GaoSiNiaoRpc.super.sendGetAct210InfoRequest(self, self:_actId(), callback, cbObj)
end

function GaoSiNiaoRpc:_onReceiveGetAct210InfoReply(resultCode, msg)
	if not self:_isValid(resultCode, msg) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveGetAct210InfoReply(msg)
end

function GaoSiNiaoRpc:sendAct210SaveEpisodeProgressRequest(episodeId, progress, callback, cbObj)
	return GaoSiNiaoRpc.super.sendAct210SaveEpisodeProgressRequest(self, self:_actId(), episodeId, progress, callback, cbObj)
end

function GaoSiNiaoRpc:_onReceiveAct210SaveEpisodeProgressReply(resultCode, msg)
	if not self:_isValid(resultCode, msg) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210SaveEpisodeProgressReply(msg)
end

function GaoSiNiaoRpc:sendAct210FinishEpisodeRequest(episodeId, progress, callback, cbObj)
	return GaoSiNiaoRpc.super.sendAct210FinishEpisodeRequest(self, self:_actId(), episodeId, progress, callback, cbObj)
end

function GaoSiNiaoRpc:_onReceiveAct210FinishEpisodeReply(resultCode, msg)
	if not self:_isValid(resultCode, msg) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210FinishEpisodeReply(msg)
end

function GaoSiNiaoRpc:sendAct210ChooseEpisodeBranchRequest(episodeId, branchId, callback, cbObj)
	return GaoSiNiaoRpc.super.sendAct210ChooseEpisodeBranchRequest(self, self:_actId(), episodeId, branchId, callback, cbObj)
end

function GaoSiNiaoRpc:_onReceiveAct210ChooseEpisodeBranchReply(resultCode, msg)
	if not self:_isValid(resultCode, msg) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210ChooseEpisodeBranchReply(msg)
end

function GaoSiNiaoRpc:_onReceiveAct210EpisodePush(resultCode, msg)
	if not self:_isValid(resultCode, msg) then
		return
	end

	GaoSiNiaoSysModel.instance:onReceiveAct210EpisodePush(msg)
end

GaoSiNiaoRpc.instance = GaoSiNiaoRpc.New()

return GaoSiNiaoRpc
