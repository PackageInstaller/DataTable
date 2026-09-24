-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessAddBuffWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessAddBuffWork", package.seeall)

local AutoChessAddBuffWork = class("AutoChessAddBuffWork", AutoChessBaseWork)

function AutoChessAddBuffWork:onStart()
	local entity = self.entityMgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:addBuff(self.effect.buff)
	end

	self:finishWork()
end

return AutoChessAddBuffWork
