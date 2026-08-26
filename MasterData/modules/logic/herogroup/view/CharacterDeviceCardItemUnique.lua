-- chunkname: @modules/logic/herogroup/view/CharacterDeviceCardItemUnique.lua

module("modules.logic.herogroup.view.CharacterDeviceCardItemUnique", package.seeall)

local CharacterDeviceCardItemUnique = class("CharacterDeviceCardItemUnique", FightDeviceCardItemUnique)

function CharacterDeviceCardItemUnique.Create(goParent)
	local deviceItem = CharacterDeviceCardItemUnique.New()

	deviceItem:init(goParent)

	return deviceItem
end

function CharacterDeviceCardItemUnique:init(goParent)
	self:__onInit()

	self.goParent = goParent
	self.rectTrParent = goParent:GetComponent(gohelper.Type_RectTransform)
end

function CharacterDeviceCardItemUnique:AddClickListener(clickCb, cbObj, clickParams)
	self._clickCb = clickCb
	self._cbObj = cbObj
	self._clickParams = clickParams
end

function CharacterDeviceCardItemUnique:initViews()
	CharacterDeviceCardItemUnique.super.initViews(self)

	self.goclick = gohelper.findChild(self.go, "click")

	gohelper.setActive(self.goclick, true)

	if self._clickCb then
		self.btn = gohelper.getClick(self.goclick)

		self:addClickCb(self.btn, self._clickCb, self._cbObj, self._clickParams)
	end
end

function CharacterDeviceCardItemUnique:onDestroy()
	if self.btn then
		self:removeClickCb(self.btn)
	end
end

return CharacterDeviceCardItemUnique
