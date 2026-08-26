-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheEventCenterDialogItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheEventCenterDialogItem", package.seeall)

local SodacheEventCenterDialogItem = class("SodacheEventCenterDialogItem", SodacheDialogueItem)

function SodacheEventCenterDialogItem:initView()
	self.txtSystemMessage = gohelper.findChildText(self.go, "#txt_systemmessage")
end

function SodacheEventCenterDialogItem:onInitData(data)
	self.txtSystemMessage.text = data.desc
end

function SodacheEventCenterDialogItem:calculateHeight()
	self.height = self.txtSystemMessage.preferredHeight
end

return SodacheEventCenterDialogItem
