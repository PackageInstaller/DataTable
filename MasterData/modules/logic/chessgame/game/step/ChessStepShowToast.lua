-- chunkname: @modules/logic/chessgame/game/step/ChessStepShowToast.lua

module("modules.logic.chessgame.game.step.ChessStepShowToast", package.seeall)

local ChessStepShowToast = class("ChessStepShowToast", BaseWork)

function ChessStepShowToast:init(stepData)
	self.originData = stepData
end

function ChessStepShowToast:onStart()
	self:showToast()
	self:onDone(true)
end

function ChessStepShowToast:showToast()
	local toastId = self.originData.notifyId
	local actId = ChessModel.instance:getActId()
	local tipco = ChessConfig.instance:getTipsCo(actId, toastId)

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, tipco)
end

return ChessStepShowToast
