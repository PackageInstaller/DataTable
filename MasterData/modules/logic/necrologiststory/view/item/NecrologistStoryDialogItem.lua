-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryDialogItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryDialogItem", package.seeall)

local NecrologistStoryDialogItem = class("NecrologistStoryDialogItem", NecrologistStoryTextItem)

function NecrologistStoryDialogItem:onInit()
	NecrologistStoryDialogItem.super.onInit(self)

	self.heroBg = gohelper.findChild(self.viewGO, "descer/herobg")
	self.npcBg = gohelper.findChild(self.viewGO, "descer/npcbg")
	self.txtDescer = gohelper.findChildTextMesh(self.viewGO, "descer/txtDescer")
	self.space = 62
end

function NecrologistStoryDialogItem:onPlayStory(isSkip)
	local storyConfig = self:getStoryConfig()
	local isRole, name = NecrologistStoryHelper.getDialogName(storyConfig)

	self.txtDescer.text = name

	gohelper.setActive(self.heroBg, isRole)
	gohelper.setActive(self.npcBg, not isRole)
	NecrologistStoryDialogItem.super.onPlayStory(self, isSkip)
end

function NecrologistStoryDialogItem:caleHeight()
	local contentHeight = self.txtContent.preferredHeight

	return contentHeight + self.space
end

function NecrologistStoryDialogItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorydialogitem.prefab"
end

return NecrologistStoryDialogItem
