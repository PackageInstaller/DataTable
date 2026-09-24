-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessUpdateExtInfoWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessUpdateExtInfoWork", package.seeall)

local AutoChessUpdateExtInfoWork = class("AutoChessUpdateExtInfoWork", AutoChessBaseWork)

function AutoChessUpdateExtInfoWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo.extInfo:update(self.effect.effectString)
	end

	self:finishWork()
end

return AutoChessUpdateExtInfoWork
