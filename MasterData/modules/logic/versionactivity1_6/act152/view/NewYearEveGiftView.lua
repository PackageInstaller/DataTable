-- chunkname: @modules/logic/versionactivity1_6/act152/view/NewYearEveGiftView.lua

module("modules.logic.versionactivity1_6.act152.view.NewYearEveGiftView", package.seeall)

local NewYearEveGiftView = class("NewYearEveGiftView", BaseView)

function NewYearEveGiftView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "Item/#simage_Item")
	self._simagesign = gohelper.findChildSingleImage(self.viewGO, "Item/#simage_sign")
	self._gocontentroot = gohelper.findChild(self.viewGO, "#go_contentroot")
	self._goconversation = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation")
	self._gohead = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_head")
	self._goheadgrey = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_head/#go_headgrey")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_contentroot/#go_conversation/#go_head/#simage_head")
	self._goname = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_name")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_nameen")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewYearEveGiftView:addEvents()
	return
end

function NewYearEveGiftView:removeEvents()
	return
end

function NewYearEveGiftView:_editableInitView()
	self._clickbg = gohelper.getClickWithAudio(self._simageFullBG.gameObject)

	self._clickbg:AddClickListener(self._onBgClick, self)
end

function NewYearEveGiftView:_onBgClick()
	self:_checkNextStep()
end

function NewYearEveGiftView:onClickModalMask()
	self:_checkNextStep()
end

function NewYearEveGiftView:_checkNextStep()
	if self._dialogIndex >= #self._dialogs then
		self:closeThis()

		return
	end

	self._dialogIndex = self._dialogIndex + 1

	self:_refreshUI()
end

function NewYearEveGiftView:onOpen()
	self._presentId = self.viewParam

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)

	self._dialogIndex = 1

	local giftCo = Activity152Config.instance:getAct152Co(self._presentId)

	self._dialogs = string.split(giftCo.dialog, "|")

	self:_refreshUI()
end

function NewYearEveGiftView:_refreshUI()
	local giftCo = Activity152Config.instance:getAct152Co(self._presentId)

	self._simageItem:LoadImage(ResUrl.getAntiqueIcon(giftCo.presentIcon))
	self._simagesign:LoadImage(ResUrl.getSignature(giftCo.presentSign))
	self._simagehead:LoadImage(ResUrl.getHeadIconSmall(giftCo.roleIcon))

	self._txtTitle.text = giftCo.presentName
	self._txtnamecn.text = giftCo.roleName
	self._txtnameen.text = "/ " .. giftCo.roleNameEn
	self._txtcontent.text = self._dialogs[self._dialogIndex]
end

function NewYearEveGiftView:onClose()
	return
end

function NewYearEveGiftView:onDestroyView()
	self._simageItem:UnLoadImage()
	self._simagesign:UnLoadImage()
	self._simagehead:UnLoadImage()
	self._clickbg:RemoveClickListener()
end

return NewYearEveGiftView
