-- chunkname: @modules/logic/weekwalk/rpc/WeekwalkRpc.lua

module("modules.logic.weekwalk.rpc.WeekwalkRpc", package.seeall)

local WeekwalkRpc = class("WeekwalkRpc", BaseRpc)

function WeekwalkRpc:sendGetWeekwalkInfoRequest(callback, callbackObj)
	local req = WeekwalkModule_pb.GetWeekwalkInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function WeekwalkRpc:onReceiveGetWeekwalkInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	WeekWalkModel.instance:initInfo(info, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetInfo)
end

function WeekwalkRpc:sendBeforeStartWeekwalkBattleRequest(elementId, layerId, callback, callbackObj)
	self._isRestar = callback

	local req = WeekwalkModule_pb.BeforeStartWeekwalkBattleRequest()

	req.elementId = elementId
	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req, callback, callbackObj)
end

function WeekwalkRpc:onReceiveBeforeStartWeekwalkBattleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.elementId

	if self._isRestar then
		self._isRestar = nil

		return
	end

	WeekWalkController.instance:enterWeekwalkFight(elementId)
end

function WeekwalkRpc:sendWeekwalkGeneralRequest(elementId, layerId)
	local req = WeekwalkModule_pb.WeekwalkGeneralRequest()

	req.elementId = elementId
	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveWeekwalkGeneralReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local elementId = msg.elementId
	local layerId = msg.layerId
	local mapInfo = WeekWalkModel.instance:getMapInfo(layerId)
	local elementInfo = mapInfo and mapInfo:getElementInfo(elementId)

	if elementInfo then
		elementInfo.isFinish = true
	end
end

function WeekwalkRpc:onReceiveWeekwalkInfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	WeekWalkModel.instance:updateInfo(info)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkInfoUpdate)
end

function WeekwalkRpc:sendWeekwalkDialogRequest(elementId, option, layerId)
	local req = WeekwalkModule_pb.WeekwalkDialogRequest()

	req.elementId = elementId
	req.option = option
	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveWeekwalkDialogReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendWeekwalkHeroRecommendRequest(elementId, callback, callbackObj)
	local req = WeekwalkModule_pb.WeekwalkHeroRecommendRequest()

	req.elementId = elementId
	req.layerId = WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req, callback, callbackObj)
end

function WeekwalkRpc:onReceiveWeekwalkHeroRecommendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendWeekwalkDialogHistoryRequest(elementId, historylist, layerId)
	local req = WeekwalkModule_pb.WeekwalkDialogHistoryRequest()

	req.elementId = elementId
	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	for i, v in ipairs(historylist) do
		table.insert(req.historylist, v)
	end

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveWeekwalkDialogHistoryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendResetLayerRequest(layerId, battleId, callback, callbackObj)
	local req = WeekwalkModule_pb.ResetLayerRequest()

	req.layerId = layerId
	req.battleId = battleId

	return self:sendMsg(req, callback, callbackObj)
end

function WeekwalkRpc:onReceiveResetLayerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	WeekWalkModel.instance:initInfo(info, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkResetLayer)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function WeekwalkRpc:sendMarkShowBuffRequest(layerId)
	local req = WeekwalkModule_pb.MarkShowBuffRequest()

	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveMarkShowBuffReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerId = msg.layerId
	local mapInfo = WeekWalkModel.instance:getMapInfo(layerId)

	mapInfo.isShowBuff = false
end

function WeekwalkRpc:sendMarkShowFinishedRequest(layerId)
	local req = WeekwalkModule_pb.MarkShowFinishedRequest()

	req.layerId = layerId or WeekWalkModel.instance:getCurMapId()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveMarkShowFinishedReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerId = msg.layerId
	local mapInfo = WeekWalkModel.instance:getMapInfo(layerId)

	mapInfo.isShowFinished = false
end

function WeekwalkRpc:sendSelectNotCdHeroRequest(herolist)
	local req = WeekwalkModule_pb.SelectNotCdHeroRequest()

	req.layerId = WeekWalkModel.instance:getCurMapId()

	for i, v in ipairs(herolist) do
		table.insert(req.heroId, v)
	end

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveSelectNotCdHeroReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerId = msg.layerId
	local heroId = msg.heroId
	local mapInfo = WeekWalkModel.instance:getMapInfo(layerId)

	mapInfo:clearHeroCd(heroId)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSelectNotCdHeroReply)
end

function WeekwalkRpc:sendMarkPopDeepRuleRequest()
	local req = WeekwalkModule_pb.MarkPopDeepRuleRequest()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveMarkPopDeepRuleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendMarkPopShallowSettleRequest()
	local req = WeekwalkModule_pb.MarkPopShallowSettleRequest()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveMarkPopShallowSettleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendMarkPopDeepSettleRequest()
	local req = WeekwalkModule_pb.MarkPopDeepSettleRequest()

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveMarkPopDeepSettleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function WeekwalkRpc:sendChangeWeekwalkHeroGroupSelectRequest(layerId, battleId, select)
	local req = WeekwalkModule_pb.ChangeWeekwalkHeroGroupSelectRequest()

	req.layerId = layerId
	req.battleId = battleId
	req.select = select

	self:sendMsg(req)
end

function WeekwalkRpc:onReceiveChangeWeekwalkHeroGroupSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerId = msg.layerId
	local battleId = msg.battleId
	local select = msg.select
	local battleInfo = WeekWalkModel.instance:getBattleInfo(layerId, battleId)

	if battleInfo then
		battleInfo.heroGroupSelect = select
	end
end

WeekwalkRpc.instance = WeekwalkRpc.New()

return WeekwalkRpc
