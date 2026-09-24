-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessDelBuffWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessDelBuffWork", package.seeall)

local AutoChessDelBuffWork = class("AutoChessDelBuffWork", AutoChessBaseWork)

function AutoChessDelBuffWork:onStart()
	local entity = self.entityMgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:delBuff(self.effect.effectNum)
	end

	self:finishWork()
end

return AutoChessDelBuffWork
