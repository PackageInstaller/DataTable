-- chunkname: @modules/logic/chessgame/game/step/ChessStepDialogue.lua

module("modules.logic.chessgame.game.step.ChessStepDialogue", package.seeall)

local ChessStepDialogue = class("ChessStepDialogue", BaseWork)

function ChessStepDialogue:init(stepData)
	self.originData = stepData
end

function ChessStepDialogue:onStart()
	local interactId = self.originData.interactId
	local groupId = self.originData.dialogueId
	local actId = ChessModel.instance:getActId()
	local bubbleco = ChessConfig.instance:getBubbleCoByGroup(actId, groupId)

	if not bubbleco then
		self:onDone(true)

		return
	end

	if ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)

		return
	end

	ChessGameController.instance:registerCallback(ChessGameEvent.DialogEnd, self._onDialogEnd, self)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayDialogue, {
		txtco = bubbleco,
		id = interactId
	})
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.ShowTalk)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function ChessStepDialogue:_onDialogEnd()
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer()
	self:onDone(true)
end

function ChessStepDialogue:clearWork()
	ChessGameController.instance:unregisterCallback(ChessGameEvent.DialogEnd, self._onDialogEnd, self)
end

return ChessStepDialogue
