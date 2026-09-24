-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessUpdateBuffWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessUpdateBuffWork", package.seeall)

local AutoChessUpdateBuffWork = class("AutoChessUpdateBuffWork", AutoChessBaseWork)

function AutoChessUpdateBuffWork:onStart()
	local entity = self.entityMgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:updateBuff(self.effect.buff)
	end

	self:finishWork()
end

return AutoChessUpdateBuffWork
