-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessMallUpdateWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessMallUpdateWork", package.seeall)

local AutoChessMallUpdateWork = class("AutoChessMallUpdateWork", AutoChessBaseWork)

function AutoChessMallUpdateWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo.mall:updateSvrMallRegion(self.effect.region, true)
	end

	self:finishWork()
end

return AutoChessMallUpdateWork
