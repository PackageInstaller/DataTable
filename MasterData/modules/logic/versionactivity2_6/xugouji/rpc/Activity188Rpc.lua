-- chunkname: @modules/logic/versionactivity2_6/xugouji/rpc/Activity188Rpc.lua

module("modules.logic.versionactivity2_6.xugouji.rpc.Activity188Rpc", package.seeall)

local Activity188Rpc = class("Activity188Rpc", BaseRpc)

function Activity188Rpc:sendGet188InfosRequest(activityId, callback, callbackobj)
	local msg = Activity188Module_pb.GetAct188InfoRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity188Rpc:onReceiveGetAct188InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity188Model.instance:onGetActInfoReply(msg.episodes)
	end
end

function Activity188Rpc:sendAct188EnterEpisodeRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity188Module_pb.Act188EnterEpisodeRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity188Rpc:onReceiveAct188EnterEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		local gameInfo = msg.act188Game
		local episodeId = msg.episodeId

		Activity188Model.instance:clearGameInfo()
		Activity188Model.instance:setTurn(true)
		Activity188Model.instance:setCurEpisodeId(episodeId)
		Activity188Model.instance:onAct188GameInfoUpdate(gameInfo)
	end
end

function Activity188Rpc:SetEpisodePushCallback(cb, cbobj)
	self._episodePushCb = cb
	self._episodePushCbObj = cbobj
end

function Activity188Rpc:onReceiveAct188EpisodePush(resultCode, msg)
	if resultCode == 0 then
		local episodeDatas = msg.episodes

		for _, episodeData in ipairs(episodeDatas) do
			local episodeId = episodeData.episodeId
			local finished = episodeData.isFinished

			Activity188Model.instance:onEpisodeInfoUpdate(episodeId, finished)
		end

		if self._episodePushCb then
			self._episodePushCb(self._episodePushCbObj)
		end
	end
end

function Activity188Rpc:sendAct188StoryRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity188Module_pb.Act188StoryRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity188Rpc:onReceiveAct188StoryReply(resultCode, msg)
	if resultCode == 0 then
		local episodeId = msg.episodeId

		Activity188Model.instance:onStoryEpisodeFinish(episodeId)
	end
end

function Activity188Rpc:sendAct188ReverseCardRequest(activityId, episodeId, cardUId, callback, callbackobj)
	local msg = Activity188Module_pb.Act188ReverseCardRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId
	msg.uid = cardUId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity188Rpc:onReceiveAct188ReverseCardReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity188Rpc:onReceiveAct188StepPush(resultCode, msg)
	if resultCode == 0 then
		local steps = msg.steps

		XugoujiGameStepController.instance:insertStepList(steps)
	end
end

Activity188Rpc.instance = Activity188Rpc.New()

return Activity188Rpc
