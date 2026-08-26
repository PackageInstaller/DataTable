-- chunkname: @modules/logic/fight/system/work/FightWorkEndVictory.lua

module("modules.logic.fight.system.work.FightWorkEndVictory", package.seeall)

local FightWorkEndVictory = class("FightWorkEndVictory", BaseWork)

function FightWorkEndVictory:onStart()
	local allEntitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(allEntitys) do
		if entity.nameUI then
			entity.nameUI:setActive(false)
		end
	end

	self:onDone(true)
end

return FightWorkEndVictory
