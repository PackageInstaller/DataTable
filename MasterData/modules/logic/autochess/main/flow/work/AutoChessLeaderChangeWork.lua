-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessLeaderChangeWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessLeaderChangeWork", package.seeall)

local AutoChessLeaderChangeWork = class("AutoChessLeaderChangeWork", AutoChessBaseWork)

function AutoChessLeaderChangeWork:onStart()
	local sceneMo = AutoChessModel.instance:getSceneMo()

	if sceneMo then
		local fightMo = sceneMo.fight
		local entity = self.entityMgr:getLeaderEntity(fightMo.mySideMaster.uid)

		if entity then
			entity:setData(self.effect.master)
		end

		fightMo:updateMaster(self.effect.master)
	end

	self:finishWork()
end

return AutoChessLeaderChangeWork
