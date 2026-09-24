-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessHpWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessHpWork", package.seeall)

local AutoChessHpWork = class("AutoChessHpWork", AutoChessBaseWork)

function AutoChessHpWork:onStart()
	local entity = self.entityMgr:getEntity(self.effect.targetId)

	if entity then
		entity:updateHp(self.effect.effectNum)
	end

	self:finishWork()
end

return AutoChessHpWork
