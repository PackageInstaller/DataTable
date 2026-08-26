-- chunkname: @modules/logic/dialogue/view/items/DialogueItem.lua

module("modules.logic.dialogue.view.items.DialogueItem", package.seeall)

local DialogueItem = class("DialogueItem", UserDataDispose)

function DialogueItem.CreateItem(stepCo, go, upInterval)
	local cls = DialogueEnum.DialogueItemCls[stepCo.type]

	if not cls then
		logError("un support type dialogue type : " .. tostring(stepCo.type))

		return nil
	end

	local item = cls.New()

	item:init(stepCo, go, upInterval)

	return item
end

function DialogueItem:init(stepCo, go, upInterval)
	self:__onInit()

	self.stepCo = stepCo
	self.go = go
	self.transform = self.go.transform

	recthelper.setAnchorY(self.transform, -upInterval)
	gohelper.setActive(go, true)
	self:initView()
	self:refresh()
	self:calculateHeight()
end

function DialogueItem:initView()
	return
end

function DialogueItem:refresh()
	return
end

function DialogueItem:calculateHeight()
	return
end

function DialogueItem:getHeight()
	return self.height
end

function DialogueItem:onDestroy()
	return
end

function DialogueItem:destroy()
	self:onDestroy()
	self:__onDispose()
end

return DialogueItem
