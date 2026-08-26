-- chunkname: @modules/logic/globalvote/model/GlobalVoteModel.lua

module("modules.logic.globalvote.model.GlobalVoteModel", package.seeall)

local GlobalVoteModel = class("GlobalVoteModel", BaseModel)

function GlobalVoteModel:onInit()
	self:reInit()
end

function GlobalVoteModel:reInit()
	self._infos = {}
end

function GlobalVoteModel:onReceiveGlobalVoteGetInfoReply(msg)
	local infoMo = GlobalVoteInfoMo.New(self)

	infoMo:init(msg.voteInfo)

	self._infos[msg.voteId] = infoMo
end

function GlobalVoteModel:getInfoMo(voteId)
	return self._infos[voteId]
end

function GlobalVoteModel:getSimpleInfo(voteId)
	local infoMo = self:getInfoMo(voteId)
	local totVotedCnt = 0
	local opId2VoteCnt = {}

	if infoMo then
		for _, resultMo in ipairs(infoMo:optionResults()) do
			local optionId = resultMo:optionId()
			local optionResult = resultMo:optionResult()

			opId2VoteCnt[optionId] = opId2VoteCnt[optionId] or 0
			opId2VoteCnt[optionId] = opId2VoteCnt[optionId] + optionResult
			totVotedCnt = totVotedCnt + optionResult
		end
	end

	return {
		voteId = voteId,
		opId2VoteCnt = opId2VoteCnt,
		totVotedCnt = totVotedCnt
	}
end

GlobalVoteModel.instance = GlobalVoteModel.New()

return GlobalVoteModel
