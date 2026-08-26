-- chunkname: @modules/logic/rouge/rpc/RougeOutsideRpc.lua

module("modules.logic.rouge.rpc.RougeOutsideRpc", package.seeall)

local RougeOutsideRpc = class("RougeOutsideRpc", BaseRpc)

function RougeOutsideRpc:sendGetRougeOutSideInfoRequest(season, callback, cbObj)
	local req = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

	req.season = season

	return self:sendMsg(req, callback, cbObj)
end

function RougeOutsideRpc:onReceiveGetRougeOutsideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeOutsideModel.instance:onReceiveGetRougeOutsideInfoReply(msg)
	RougeTalentModel.instance:setOutsideInfo(msg.rougeInfo)
	RougeRewardModel.instance:setReward(msg.rougeInfo)
	RougeDLCModel101.instance:initLimiterInfo(msg.rougeInfo)
end

function RougeOutsideRpc:sendRougeActiveGeniusRequest(season, geniusId)
	local req = RougeOutsideModule_pb.RougeActiveGeniusRequest()

	req.season = season
	req.geniusId = geniusId

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeActiveGeniusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeTalentModel.instance:updateGeniusIDs(msg)
end

function RougeOutsideRpc:onReceiveRougeUpdateGeniusPointPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeTalentModel.instance:setOutsideInfo(msg)
end

function RougeOutsideRpc:sendRougeReceivePointBonusRequest(season, bonusId)
	local req = RougeOutsideModule_pb.RougeReceivePointBonusRequest()

	req.season = season
	req.bonusId = bonusId

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeReceivePointBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.bonusId and msg.bonusStage then
		RougeRewardModel.instance:updateReward(msg.bonusStage)
		RougeController.instance:dispatchEvent(RougeEvent.OnGetRougeReward, msg.bonusId)
	else
		RougeRewardModel.instance:setReward(msg)
	end
end

function RougeOutsideRpc:onReceiveRougeUpdatePointPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeRewardModel.instance:setReward(msg)
end

function RougeOutsideRpc:sendRougeGetUnlockCollectionsRequest(season, callback, cbObj)
	local req = RougeOutsideModule_pb.RougeGetUnlockCollectionsRequest()

	req.season = season

	self:sendMsg(req, callback, cbObj)
end

function RougeOutsideRpc:onReceiveRougeGetUnlockCollectionsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local unlockCollectionIds = msg.unlockCollectionIds

	RougeFavoriteModel.instance:initUnlockCollectionIds(unlockCollectionIds)
end

function RougeOutsideRpc:sendRougeGetNewReddotInfoRequest(season)
	local req = RougeOutsideModule_pb.RougeGetNewReddotInfoRequest()

	req.season = season

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeGetNewReddotInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local newReddots = msg.newReddots

	RougeFavoriteModel.instance:initReddots(newReddots)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function RougeOutsideRpc:sendRougeMarkNewReddotRequest(season, type, id, callback, cbObj)
	local req = RougeOutsideModule_pb.RougeMarkNewReddotRequest()

	req.season = season
	req.type = type
	req.id = id

	self:sendMsg(req, callback, cbObj)

	if id == 0 then
		RougeFavoriteModel.instance:deleteReddotId(type, id)
		RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
	end
end

function RougeOutsideRpc:onReceiveRougeMarkNewReddotReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local type = msg.type
	local id = msg.id

	if id == 0 then
		return
	end

	RougeFavoriteModel.instance:deleteReddotId(type, id)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function RougeOutsideRpc:sendRougeMarkGeniusNewStageRequest(season)
	local req = RougeOutsideModule_pb.RougeMarkGeniusNewStageRequest()

	req.season = season

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeMarkGeniusNewStageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeTalentModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function RougeOutsideRpc:sendRougeMarkBonusNewStageRequest(season)
	local req = RougeOutsideModule_pb.RougeMarkBonusNewStageRequest()

	req.season = season

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeMarkBonusNewStageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeRewardModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function RougeOutsideRpc:onReceiveRougeReddotUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeOutsideRpc:sendRougeUnlockStoryRequest(season, storyId)
	local req = RougeOutsideModule_pb.RougeUnlockStoryRequest()

	req.season = season
	req.storyId = storyId

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeUnlockStoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RougeOutsideRpc:sendRougeLimiterSettingSaveRequest(season, limiterClientInfo)
	local req = RougeOutsideModule_pb.RougeLimiterSettingSaveRequest()

	req.season = season

	if limiterClientInfo then
		local limitDebuffIds = limiterClientInfo:getLimitIds()

		for _, limitId in ipairs(limitDebuffIds) do
			req.clientNO.limitIds:append(limitId)
		end

		local limitBuffIds = limiterClientInfo:getLimitBuffIds()

		for _, limitBuffId in ipairs(limitBuffIds) do
			req.clientNO.limitBuffIds:append(limitBuffId)
		end
	end

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeLimiterSettingSaveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local clientNO = msg.clientNO

	RougeDLCModel101.instance:onGetLimiterClientMo(clientNO)
end

function RougeOutsideRpc:sendRougeDLCSettingSaveRequest(season, dlcVersionIds)
	local req = RougeOutsideModule_pb.RougeDLCSettingSaveRequest()

	req.season = season

	for _, v in ipairs(dlcVersionIds or {}) do
		req.dlcVersionIds:append(v)
	end

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeDLCSettingSaveReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local dlcVersionIds = msg.dlcVersionIds
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	gameRecordInfo:_updateVersionIds(dlcVersionIds)
	RougeDLCController.instance:dispatchEvent(RougeEvent.OnGetVersionInfo)
end

function RougeOutsideRpc:sendRougeLimiterUnlockBuffRequest(season, limitBuffId)
	local req = RougeOutsideModule_pb.RougeLimiterUnlockBuffRequest()

	req.season = season
	req.limitBuffId = limitBuffId

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeLimiterUnlockBuffReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local limitBuffId = msg.limitBuffId

	RougeDLCController101.instance:onGetUnlockLimiterBuffInfo(limitBuffId)
end

function RougeOutsideRpc:sendRougeLimiterSpeedUpBuffCdRequest(season, limitBuffId)
	local req = RougeOutsideModule_pb.RougeLimiterSpeedUpBuffCdRequest()

	req.season = season
	req.limitBuffId = limitBuffId

	self:sendMsg(req)
end

function RougeOutsideRpc:onReceiveRougeLimiterSpeedUpBuffCdReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local limitBuffId = msg.limitBuffId

	RougeDLCController101.instance:onGetSpeedupLimiterBuffInfo(limitBuffId)
end

RougeOutsideRpc.instance = RougeOutsideRpc.New()

return RougeOutsideRpc
