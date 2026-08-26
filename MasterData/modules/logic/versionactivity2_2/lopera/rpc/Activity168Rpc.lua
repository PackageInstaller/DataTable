-- chunkname: @modules/logic/versionactivity2_2/lopera/rpc/Activity168Rpc.lua

module("modules.logic.versionactivity2_2.lopera.rpc.Activity168Rpc", package.seeall)

local Activity168Rpc = class("Activity168Rpc", BaseRpc)

function Activity168Rpc:sendGet168InfosRequest(activityId, callback, callbackobj)
	local msg = Activity168Module_pb.Get168InfosRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveGet168InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:onGetActInfoReply(msg.act168Episodes)
	end
end

function Activity168Rpc:sendAct168EnterEpisodeRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity168Module_pb.Act168EnterEpisodeRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168EnterEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:setCurGameState(msg.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(msg.act168Episode.act168Game.power)
		Activity168Model.instance:setCurEpisodeId(msg.act168Episode.episodeId)

		local episodeId = Activity168Model.instance:getCurEpisodeId()

		Activity168Model.instance:clearEpisodeItemInfo(episodeId)

		if msg.act168Episode.act168Game then
			Activity168Model.instance:onItemInfoUpdate(episodeId, msg.act168Episode.act168Game.act168Items)
		end
	end
end

function Activity168Rpc:SetEpisodePushCallback(cb, cbobj)
	self._episodePushCb = cb
	self.__episodePushCbObj = cbobj
end

function Activity168Rpc:onReceiveAct168EpisodePush(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:setCurGameState(msg.act168Episode.act168Game)
		Activity168Model.instance:setCurActionPoint(msg.act168Episode.act168Game.power)
		Activity168Model.instance:onEpisodeInfoUpdate(msg.act168Episode)

		if self._episodePushCb then
			self._episodePushCb(self.__episodePushCbObj)
		end
	end
end

function Activity168Rpc:sendAct168StoryRequest(activityId, callback, callbackobj)
	local msg = Activity168Module_pb.Act168StoryRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168StoryReply(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:onEpisodeInfoUpdate(msg.act168Episode)
	end
end

function Activity168Rpc:sendStartAct168BattleRequest(activityId, callback, callbackobj)
	local msg = Activity168Module_pb.StartAct168BattleRequest()

	msg.activityId = activityId

	local fightParam = FightModel.instance:getFightParam()

	DungeonRpc.instance:packStartDungeonRequest(msg.startDungeonRequest, fightParam.chapterId, fightParam.episodeId, fightParam, fightParam.multiplication, nil, nil, false)
	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveStartAct168BattleReply(resultCode, msg)
	if resultCode == 0 then
		local battleEpisodeId = Activity168Model.instance:getCurBattleEpisodeId()
		local configId = Season166HeroGroupModel.instance:getEpisodeConfigId(battleEpisodeId)
		local co = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

		if co and DungeonModel.isBattleEpisode(co) then
			DungeonFightController.instance:onReceiveStartDungeonReply(resultCode, msg.startDungeonReply)
		end
	end
end

function Activity168Rpc:onReceiveAct168BattleFinishPush(resultCode, msg)
	if resultCode == 0 then
		local episodeId = Activity168Model.instance:getCurEpisodeId()
		local actId = Activity168Model.instance:getCurActId()
		local episodeCfg = Activity168Config.instance:getEpisodeCfg(actId, episodeId)

		if episodeCfg.storyClear ~= 0 then
			self:sendAct168StoryRequest(actId)
		end
	end
end

function Activity168Rpc:sendAct168GameMoveRequest(activityId, dir, callback, callbackobj)
	local msg = Activity168Module_pb.Act168GameMoveRequest()

	msg.activityId = activityId
	msg.dir = dir

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168GameMoveReply(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:setCurActionPoint(msg.act168Game.power)
		Activity168Model.instance:setCurGameState(msg.act168Game)
	end
end

function Activity168Rpc:sendAct168GameSelectOptionRequest(activityId, optionId, callback, callbackobj)
	local msg = Activity168Module_pb.Act168GameSelectOptionRequest()

	msg.activityId = activityId
	msg.option = optionId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168GameSelectOptionReply(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:setCurActionPoint(msg.act168Game.power)
		Activity168Model.instance:setCurGameState(msg.act168Game)
	end
end

function Activity168Rpc:sendAct168GameComposeItemRequest(activityId, type, callback, callbackobj)
	local msg = Activity168Module_pb.Act168GameComposeItemRequest()

	msg.activityId = activityId
	msg.composeType = type

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168GameComposeItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity168Rpc:onReceiveAct168GameItemChangePush(resultCode, msg)
	if resultCode == 0 then
		local episodeId = Activity168Model.instance:getCurEpisodeId()

		Activity168Model.instance:onItemInfoUpdate(episodeId, msg.updateAct168Items, msg.deleteAct168Items, true)
	end
end

function Activity168Rpc:sendAct168GameSettleRequest(activityId, callback, callbackobj)
	local msg = Activity168Module_pb.Act168GameSettleRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity168Rpc:onReceiveAct168GameSettleReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity168Rpc:SetGameSettlePushCallback(cb, cbobj)
	self._onGameSettlePush = cb
	self._settlePushCallbackObj = cbobj
end

function Activity168Rpc:onReceiveAct168GameSettlePush(resultCode, msg)
	if resultCode == 0 then
		Activity168Model.instance:setCurActionPoint(msg.power)

		local result = {}

		result.settleReason = msg.settleReason
		result.episodeId = msg.episodeId
		result.power = msg.power
		result.cellCount = msg.cellCount
		result.totalItems = msg.totalAct168Items

		if self._onGameSettlePush then
			self._onGameSettlePush(self._settlePushCallbackObj, result)
		end
	end
end

Activity168Rpc.instance = Activity168Rpc.New()

return Activity168Rpc
