-- chunkname: @modules/logic/fight/view/FightNamePowerInfoView11.lua

module("modules.logic.fight.view.FightNamePowerInfoView11", package.seeall)

local FightNamePowerInfoView11 = class("FightNamePowerInfoView11", FightBaseView)

function FightNamePowerInfoView11:onInitView()
	self.stressText = gohelper.findChildText(self.viewGO, "#txt_stress")
	self.goBlue = gohelper.findChild(self.viewGO, "blue")
	self.goBlueLoop = gohelper.findChild(self.viewGO, "blue/loop")

	gohelper.setActive(self.goBlueLoop, false)

	self.goRed = gohelper.findChild(self.viewGO, "red")
	self.goRedLoop = gohelper.findChild(self.viewGO, "red/loop")

	gohelper.setActive(self.goRedLoop, false)

	self.goStaunch = gohelper.findChild(self.viewGO, "staunch")
	self.goBroken = gohelper.findChild(self.viewGO, "broken")
end

function FightNamePowerInfoView11:addEvents()
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
	self:com_registFightEvent(FightEvent.PowerMaxChange, self.onPowerMaxChange)
end

function FightNamePowerInfoView11:removeEvents()
	return
end

function FightNamePowerInfoView11:onConstructor(entityId, powerInfo)
	self.entityId = entityId
	self.powerInfo = powerInfo
end

function FightNamePowerInfoView11:onOpen()
	self:refreshUI()
end

function FightNamePowerInfoView11:refreshUI()
	local value = self.powerInfo.num

	self.stressText.text = value

	gohelper.setActive(self.goBlue, value >= 0 and value <= 3)
	gohelper.setActive(self.goRed, value == 4)
	gohelper.setActive(self.goStaunch, value >= 5)
end

function FightNamePowerInfoView11:onPowerChange(entityId, powerId)
	if self.entityId == entityId and self.powerInfo.powerId == powerId then
		self:refreshUI()
	end
end

function FightNamePowerInfoView11:onPowerMaxChange(entityId, powerId)
	if entityId ~= self.entityId then
		return
	end

	if self.powerInfo.powerIdId == powerId then
		self:refreshUI()
	end
end

function FightNamePowerInfoView11:onClose()
	return
end

function FightNamePowerInfoView11:onDestroyView()
	return
end

return FightNamePowerInfoView11
