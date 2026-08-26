-- chunkname: @modules/logic/versionactivity2_4/warmup/view/V2a4_WarmUp_DialogueView_MidDialogueItem.lua

module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_MidDialogueItem", package.seeall)

local V2a4_WarmUp_DialogueView_MidDialogueItem = class("V2a4_WarmUp_DialogueView_MidDialogueItem", V2a4_WarmUpDialogueItemBase)

function V2a4_WarmUp_DialogueView_MidDialogueItem:onInitView()
	self._txtcontent = gohelper.findChildText(self.viewGO, "#txt_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:addEvents()
	return
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:removeEvents()
	return
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:ctor(...)
	V2a4_WarmUp_DialogueView_MidDialogueItem.super.ctor(self, ...)
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:_editableInitView()
	V2a4_WarmUp_DialogueView_MidDialogueItem.super._editableInitView(self)

	self._txtGo = self._txtcontent.gameObject
	self._txtTrans = self._txtGo.transform
	self._oriTxtHeight = recthelper.getHeight(self._txtTrans)
	self._oriTxtWidth = recthelper.getWidth(self._txtTrans)
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:getTemplateGo()
	local p = self:parent()

	return p._gomiddialogueItem
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:setData(mo)
	V2a4_WarmUp_DialogueView_MidDialogueItem.super.setData(self, mo)

	local dialogCO = mo.dialogCO
	local str = V2a4_WarmUpConfig.instance:getDialogDesc(dialogCO)

	self:setText(str)
	self:onFlush()
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:onDestroyView()
	V2a4_WarmUp_DialogueView_MidDialogueItem.super.onDestroyView(self)
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:onRefreshLineInfo()
	local curTxtHeight = self:preferredHeightTxt()

	recthelper.setSize(self._txtTrans, self._oriTxtWidth, curTxtHeight)
	self:addContentItem(curTxtHeight)
	self:stepEnd()
end

function V2a4_WarmUp_DialogueView_MidDialogueItem:setGray(isGray)
	self:grayscale(isGray, self._txtGo)
end

return V2a4_WarmUp_DialogueView_MidDialogueItem
