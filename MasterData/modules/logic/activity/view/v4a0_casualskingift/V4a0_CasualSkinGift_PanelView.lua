-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGift_PanelView.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGift_PanelView", package.seeall)

local V4a0_CasualSkinGift_PanelView = class("V4a0_CasualSkinGift_PanelView", V4a0_CasualSkinGiftImpl)

function V4a0_CasualSkinGift_PanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_FullBG")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "Root/rolename/role1/#simage_signature")
	self._txtskinname = gohelper.findChildText(self.viewGO, "Root/rolename/role1/#txt_skinname")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title")
	self._simageTitle2 = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title2")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_logo")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Right/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Btn/#btn_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Right/Btn/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_CasualSkinGift_PanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
end

function V4a0_CasualSkinGift_PanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
end

function V4a0_CasualSkinGift_PanelView:ctor(...)
	V4a0_CasualSkinGift_PanelView.super.ctor(self, ...)
end

function V4a0_CasualSkinGift_PanelView:_editableInitView()
	V4a0_CasualSkinGift_PanelView.super._editableInitView(self)
end

function V4a0_CasualSkinGift_PanelView:onDestroyView()
	V4a0_CasualSkinGift_PanelView.super.onDestroyView(self)
end

function V4a0_CasualSkinGift_PanelView:onClickModalMask()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function V4a0_CasualSkinGift_PanelView:onOpen()
	V4a0_CasualSkinGift_PanelView.super.onOpen(self)
end

return V4a0_CasualSkinGift_PanelView
