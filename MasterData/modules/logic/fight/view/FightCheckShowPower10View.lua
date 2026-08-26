-- chunkname: @modules/logic/fight/view/FightCheckShowPower10View.lua

module("modules.logic.fight.view.FightCheckShowPower10View", package.seeall)

local FightCheckShowPower10View = class("FightCheckShowPower10View", FightBaseView)

function FightCheckShowPower10View:onInitView()
	self.bossHpRoot = gohelper.findChild(self.viewGO, "root/bossHpRoot")
end

function FightCheckShowPower10View:addEvents()
	return
end

function FightCheckShowPower10View:removeEvents()
	return
end

function FightCheckShowPower10View:onOpen()
	local enemyEntityList = FightDataHelper.entityMgr:getEnemyNormalList()

	for i, entityData in ipairs(enemyEntityList) do
		local power = entityData:getPowerInfo(10)

		if power then
			self:com_openSubView(FightPowerView10, "ui/viewres/fight/fightpowerview10.prefab", self.bossHpRoot, entityData.id, power)

			break
		end
	end
end

function FightCheckShowPower10View:onClose()
	return
end

function FightCheckShowPower10View:onDestroyView()
	return
end

return FightCheckShowPower10View
