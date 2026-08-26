-- chunkname: @modules/logic/fight/controller/replay/FightReplayStepBuilder.lua

module("modules.logic.fight.controller.replay.FightReplayStepBuilder", package.seeall)

local FightReplayStepBuilder = class("FightReplayStepBuilder")

function FightReplayStepBuilder.buildReplaySequence()
	local sequence = FlowSequence.New()
	local roundOpMOs = FightReplayModel.instance:getList()

	for _, roundOpMO in ipairs(roundOpMOs) do
		sequence:addWork(FightReplayWorkWaitCardStage.New())

		for _, clothSkillOp in ipairs(roundOpMO.clothSkillOpers) do
			sequence:addWork(FightReplayWorkClothSkill.New(clothSkillOp))
		end

		sequence:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
		sequence:addWork(FunctionWork.New(function()
			FightDataHelper.tempMgr.replayAiJiAoQtePreTimeline = nil
		end))

		for _, cardOp in ipairs(roundOpMO.opers) do
			if cardOp:isMoveCard() then
				sequence:addWork(FightReplayWorkMoveCard.New(cardOp))
			elseif cardOp:isPlayCard() then
				sequence:addWork(FightReplayWorkPlayCard.New(cardOp))
			elseif cardOp:isMoveUniversal() then
				sequence:addWork(FightReplayWorkMoveUniversal.New(cardOp))
			elseif cardOp:isPlayerFinisherSkill() then
				sequence:addWork(FightReplyWorkPlayerFinisherSkill.New(cardOp))
			elseif cardOp:isBloodPoolSkill() then
				sequence:addWork(FightReplyWorkBloodPoolSkill.New(cardOp))
			end
		end

		if #roundOpMO.opers == 0 and #roundOpMO.clothSkillOpers == 0 then
			sequence:addWork(FunctionWork.New(function()
				FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())
			end))
		end

		sequence:addWork(FightReplayWorkWaitRoundEnd.New())
		sequence:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	end

	return sequence
end

return FightReplayStepBuilder
