-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/controller/FameHallVoteController.lua

module("logic.extensions.famehallvote.controller.FameHallVoteController", package.seeall)

local FameHallVoteController = class("FameHallVoteController", BaseController)

function FameHallVoteController:onInit()
	self:onReset()
end

function FameHallVoteController:onReset()
	return
end

function FameHallVoteController:sendPM_FameHallVoteGetInfoReq(activityId)
	FameHallVoteAgent.instance:sendPM_FameHallVoteGetInfoReq(activityId)
end

function FameHallVoteController:handlePM_FameHallVoteGetInfoRes(msg)
	FameHallVoteModel.instance:handlePM_FameHallVoteGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_FameHallVoteGetInfoRes)
end

function FameHallVoteController:sendPM_FameHallVoteReq(activityId, voteUserId)
	FameHallVoteAgent.instance:sendPM_FameHallVoteReq(activityId, voteUserId)
end

function FameHallVoteController:handlePM_FameHallVoteRes(msg)
	FameHallVoteModel.instance:handlePM_FameHallVoteRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_FameHallVoteRes)
end

function FameHallVoteController:sendPM_FameHallVoteGainPrizeReq(activityId, prizeId)
	FameHallVoteAgent.instance:sendPM_FameHallVoteGainPrizeReq(activityId, prizeId)
end

function FameHallVoteController:handlePM_FameHallVoteGainPrizeRes(msg)
	FameHallVoteModel.instance:handlePM_FameHallVoteGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_FameHallVoteGainPrizeRes)
end

function FameHallVoteController:getHonorDescList(activityId, userId)
	local info = FameHallVoteModel.instance:getInfo(activityId)
	local titleCfgs = FameHallVoteConfig.instance:getPlayerTitleCfg(activityId)
	local titleCfg = titleCfgs[userId]
	local honorDescList = {}

	for fameHallType, cfg in pairs(titleCfg) do
		local fameDescCfg = FameHallVoteConfig.instance:getFameDescCfg(fameHallType)
		local count = cfg.count
		local hasParam = fameDescCfg.hasParam
		local honorDesc = fameDescCfg.fameHallDesc

		table.insert(honorDescList, hasParam and string.format(honorDesc, count) or honorDesc)
	end

	return honorDescList
end

FameHallVoteController.instance = FameHallVoteController.New()

return FameHallVoteController
