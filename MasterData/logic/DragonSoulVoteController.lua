-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/controller/DragonSoulVoteController.lua

module("logic.extensions.dragonsoulvote.controller.DragonSoulVoteController", package.seeall)

local DragonSoulVoteController = class("DragonSoulVoteController", BaseController)

function DragonSoulVoteController:onInit()
	self:onReset()
end

function DragonSoulVoteController:onReset()
	return
end

function DragonSoulVoteController:getActivityId()
	return 428001
end

function DragonSoulVoteController:sendGetInfo(activityId)
	DSoulPredictAgent.instance:sendPM_DSoulPredictGetInfoReq(activityId)
end

function DragonSoulVoteController:onGetInfo(msg)
	DragonSoulVoteModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DRAGON_SOUL_VOTE_UPDATE)
end

function DragonSoulVoteController:sendGetPrize(activityId, prizeId)
	DSoulPredictAgent.instance:sendPM_DSoulPredictGainPrizeReq(activityId, prizeId)
end

function DragonSoulVoteController:onGetPrize(msg)
	DragonSoulVoteModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DRAGON_SOUL_VOTE_UPDATE)
end

function DragonSoulVoteController:sendMakeRole(activityId, left, right, msgId)
	local pb = CommonStructDef_pb.PM_PairInt()

	pb.left = left
	pb.right = right

	DSoulPredictAgent.instance:sendPM_DSoulPredictPredictReq(activityId, pb, msgId)
end

function DragonSoulVoteController:onMakeRole(msg)
	DragonSoulVoteModel.instance:onMakeRole(msg)
end

function DragonSoulVoteController:sendVote(activityId, left, right, voteCount)
	local pb = CommonStructDef_pb.PM_PairInt()

	pb.left = left
	pb.right = right
	self._tempLeft = left
	self._tempRight = right
	self._tempVoteCount = voteCount

	DSoulPredictAgent.instance:sendPM_DSoulPredictVoteReq(activityId, pb, voteCount)
end

function DragonSoulVoteController:onVote(msg)
	DragonSoulVoteModel.instance:onVote(msg, self._tempLeft, self._tempRight, self._tempVoteCount)
	GlobalDispatcher:dispatch(GlobalNotify.DRAGON_SOUL_VOTE_UPDATE)
end

DragonSoulVoteController.instance = DragonSoulVoteController.New()

return DragonSoulVoteController
