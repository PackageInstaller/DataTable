-- chunkname: @modules/logic/versionactivity1_3/act126/rpc/Activity126Rpc.lua

module("modules.logic.versionactivity1_3.act126.rpc.Activity126Rpc", package.seeall)

local Activity126Rpc = class("Activity126Rpc", BaseRpc)

function Activity126Rpc:sendGet126InfosRequest(activityId)
	local req = Activity126Module_pb.Get126InfosRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveGet126InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(msg)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGet126InfosReply)
end

function Activity126Rpc:sendUpdateProgressRequest(activityId, progressStr, activeStarId)
	local req = Activity126Module_pb.UpdateProgressRequest()

	req.activityId = activityId
	req.progressStr = progressStr

	for i, v in ipairs(activeStarId) do
		table.insert(req.activeStarId, v)
	end

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveUpdateProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity126Model.instance:updateStarProgress(msg)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply)
end

function Activity126Rpc:sendResetProgressRequest(activityId)
	local req = Activity126Module_pb.ResetProgressRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveResetProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity126Controller.instance:dispatchEvent(Activity126Event.onBeforeResetProgressReply)
	Activity126Model.instance:updateStarProgress(msg)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply, {
		fromReset = true
	})
	Activity126Controller.instance:dispatchEvent(Activity126Event.onResetProgressReply)
end

function Activity126Rpc:sendGetProgressRewardRequest(activityId, getRewardId)
	local req = Activity126Module_pb.GetProgressRewardRequest()

	req.activityId = activityId
	req.getRewardId = getRewardId

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveGetProgressRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity126Model.instance:updateGetProgressBonus(msg)
end

function Activity126Rpc:sendHoroscopeRequest(activityId, id)
	local req = Activity126Module_pb.HoroscopeRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveHoroscopeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local horoscope = msg.horoscope

	Activity126Model.instance:updateHoroscope(horoscope)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onHoroscopeReply)
end

function Activity126Rpc:sendGetHoroscopeRequest(activityId, id)
	local req = Activity126Module_pb.GetHoroscopeRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveGetHoroscopeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local getHoroscope = msg.getHoroscope

	Activity126Model.instance:updateGetHoroscope(getHoroscope)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGetHoroscopeReply)
end

function Activity126Rpc:sendUnlockBuffRequest(activityId, unlockId)
	local req = Activity126Module_pb.UnlockBuffRequest()

	req.activityId = activityId
	req.unlockId = unlockId

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveUnlockBuffReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Stat1_3Controller.instance:trackUnlockBuff(msg)
	Activity126Model.instance:updateBuffInfo(msg)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUnlockBuffReply)
end

function Activity126Rpc:onReceiveAct126InfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(msg)
end

function Activity126Rpc:onReceiveExchangeStarPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local co = MaterialRpc.receiveMaterial(msg)

	if #co > 0 then
		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			VersionActivity1_3AstrologyModel.instance:setExchangeList(co)

			return
		end

		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(co)
	end
end

function Activity126Rpc:sendEnterFightRequest(activityId, dreamlandCard, episodeId)
	local req = Activity126Module_pb.EnterFightRequest()

	req.activityId = activityId
	req.dreamlandCard = dreamlandCard
	req.episodeId = episodeId

	self:sendMsg(req)
end

function Activity126Rpc:onReceiveEnterFightReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

Activity126Rpc.instance = Activity126Rpc.New()

return Activity126Rpc
