-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessBattleChangeWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessBattleChangeWork", package.seeall)

local AutoChessBattleChangeWork = class("AutoChessBattleChangeWork", AutoChessBaseWork)

function AutoChessBattleChangeWork:onStart()
	local entity = self.entityMgr:getEntity(self.effect.targetId)

	if entity then
		entity:updateBattle(self.effect.effectNum)
	end

	self:finishWork()
end

return AutoChessBattleChangeWork
