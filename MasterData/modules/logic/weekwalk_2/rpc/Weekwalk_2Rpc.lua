-- chunkname: @modules/logic/weekwalk_2/rpc/Weekwalk_2Rpc.lua

module("modules.logic.weekwalk_2.rpc.Weekwalk_2Rpc", package.seeall)

local Weekwalk_2Rpc = class("Weekwalk_2Rpc", BaseRpc)

function Weekwalk_2Rpc:sendWeekwalkVer2GetInfoRequest(callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2GetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	WeekWalk_2Model.instance:initInfo(info)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetInfo)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function Weekwalk_2Rpc:sendWeekwalkVer2HeroRecommendRequest(elementId, layerId, callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2HeroRecommendRequest()

	req.elementId = elementId
	req.layerId = layerId

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2HeroRecommendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Weekwalk_2Rpc:sendWeekwalkVer2ResetLayerRequest(layerId, battleId, callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2ResetLayerRequest()

	req.layerId = layerId
	req.battleId = battleId

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2ResetLayerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerInfo = msg.layerInfo

	WeekWalk_2Model.instance:getInfo():setLayerInfo(layerInfo)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkResetLayer)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function Weekwalk_2Rpc:sendWeekwalkVer2ChangeHeroGroupSelectRequest(layerId, battleId, select, callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2ChangeHeroGroupSelectRequest()

	req.layerId = layerId
	req.battleId = battleId
	req.select = select

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2ChangeHeroGroupSelectReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local layerId = msg.layerId
	local battleId = msg.battleId
	local select = msg.select
	local battleInfo = WeekWalk_2Model.instance:getBattleInfo(layerId, battleId)

	if battleInfo then
		battleInfo.heroGroupSelect = select
	end
end

function Weekwalk_2Rpc:sendWeekwalkVer2ChooseSkillRequest(no, skillIds, callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2ChooseSkillRequest()

	req.no = no

	if skillIds then
		for i, v in ipairs(skillIds) do
			table.insert(req.skillIds, v)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2ChooseSkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local no = msg.no
	local skillIds = msg.skillIds
	local info = WeekWalk_2Model.instance:getInfo()

	if info then
		info:setHeroGroupSkill(no, skillIds)
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetupReply)
	end
end

function Weekwalk_2Rpc:sendWeekwalkVer2GetSettleInfoRequest(callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2GetSettleInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2GetSettleInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local settleInfo = msg.settleInfo

	WeekWalk_2Model.instance:initSettleInfo(settleInfo)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartResultView()
end

function Weekwalk_2Rpc:sendWeekwalkVer2MarkPreSettleRequest(callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2MarkPreSettleRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2MarkPreSettleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Weekwalk_2Rpc:sendWeekwalkVer2MarkPopRuleRequest(callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2MarkPopRuleRequest()

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2MarkPopRuleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Weekwalk_2Rpc:sendWeekwalkVer2MarkShowFinishedRequest(layerId, callback, callbackObj)
	local req = WeekwalkVer2Module_pb.WeekwalkVer2MarkShowFinishedRequest()

	req.layerId = layerId

	self:sendMsg(req, callback, callbackObj)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2MarkShowFinishedReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2InfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = msg.info

	WeekWalk_2Model.instance:updateInfo(info)
	WeekWalk_2Model.instance:clearSettleInfo()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoUpdate)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2SettleInfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local settleInfo = msg.settleInfo

	WeekWalk_2Model.instance:initSettleInfo(settleInfo)
end

function Weekwalk_2Rpc:onReceiveWeekwalkVer2FightSettlePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local result = msg.result
	local cupInfos = msg.cupInfos

	WeekWalk_2Model.instance:initFightSettleInfo(result, cupInfos)
end

Weekwalk_2Rpc.instance = Weekwalk_2Rpc.New()

return Weekwalk_2Rpc
