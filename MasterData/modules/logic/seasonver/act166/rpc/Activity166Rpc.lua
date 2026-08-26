-- chunkname: @modules/logic/seasonver/act166/rpc/Activity166Rpc.lua

module("modules.logic.seasonver.act166.rpc.Activity166Rpc", package.seeall)

local Activity166Rpc = class("Activity166Rpc", BaseRpc)

function Activity166Rpc:sendGet166InfosRequest(activityId, callback, callbackObj)
	local req = Activity166Module_pb.Get166InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity166Rpc:onReceiveGet166InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Season166Model.instance:setActInfo(msg)
end

function Activity166Rpc:sendStartAct166BattleRequest(activityId, episodeType, configId, talentId, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
	local req = Activity166Module_pb.StartAct166BattleRequest()

	req.activityId = activityId
	req.episodeType = episodeType
	req.id = configId
	req.talentId = talentId

	Season166HeroGroupUtils.buildFightGroupAssistHero(Season166HeroGroupModel.instance.heroGroupType, req.startDungeonRequest.fightGroup)
	DungeonRpc.instance:packStartDungeonRequest(req.startDungeonRequest, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart)

	return self:sendMsg(req, callback, callbackObj)
end

function Activity166Rpc:onReceiveStartAct166BattleReply(resultCode, msg)
	if resultCode == 0 then
		local battleContext = Season166Model.instance:getBattleContext()
		local configId = Season166HeroGroupModel.instance:getEpisodeConfigId(battleContext.episodeId)

		if battleContext.actId == msg.activityId and configId == msg.id and battleContext.episodeType == msg.episodeType then
			local co = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

			if co and DungeonModel.isBattleEpisode(co) then
				DungeonFightController.instance:onReceiveStartDungeonReply(resultCode, msg.startDungeonReply)
			end
		end
	else
		Season166Controller.instance:dispatchEvent(Season166Event.StartFightFailed)
	end
end

function Activity166Rpc:sendAct166AnalyInfoRequest(activityId, infoId, callback, callbackObj)
	local req = Activity166Module_pb.Act166AnalyInfoRequest()

	req.activityId = activityId
	req.infoId = infoId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity166Rpc:onReceiveAct166AnalyInfoReply(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveAnalyInfo(msg)
		Season166Controller.instance:dispatchEvent(Season166Event.OnAnalyInfoSuccess, msg)
	end
end

function Activity166Rpc:sendAct166ReceiveInformationBonusRequest(activityId, callback, callbackObj)
	local req = Activity166Module_pb.Act166ReceiveInformationBonusRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity166Rpc:onReceiveAct166ReceiveInformationBonusReply(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveInformationBonus(msg)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInformationBonus)
	end
end

function Activity166Rpc:sendAct166ReceiveInfoBonusRequest(activityId, infoId, callback, callbackObj)
	local req = Activity166Module_pb.Act166ReceiveInfoBonusRequest()

	req.activityId = activityId
	req.infoId = infoId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity166Rpc:onReceiveAct166ReceiveInfoBonusReply(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveInfoBonus(msg)
		Season166Controller.instance:dispatchEvent(Season166Event.OnGetInfoBonus)
	end
end

function Activity166Rpc:onReceiveAct166InfoPush(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveUpdateInfos(msg)
		Season166Controller.instance:dispatchEvent(Season166Event.OnInformationUpdate)
	end
end

function Activity166Rpc:SendAct166SetTalentSkillRequest(activityId, talentId, skillIds)
	local req = Activity166Module_pb.Act166SetTalentSkillRequest()

	req.activityId = activityId
	req.talentId = talentId

	for _, skillId in ipairs(skillIds) do
		table.insert(req.skillIds, skillId)
	end

	self:sendMsg(req)
end

function Activity166Rpc:onReceiveAct166SetTalentSkillReply(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveSetTalentSkill(msg)
	end
end

function Activity166Rpc:onReceiveAct166TalentPush(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveAct166TalentPush(msg)
		Season166Controller.instance:showToast(Season166Enum.ToastType.Talent)
	end
end

function Activity166Rpc:sendAct166EnterBaseRequest(activityId, baseId, callback, callbackObj)
	local req = Activity166Module_pb.Act166EnterBaseRequest()

	req.activityId = activityId
	req.baseId = baseId

	self:sendMsg(req)
end

function Activity166Rpc:onReceiveAct166EnterBaseReply(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveAct166EnterBaseReply(msg)
	end
end

function Activity166Rpc:onReceiveAct166BattleFinishPush(resultCode, msg)
	if resultCode == 0 then
		Season166Model.instance:onReceiveBattleFinishPush(msg)
	end
end

Activity166Rpc.instance = Activity166Rpc.New()

return Activity166Rpc
