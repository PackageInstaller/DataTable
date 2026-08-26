-- chunkname: @modules/logic/versionactivity2_3/act174/rpc/Activity174Rpc.lua

module("modules.logic.versionactivity2_3.act174.rpc.Activity174Rpc", package.seeall)

local Activity174Rpc = class("Activity174Rpc", BaseRpc)

function Activity174Rpc:sendGetAct174InfoRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.GetAct174InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveGetAct174InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:setActInfo(msg.activityId, msg.info)
	end
end

function Activity174Rpc:sendStart174GameRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.Start174GameRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveStart174GameReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
	end
end

function Activity174Rpc:sendFresh174ShopRequest(actId)
	local req = Activity174Module_pb.Fresh174ShopRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity174Rpc:onReceiveFresh174ShopReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateShopInfo(msg.activityId, msg.shopInfo, msg.coin)
		Activity174Controller.instance:dispatchEvent(Activity174Event.FreshShopReply)
	end
end

function Activity174Rpc:sendBuyIn174ShopRequest(actId, index, callback, callbackObj)
	local req = Activity174Module_pb.BuyIn174ShopRequest()

	req.activityId = actId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveBuyIn174ShopReply(resultCode, msg)
	if resultCode == 0 then
		local actInfo = Activity174Model.instance:getActInfo(msg.activityId)

		actInfo:getGameInfo():buyInShopReply(msg.gameInfo)
		Activity174Controller.instance:dispatchEvent(Activity174Event.BuyInShopReply)
	end
end

function Activity174Rpc:sendChangeAct174TeamRequest(actId, teamInfo)
	local req = Activity174Module_pb.ChangeAct174TeamRequest()

	req.activityId = actId

	for _, info in ipairs(teamInfo) do
		local teamSvrData = Activity174Module_pb.Act174TeamInfo()

		teamSvrData.index = info.index

		for _, heroInfo in ipairs(info.battleHeroInfo) do
			if heroInfo.heroId then
				local heroSvrData = Activity174Module_pb.Act174BattleHero()

				heroSvrData.index = heroInfo.index
				heroSvrData.heroId = heroInfo.heroId
				heroSvrData.itemId = heroInfo.itemId or 0
				heroSvrData.priorSkill = heroInfo.priorSkill or 0

				table.insert(teamSvrData.battleHeroInfo, heroSvrData)
			end
		end

		table.insert(req.teamInfo, teamSvrData)
	end

	self:sendMsg(req)
end

function Activity174Rpc:onReceiveChangeAct174TeamReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateTeamInfo(msg.activityId, msg.teamInfo)
	end
end

function Activity174Rpc:sendSwitchAct174TeamRequest(actId, from, to, callback, callbackObj)
	self.from = from
	self.to = to

	local req = Activity174Module_pb.SwitchAct174TeamRequest()

	req.activityId = actId
	req.beforeIndex = from
	req.afterIndex = to

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveSwitchAct174TeamReply(resultCode, msg)
	if resultCode == 0 then
		if self.from then
			local actMo = Activity174Model.instance:getActInfo(msg.activityId)

			actMo:getGameInfo():exchangeTempCollection(self.from, self.to)

			self.from = nil
			self.to = nil
		end

		Activity174Model.instance:updateTeamInfo(msg.activityId, msg.teamInfo)
	end
end

function Activity174Rpc:sendSelectAct174ForceBagRequest(actId, index, callback, callbackObj)
	local req = Activity174Module_pb.SelectAct174ForceBagRequest()

	req.activityId = actId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveSelectAct174ForceBagReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo, true)
	end
end

function Activity174Rpc:sendStartAct174FightMatchRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.StartAct174FightMatchRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveStartAct174FightMatchReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
	end
end

function Activity174Rpc:sendBetHpBeforeAct174FightRequest(actId, isBet, callback, callbackObj)
	local req = Activity174Module_pb.BetHpBeforeAct174FightRequest()

	req.activityId = actId
	req.bet = isBet

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveBetHpBeforeAct174FightReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateIsBet(msg.activityId, msg.bet)
	end
end

function Activity174Rpc:sendStartAct174FightRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.StartAct174FightRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveStartAct174FightReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
	end
end

function Activity174Rpc:sendEnterNextAct174FightRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.EnterNextAct174FightRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveEnterNextAct174FightReply(resultCode, msg)
	if resultCode == 0 then
		if msg.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(msg.activityId, msg.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
		end
	end
end

function Activity174Rpc:sendEndAct174GameRequest(actId, callback, callbackObj)
	local req = Activity174Module_pb.EndAct174GameRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveEndAct174GameReply(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:endGameReply(msg.activityId, msg.gameEndInfo)
	end
end

function Activity174Rpc:sendEnterEndLessAct174FightRequest(actId, enter, level, callback, callbackObj)
	local req = Activity174Module_pb.EnterEndLessAct174FightRequest()

	req.activityId = actId
	req.enter = enter
	req.level = level

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveEnterEndLessAct174FightReply(resultCode, msg)
	if resultCode == 0 then
		if msg.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(msg.activityId, msg.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
		end
	end
end

function Activity174Rpc:onReceiveAct174GameInfoUpdatePush(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo, true)
	end
end

function Activity174Rpc:onReceiveAct174TriggerEffectPush(resultCode, msg)
	if resultCode == 0 then
		Activity174Model.instance:triggerEffectPush(msg.activityId, msg.effectId, msg.param)
	end
end

function Activity174Rpc:sendViewFightAct174Request(index, round)
	local req = Activity174Module_pb.ViewFightAct174Request()

	req.activityId = Activity174Model.instance:getCurActId()
	req.index = index
	req.round = round

	self:sendMsg(req)
end

function Activity174Rpc:onReceiveViewFightAct174Reply(resultCode, msg)
	if resultCode == 0 then
		FightDataModel.instance.douQuQuMgr:cacheFightProto(msg)
		FightMsgMgr.sendMsg(FightMsgId.FightAct174Reply, msg)
	end
end

function Activity174Rpc:onReceiveAct174FightRoundInfo(resultCode, msg)
	FightMgr.instance:playGMDouQuQu(msg)
end

function Activity174Rpc:sendChangeSeasonEndAct174Request(actId, callback, callbackObj)
	local req = Activity174Module_pb.ChangeSeasonEndAct174Request()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity174Rpc:onReceiveChangeSeasonEndAct174Reply(resultCode, msg)
	if resultCode == 0 then
		if msg.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Model.instance:endGameReply(msg.activityId, msg.gameEndInfo)
		else
			Activity174Model.instance:updateGameInfo(msg.activityId, msg.gameInfo)
		end
	end
end

Activity174Rpc.instance = Activity174Rpc.New()

return Activity174Rpc
