-- chunkname: @modules/logic/dialogue/view/items/DialogueNormalItem.lua

module("modules.logic.dialogue.view.items.DialogueNormalItem", package.seeall)

local DialogueNormalItem = class("DialogueNormalItem", DialogueItem)

function DialogueNormalItem:initView()
	self.simageAvatar = gohelper.findChildSingleImage(self.go, "rolebg/#image_avatar")
	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtContent = gohelper.findChildText(self.go, "content_bg/#txt_content")
	self.goLoading = gohelper.findChild(self.go, "content_bg/#go_loading")
	self.contentBgRectTr = gohelper.findChildComponent(self.go, "content_bg", gohelper.Type_RectTransform)
	self.txtRectTr = self.txtContent:GetComponent(gohelper.Type_RectTransform)
end

function DialogueNormalItem:refresh()
	self.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.avatar))

	self.txtName.text = self.stepCo.name
	self.txtContent.text = self.stepCo.content

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function DialogueNormalItem:calculateHeight()
	local width = self.txtContent.preferredWidth

	if width <= DialogueEnum.MessageTxtMaxWidth then
		local contentBgHeight = DialogueEnum.MessageTxtOneLineHeight + DialogueEnum.MessageBgOffsetHeight

		recthelper.setSize(self.contentBgRectTr, width + DialogueEnum.MessageBgOffsetWidth, contentBgHeight)
		recthelper.setSize(self.txtRectTr, width, DialogueEnum.MessageTxtOneLineHeight)

		self.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], contentBgHeight + DialogueEnum.MessageNameHeight)

		return
	end

	width = DialogueEnum.MessageTxtMaxWidth

	local height = self.txtContent.preferredHeight
	local contentBgHeight = height + DialogueEnum.MessageBgOffsetHeight

	recthelper.setSize(self.contentBgRectTr, DialogueEnum.MessageTxtMaxWidth + DialogueEnum.MessageBgOffsetWidth, contentBgHeight)
	recthelper.setSize(self.txtRectTr, width, height)

	self.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], contentBgHeight + DialogueEnum.MessageNameHeight)
end

function DialogueNormalItem:logHeight()
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.preferredHeight)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.preferredWidth)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.renderedWidth)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.renderedHeight)
end

function DialogueNormalItem:onDestroy()
	self.simageAvatar:UnLoadImage()
end

return DialogueNormalItem
