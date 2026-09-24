-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessLeaderSkillUpdateWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessLeaderSkillUpdateWork", package.seeall)

local AutoChessLeaderSkillUpdateWork = class("AutoChessLeaderSkillUpdateWork", AutoChessBaseWork)

function AutoChessLeaderSkillUpdateWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		sceneMo.fight:unlockMasterSkill(self.effect.targetId)
	end

	self:finishWork()
end

return AutoChessLeaderSkillUpdateWork
