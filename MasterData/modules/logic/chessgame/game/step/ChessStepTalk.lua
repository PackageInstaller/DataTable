-- chunkname: @modules/logic/chessgame/game/step/ChessStepTalk.lua

module("modules.logic.chessgame.game.step.ChessStepTalk", package.seeall)

local ChessStepTalk = class("ChessStepTalk", BaseWork)

function ChessStepTalk:init(stepData)
	self.originData = stepData
end

function ChessStepTalk:onStart()
	self:showTalk()
	self:onDone(true)
end

function ChessStepTalk:showToast()
	local toastId = self.originData.notifyId
	local actId = ChessModel.instance:getActId()
	local tipco = ChessConfig.instance:getTipsCo(actId, toastId)

	GameFacade.showToastString(tipco.content)
end

return ChessStepTalk
