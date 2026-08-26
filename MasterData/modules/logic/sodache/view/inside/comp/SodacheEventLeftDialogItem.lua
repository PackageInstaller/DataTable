-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheEventLeftDialogItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheEventLeftDialogItem", package.seeall)

local SodacheEventLeftDialogItem = class("SodacheEventLeftDialogItem", SodacheDialogueItem)

function SodacheEventLeftDialogItem:initView()
	self.simageAvatar = gohelper.findChildSingleImage(self.go, "rolebg/#image_avatar")
	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtContent = gohelper.findChildText(self.go, "content_bg/#txt_content")
	self.contentBgRectTr = gohelper.findChildComponent(self.go, "content_bg", gohelper.Type_RectTransform)
	self.txtRectTr = self.txtContent:GetComponent(gohelper.Type_RectTransform)
end

function SodacheEventLeftDialogItem:onInitData(data)
	self.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(data.head))

	self.txtName.text = data.actor
	self.txtContent.text = data.desc

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function SodacheEventLeftDialogItem:calculateHeight()
	local height = self.txtContent.preferredHeight
	local contentBgHeight = height + 20

	recthelper.setHeight(self.txtRectTr, height)

	self.height = Mathf.Max(185, contentBgHeight)
end

return SodacheEventLeftDialogItem
