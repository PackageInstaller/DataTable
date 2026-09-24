-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessBossDropWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessBossDropWork", package.seeall)

local AutoChessBossDropWork = class("AutoChessBossDropWork", AutoChessBaseWork)

function AutoChessBossDropWork:onStart()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BossDrop, self.effect.effectString)
	self:finishWork()
end

return AutoChessBossDropWork
