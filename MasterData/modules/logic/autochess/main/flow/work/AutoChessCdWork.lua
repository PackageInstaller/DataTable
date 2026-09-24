-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessCdWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessCdWork", package.seeall)

local AutoChessCdWork = class("AutoChessCdWork", AutoChessBaseWork)

function AutoChessCdWork:onStart()
	local chessPos = self.context:getChessPosition1(self.effect.targetId)

	if chessPos then
		chessPos.chess:updateCd(self.effect.effectNum)
	end

	local delayTime = 0

	if self.skillEffectId then
		local entity = self.entityMgr:getEntity(self.effect.targetId)

		if entity then
			delayTime = entity:playEffect(self.skillEffectId)
		end
	end

	self:delayCall(self.finishWork, delayTime)
end

return AutoChessCdWork
