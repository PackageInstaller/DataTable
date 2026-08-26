-- chunkname: @modules/logic/fight/system/work/FightWorkEndLose.lua

module("modules.logic.fight.system.work.FightWorkEndLose", package.seeall)

local FightWorkEndLose = class("FightWorkEndLose", BaseWork)

function FightWorkEndLose:onStart()
	local allEntitys = FightHelper.getAllEntitys()

	for _, entity in ipairs(allEntitys) do
		if entity.nameUI then
			entity.nameUI:setActive(false)
		end
	end

	self:onDone(true)
end

return FightWorkEndLose
