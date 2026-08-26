-- chunkname: @modules/logic/dialogue/view/items/DialogueSystemMessageItem.lua

module("modules.logic.dialogue.view.items.DialogueSystemMessageItem", package.seeall)

local DialogueSystemMessageItem = class("DialogueSystemMessageItem", DialogueItem)

function DialogueSystemMessageItem:initView()
	self.txtSystemMessage = gohelper.findChildText(self.go, "#txt_systemmessage")
end

function DialogueSystemMessageItem:refresh()
	self.txtSystemMessage.text = self.stepCo.content
end

function DialogueSystemMessageItem:calculateHeight()
	self.height = DialogueEnum.MinHeight[DialogueEnum.Type.SystemMessage]
end

function DialogueSystemMessageItem:onDestroy()
	return
end

return DialogueSystemMessageItem
