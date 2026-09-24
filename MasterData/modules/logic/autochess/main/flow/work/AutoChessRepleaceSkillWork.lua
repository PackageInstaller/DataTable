-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessRepleaceSkillWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessRepleaceSkillWork", package.seeall)

local AutoChessRepleaceSkillWork = class("AutoChessRepleaceSkillWork", AutoChessBaseWork)

function AutoChessRepleaceSkillWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		local chessPos = self.context:getChessPosition1(self.effect.fromId)

		if chessPos then
			chessPos.chess:updateChessIds(self.effect.effectString)
		end
	end

	self:finishWork()
end

return AutoChessRepleaceSkillWork
