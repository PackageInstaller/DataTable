-- chunkname: @modules/logic/fight/view/FightNamePowerInfoView9Item.lua

module("modules.logic.fight.view.FightNamePowerInfoView9Item", package.seeall)

local FightNamePowerInfoView9Item = class("FightNamePowerInfoView9Item", FightBaseView)

function FightNamePowerInfoView9Item:onConstructor(index, entityId, powerInfo)
	self.index = index
	self.entityId = entityId
	self.powerInfo = powerInfo
end

function FightNamePowerInfoView9Item:onInitView()
	self.bg = gohelper.findChildImage(self.viewGO, "bg")
	self.point = gohelper.findChildImage(self.viewGO, "light")
	self.ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function FightNamePowerInfoView9Item:addEvents()
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
end

function FightNamePowerInfoView9Item:removeEvents()
	return
end

function FightNamePowerInfoView9Item:onOpen()
	gohelper.setActive(self.point, self.index <= self.powerInfo.num)
	self.ani:Play("idle", 0, 0)
end

function FightNamePowerInfoView9Item:onPowerChange(targetId, powerId, oldValue, newValue)
	if powerId ~= 9 then
		return
	end

	if targetId ~= self.entityId then
		return
	end

	gohelper.setActive(self.point, self.index <= self.powerInfo.num)

	if oldValue ~= newValue then
		if oldValue < newValue then
			if oldValue < self.index and newValue >= self.index then
				self.ani:Play("open", 0, 0)
			end
		elseif newValue < self.index and oldValue >= self.index then
			self.ani:Play("close", 0, 0)
		end
	end
end

function FightNamePowerInfoView9Item:onClose()
	return
end

function FightNamePowerInfoView9Item:onDestroyView()
	return
end

return FightNamePowerInfoView9Item
