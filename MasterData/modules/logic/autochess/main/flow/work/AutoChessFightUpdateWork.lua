-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessFightUpdateWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessFightUpdateWork", package.seeall)

local AutoChessFightUpdateWork = class("AutoChessFightUpdateWork", AutoChessBaseWork)

function AutoChessFightUpdateWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo:updateSvrFight(self.effect.fight)
	end

	self:finishWork()
end

return AutoChessFightUpdateWork
