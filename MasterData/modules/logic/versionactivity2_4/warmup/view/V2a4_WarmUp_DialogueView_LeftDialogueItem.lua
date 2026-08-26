-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueView_LeftDialogueItem.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_LeftDialogueItem", package.seeall)

local V2a4_WarmUp_DialogueView_LeftDialogueItem = class("V2a4_WarmUp_DialogueView_LeftDialogueItem", V2a4_WarmUpDialogueItemBase_LR)

function V2a4_WarmUp_DialogueView_LeftDialogueItem:onInitView()
	self._txtcontent = gohelper.findChildText(self.viewGO, "content_bg/#txt_content")
	self._goloading = gohelper.findChild(self.viewGO, "content_bg/#go_loading")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_DialogueView_LeftDialogueItem:addEvents()
	return
end

function V2a4_WarmUp_DialogueView_LeftDialogueItem:removeEvents()
	return
end

function V2a4_WarmUp_DialogueView_LeftDialogueItem:ctor(...)
	V2a4_WarmUp_DialogueView_LeftDialogueItem.super.ctor(self, ...)
end

function V2a4_WarmUp_DialogueView_LeftDialogueItem:getTemplateGo()
	local p = self:parent()

	return p._goleftdialogueitem
end

function V2a4_WarmUp_DialogueView_LeftDialogueItem:onDestroyView()
	V2a4_WarmUp_DialogueView_LeftDialogueItem.super.onDestroyView(self)
end

return V2a4_WarmUp_DialogueView_LeftDialogueItem
