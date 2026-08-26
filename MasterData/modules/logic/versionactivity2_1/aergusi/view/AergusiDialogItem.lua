-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogItem", package.seeall)

local AergusiDialogItem = class("AergusiDialogItem", UserDataDispose)

function AergusiDialogItem.CreateItem(stepCo, go, upInterval, type)
	local cls = AergusiEnum.DialogItemCls[type]

	if not cls then
		logError("un support type dialogue type : " .. tostring(type))

		return nil
	end

	local item = cls.New()

	item:init(stepCo, go, upInterval, type)

	return item
end

function AergusiDialogItem:init(stepCo, go, upInterval, type)
	self:__onInit()

	self.stepCo = stepCo
	self.go = go
	self.type = type
	self.transform = self.go.transform

	recthelper.setAnchorY(self.transform, -upInterval)
	gohelper.setActive(go, true)
	self:initView()
	self:refresh()
	self:calculateHeight()
end

function AergusiDialogItem:initView()
	return
end

function AergusiDialogItem:refresh()
	return
end

function AergusiDialogItem:calculateHeight()
	return
end

function AergusiDialogItem:getHeight()
	return self.height
end

function AergusiDialogItem:onDestroy()
	return
end

function AergusiDialogItem:destroy()
	self:onDestroy()
	self:__onDispose()
end

return AergusiDialogItem
