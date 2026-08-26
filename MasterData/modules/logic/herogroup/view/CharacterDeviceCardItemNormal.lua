-- chunkname: @modules/logic/herogroup/view/CharacterDeviceCardItemNormal.lua

module("modules.logic.herogroup.view.CharacterDeviceCardItemNormal", package.seeall)

local CharacterDeviceCardItemNormal = class("CharacterDeviceCardItemNormal", FightDeviceCardItemNormal)

function CharacterDeviceCardItemNormal.Create(goParent)
	local deviceItem = CharacterDeviceCardItemNormal.New()

	deviceItem:init(goParent)

	return deviceItem
end

function CharacterDeviceCardItemNormal:init(goParent)
	self:__onInit()

	self.goParent = goParent
	self.rectTrParent = goParent:GetComponent(gohelper.Type_RectTransform)
end

function CharacterDeviceCardItemNormal:AddClickListener(clickCb, cbObj, clickParams)
	self._clickCb = clickCb
	self._cbObj = cbObj
	self._clickParams = clickParams
end

function CharacterDeviceCardItemNormal:initViews()
	CharacterDeviceCardItemNormal.super.initViews(self)

	self.goclick = gohelper.findChild(self.go, "click")
	self.goVx1 = gohelper.findChild(self.go, "vx_success")
	self.goVx2 = gohelper.findChild(self.go, "vx_fail")

	gohelper.setActive(self.goclick, true)
	gohelper.setActive(self.goVx1, false)
	gohelper.setActive(self.goVx2, false)

	if self._clickCb then
		self.btn = gohelper.getClick(self.goclick)

		self:addClickCb(self.btn, self._clickCb, self._cbObj, self._clickParams)
	end
end

function CharacterDeviceCardItemNormal:onDestroy()
	if self.btn then
		self:removeClickCb(self.btn)
	end
end

return CharacterDeviceCardItemNormal
