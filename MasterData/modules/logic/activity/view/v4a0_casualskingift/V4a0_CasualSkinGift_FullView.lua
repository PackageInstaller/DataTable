-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGift_FullView.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGift_FullView", package.seeall)

local V4a0_CasualSkinGift_FullView = class("V4a0_CasualSkinGift_FullView", V4a0_CasualSkinGiftImpl)

function V4a0_CasualSkinGift_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/BG/#simage_FullBG")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "Root/rolename/role1/#simage_signature")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title")
	self._simageTitle2 = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title2")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_logo")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Right/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Btn/#btn_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Right/Btn/#go_hasget")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Btn/#go_hasget/#btn_change")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a0_CasualSkinGift_FullView:addEvents()
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
end

function V4a0_CasualSkinGift_FullView:removeEvents()
	self._btnclaim:RemoveClickListener()
	self._btnchange:RemoveClickListener()
end

function V4a0_CasualSkinGift_FullView:ctor(...)
	V4a0_CasualSkinGift_FullView.super.ctor(self, ...)
end

function V4a0_CasualSkinGift_FullView:_editableInitView()
	V4a0_CasualSkinGift_FullView.super._editableInitView(self)
end

function V4a0_CasualSkinGift_FullView:onDestroyView()
	V4a0_CasualSkinGift_FullView.super.onDestroyView(self)
end

function V4a0_CasualSkinGift_FullView:onOpen()
	V4a0_CasualSkinGift_FullView.super.onOpen(self)
end

return V4a0_CasualSkinGift_FullView
