-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueView_RightDialogueItem.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_RightDialogueItem", package.seeall)

local V2a4_WarmUp_DialogueView_RightDialogueItem = class("V2a4_WarmUp_DialogueView_RightDialogueItem", V2a4_WarmUpDialogueItemBase_LR)

function V2a4_WarmUp_DialogueView_RightDialogueItem:onInitView()
	self._txtcontent = gohelper.findChildText(self.viewGO, "content_bg/#txt_content")
	self._goloading = gohelper.findChild(self.viewGO, "content_bg/#go_loading")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_DialogueView_RightDialogueItem:addEvents()
	return
end

function V2a4_WarmUp_DialogueView_RightDialogueItem:removeEvents()
	return
end

function V2a4_WarmUp_DialogueView_RightDialogueItem:ctor(...)
	V2a4_WarmUp_DialogueView_RightDialogueItem.super.ctor(self, ...)
end

function V2a4_WarmUp_DialogueView_RightDialogueItem:getTemplateGo()
	local p = self:parent()

	return p._gorightdialogueitem
end

function V2a4_WarmUp_DialogueView_RightDialogueItem:onDestroyView()
	V2a4_WarmUp_DialogueView_RightDialogueItem.super.onDestroyView(self)
end

return V2a4_WarmUp_DialogueView_RightDialogueItem
