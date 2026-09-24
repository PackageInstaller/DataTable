-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessHpFloatWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessHpFloatWork", package.seeall)

local AutoChessHpFloatWork = class("AutoChessHpFloatWork", AutoChessBaseWork)

function AutoChessHpFloatWork:onStart()
	local entity = self.entityMgr:getEntity(self.effect.targetId)

	if entity then
		entity:floatHp(self.effect.effectNum, self.effect.fromId)
		self:delayCall(self.finishWork, 0.5)
	else
		self:finishWork()
	end
end

return AutoChessHpFloatWork
