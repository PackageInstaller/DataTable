-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotEnvModItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotEnvModItem", package.seeall)

local TowerComposeResultSlotEnvModItem = class("TowerComposeResultSlotEnvModItem", LuaCompBase)

function TowerComposeResultSlotEnvModItem:ctor()
	return
end

function TowerComposeResultSlotEnvModItem:init(go)
	self.go = go
	self._txtEnviroment = gohelper.findChildText(self.go, "txt_environment")
	self._imageIcon = gohelper.findChildImage(self.go, "txt_environment/#image_icon")

	self:_addEvents()
end

function TowerComposeResultSlotEnvModItem:_addEvents()
	return
end

function TowerComposeResultSlotEnvModItem:_removeEvents()
	return
end

function TowerComposeResultSlotEnvModItem:refresh(modId)
	self._modId = modId

	gohelper.setActive(self.go, true)

	if self._modId > 0 then
		local modconfig = TowerComposeConfig.instance:getComposeModConfig(self._modId)

		UISpriteSetMgr.instance:setTower2Sprite(self._imageIcon, modconfig.icon)

		self._txtEnviroment.text = modconfig.name
	end
end

function TowerComposeResultSlotEnvModItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotEnvModItem
