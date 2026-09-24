-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessLeaderHpWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessLeaderHpWork", package.seeall)

local AutoChessLeaderHpWork = class("AutoChessLeaderHpWork", AutoChessBaseWork)

function AutoChessLeaderHpWork:onStart()
	local entity = AutoChessEntityMgr.instance:getLeaderEntity(self.effect.targetId)

	if entity then
		entity:updateHp(self.effect.effectNum)
	end

	self:finishWork()
end

return AutoChessLeaderHpWork
