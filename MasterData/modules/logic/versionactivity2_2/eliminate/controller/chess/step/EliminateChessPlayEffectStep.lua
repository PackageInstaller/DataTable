-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/chess/step/EliminateChessPlayEffectStep.lua

module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayEffectStep", package.seeall)

local EliminateChessPlayEffectStep = class("EliminateChessPlayEffectStep", EliminateChessStepBase)

function EliminateChessPlayEffectStep:onStart()
	local x, y, effectType = EliminateChessModel.instance:getRecordCurNeedShowEffectAndXYAndClear()

	self.effectType = effectType

	if x == nil or y == nil or self.effectType == nil then
		self:onDone(true)

		return
	end

	local chess = EliminateChessItemController.instance:getChessItem(x, y)

	if not chess then
		logError("步骤 PlayEffect 棋子：" .. x, y .. "不存在")
		self:onDone(true)

		return
	end

	local worldX, worldY = chess:getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, self.effectType, x, y, worldX, worldY, true, self._onPlayEnd, self)
end

function EliminateChessPlayEffectStep:_onPlayEnd()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, self.effectType, nil, nil, 0, 0, false, nil, nil)
	self:onDone(true)
end

return EliminateChessPlayEffectStep
