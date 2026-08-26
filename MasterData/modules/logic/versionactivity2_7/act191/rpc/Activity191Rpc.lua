-- chunkname: @modules/logic/versionactivity2_7/act191/rpc/Activity191Rpc.lua

module("modules.logic.versionactivity2_7.act191.rpc.Activity191Rpc", package.seeall)

local Activity191Rpc = class("Activity191Rpc", BaseRpc)

function Activity191Rpc:sendGetAct191InfoRequest(activityId, callback, callbackObj)
	local req = Activity191Module_pb.GetAct191InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveGetAct191InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local info = msg.info

	Activity191Model.instance:setActInfo(activityId, info)
end

function Activity191Rpc:sendStart191GameRequest(activityId, callback, callbackObj)
	local req = Activity191Module_pb.Start191GameRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveStart191GameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendSelect191InitBuildRequest(activityId, initBuildId, callback, callbackObj)
	local req = Activity191Module_pb.Select191InitBuildRequest()

	req.activityId = activityId
	req.initBuildId = initBuildId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191InitBuildReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendSelect191NodeRequest(activityId, index, callback, callbackObj)
	local req = Activity191Module_pb.Select191NodeRequest()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191NodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendFresh191ShopRequest(activityId, callback, callbackObj)
	local req = Activity191Module_pb.Fresh191ShopRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveFresh191ShopReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local nodeInfo = msg.nodeInfo
	local coin = msg.coin
	local gameMo = Activity191Model.instance:getActInfo(activityId):getGameInfo()

	gameMo.coin = coin

	gameMo:updateCurNodeInfo(nodeInfo)
end

function Activity191Rpc:sendBuyIn191ShopRequest(activityId, index, callback, callbackObj)
	local req = Activity191Module_pb.BuyIn191ShopRequest()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveBuyIn191ShopReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendLeave191ShopRequest(activityId, callback, callbackObj)
	local req = Activity191Module_pb.Leave191ShopRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveLeave191ShopReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendSelect191EnhanceRequest(activityId, index, callback, callbackObj)
	local req = Activity191Module_pb.Select191EnhanceRequest()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191EnhanceReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendFresh191EnhanceRequest(activityId, index, callback, callbackObj)
	local req = Activity191Module_pb.Fresh191EnhanceRequest()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveFresh191EnhanceReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local nodeInfo = msg.nodeInfo
	local gameMo = Activity191Model.instance:getActInfo(activityId):getGameInfo()

	gameMo:updateCurNodeInfo(nodeInfo)
end

function Activity191Rpc:sendGain191RewardEventRequest(activityId, callback, callbackObj)
	local req = Activity191Module_pb.Gain191RewardEventRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveGain191RewardEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameInfo = msg.gameInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:updateGameInfo(gameInfo)
end

function Activity191Rpc:sendChangeAct191TeamRequest(activityId, curTeamIndex, teamInfo, callback, callbackObj)
	local req = Activity191Module_pb.ChangeAct191TeamRequest()

	req.activityId = activityId
	req.curTeamIndex = curTeamIndex
	req.teamInfo.index = teamInfo.index
	req.teamInfo.name = teamInfo.name

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.heroId ~= 0 or heroInfo.itemUid1 ~= 0 then
			table.insert(req.teamInfo.battleHeroInfo, heroInfo)
		end
	end

	for _, subHeroInfo in ipairs(teamInfo.subHeroInfo) do
		if subHeroInfo.heroId ~= 0 then
			table.insert(req.teamInfo.subHeroInfo, subHeroInfo)
		end
	end

	req.teamInfo.auto = teamInfo.auto

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveChangeAct191TeamReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local curTeamIndex = msg.curTeamIndex
	local teamInfo = msg.teamInfo
	local rank = msg.rank
	local gameInfo = Activity191Model.instance:getActInfo(activityId):getGameInfo()

	gameInfo:updateRank(rank)
	gameInfo:updateTeamInfo(curTeamIndex, teamInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateTeamInfo)
end

function Activity191Rpc:sendEndAct191GameRequest(activityId)
	local req = Activity191Module_pb.EndAct191GameRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity191Rpc:onReceiveEndAct191GameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local gameEndInfo = msg.gameEndInfo
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:getGameInfo().state = Activity191Enum.GameState.None

	actInfo:setEndInfo(gameEndInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.EndGame)
end

function Activity191Rpc:onReceiveAct191GameInfoUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local actInfo = Activity191Model.instance:getActInfo(msg.activityId)

		actInfo:updateGameInfo(msg.gameInfo)

		if not actInfo.lastNodeInfo and GameSceneMgr.instance:isFightScene() then
			actInfo:cacheLastNodeInfo(msg.gameInfo)
		end

		Activity191Controller.instance:dispatchEvent(Activity191Event.GameInfoUpdatePush, msg.gameInfo)
	end
end

function Activity191Rpc:onReceiveAct191TriggerEffectPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local actInfo = Activity191Model.instance:getActInfo(activityId)

	actInfo:triggerEffectPush(msg)
end

function Activity191Rpc:sendSelect191ReplaceEventRequest(activityId, itemUIds, callback, callbackObj)
	local req = Activity191Module_pb.Select191ReplaceEventRequest()

	req.activityId = activityId

	for _, id in ipairs(itemUIds) do
		table.insert(req.itemUid, id)
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191ReplaceEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actInfo = Activity191Model.instance:getActInfo(msg.activityId)

	actInfo:updateGameInfo(msg.gameInfo)
end

function Activity191Rpc:sendEnd191ReplaceEventRequest(activityId)
	local req = Activity191Module_pb.End191ReplaceEventRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity191Rpc:onReceiveEnd191ReplaceEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actInfo = Activity191Model.instance:getActInfo(msg.activityId)

	actInfo:updateGameInfo(msg.gameInfo)
	Activity191Controller.instance:nextStep()
end

function Activity191Rpc:sendSelect191UpgradeEventRequest(activityId, itemUIds, callback, callbackObj)
	local req = Activity191Module_pb.Select191UpgradeEventRequest()

	req.activityId = activityId

	for _, id in ipairs(itemUIds) do
		table.insert(req.itemUid, id)
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191UpgradeEventReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actInfo = Activity191Model.instance:getActInfo(msg.activityId)

	actInfo:updateGameInfo(msg.gameInfo)
end

function Activity191Rpc:sendSelect191UseHeroFacetsIdRequest(activityId, roleId, facetsId, callback, callbackObj)
	local req = Activity191Module_pb.Select191UseHeroFacetsIdRequest()

	req.activityId = activityId
	req.roleId = roleId
	req.facetsId = facetsId

	self:sendMsg(req, callback, callbackObj)
end

function Activity191Rpc:onReceiveSelect191UseHeroFacetsIdReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local gameInfo = Activity191Model.instance:getActInfo(msg.activityId):getGameInfo()

	gameInfo:updateStoneId(msg.roleId, msg.facetsId)
end

Activity191Rpc.instance = Activity191Rpc.New()

return Activity191Rpc
