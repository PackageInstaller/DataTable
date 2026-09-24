-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessExpChangeWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessExpChangeWork", package.seeall)

local AutoChessExpChangeWork = class("AutoChessExpChangeWork", AutoChessBaseWork)

function AutoChessExpChangeWork:onStart()
	local entity = self.entityMgr:getEntity(self.effect.targetId)

	if entity then
		entity:updateExp(self.effect.effectNum)
	end

	self:finishWork()
end

return AutoChessExpChangeWork
