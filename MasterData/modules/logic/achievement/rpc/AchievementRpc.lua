-- chunkname: @modules/logic/achievement/rpc/AchievementRpc.lua

module("modules.logic.achievement.rpc.AchievementRpc", package.seeall)

local AchievementRpc = class("AchievementRpc", BaseRpc)

function AchievementRpc:sendGetAchievementInfoRequest(callback, callbackObj)
	local req = AchievementModule_pb.GetAchievementInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function AchievementRpc:onReceiveGetAchievementInfoReply(resultCode, msg)
	if resultCode == 0 then
		AchievementModel.instance:initDatas(msg.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function AchievementRpc:onReceiveUpdateAchievementPush(resultCode, msg)
	if resultCode == 0 then
		AchievementModel.instance:updateDatas(msg.infos)
		AchievementToastModel.instance:updateNeedPushToast(msg.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementToastController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function AchievementRpc:sendShowAchievementRequest(idList, groupId, callback, callbackObj)
	local req = AchievementModule_pb.ShowAchievementRequest()

	for i, id in ipairs(idList) do
		req.ids:append(id)
	end

	req.groupId = groupId

	return self:sendMsg(req, callback, callbackObj)
end

function AchievementRpc:onReceiveShowAchievementReply(resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.AchievementSaveSucc)
		AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
		AchievementStatController.instance:onSaveDisplayAchievementsSucc()
	end
end

function AchievementRpc:sendReadNewAchievementRequest(idList, callback, callbackObj)
	local req = AchievementModule_pb.ReadNewAchievementRequest()

	for i, id in ipairs(idList) do
		req.ids:append(id)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function AchievementRpc:onReceiveReadNewAchievementReply(resultCode, msg)
	if resultCode == 0 and AchievementModel.instance:cleanAchievementNew(msg.ids) then
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

AchievementRpc.instance = AchievementRpc.New()

return AchievementRpc
