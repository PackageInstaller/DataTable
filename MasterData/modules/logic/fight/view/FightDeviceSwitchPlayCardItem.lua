-- chunkname: @modules/logic/fight/view/FightDeviceSwitchPlayCardItem.lua

module("modules.logic.fight.view.FightDeviceSwitchPlayCardItem", package.seeall)

local FightDeviceSwitchPlayCardItem = class("FightDeviceSwitchPlayCardItem", FightDevicePlayCardItem)

function FightDeviceSwitchPlayCardItem.Create(goParent)
	local deviceItem = FightDeviceSwitchPlayCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.SwitchPlayCard)

	return deviceItem
end

function FightDeviceSwitchPlayCardItem:initViews()
	FightDeviceCardItem.initViews(self)

	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClickDeviceCard, self)
end

function FightDeviceSwitchPlayCardItem:onLongPress()
	return
end

function FightDeviceSwitchPlayCardItem:afterLoadDone()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
	self:playAnim("idle")
end

return FightDeviceSwitchPlayCardItem
