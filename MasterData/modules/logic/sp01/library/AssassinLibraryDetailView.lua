-- chunkname: @modules/logic/sp01/library/AssassinLibraryDetailView.lua

module("modules.logic.sp01.library.AssassinLibraryDetailView", package.seeall)

local AssassinLibraryDetailView = class("AssassinLibraryDetailView", BaseView)

function AssassinLibraryDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "root/#simage_Pic")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#txt_title")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_content")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#scroll_content/Viewport/#go_content")
	self._txtcontent = gohelper.findChildText(self.viewGO, "root/#scroll_content/Viewport/#go_content/#txt_content")
	self._goarrow = gohelper.findChild(self.viewGO, "root/#scroll_content/#go_arrow")
	self._btndialogue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Dialogue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btndialogue:AddClickListener(self._btndialogueOnClick, self)
	self._scrollcontent:AddOnValueChanged(self._onContentScrollValueChanged, self)
end

function AssassinLibraryDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btndialogue:RemoveClickListener()
	self._scrollcontent:RemoveOnValueChanged()
end

function AssassinLibraryDetailView:_btncloseOnClick()
	self:closeThis()
end

function AssassinLibraryDetailView:_btndialogueOnClick()
	if self._dialogId and self._dialogId ~= 0 then
		DialogueController.instance:enterDialogue(self._dialogId)
		OdysseyStatHelper.instance:sendLibraryDialogueClick("_btndialogueOnClick#" .. self._libraryId)
	end
end

function AssassinLibraryDetailView:_editableInitView()
	return
end

function AssassinLibraryDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_openmap)
	self:refresh()
	OdysseyStatHelper.instance:initViewStartTime()
end

function AssassinLibraryDetailView:onUpdateParam()
	self:refresh()
end

function AssassinLibraryDetailView:refresh()
	self._libraryId = self.viewParam and self.viewParam.libraryId
	self._libraryCo = AssassinConfig.instance:getLibrarConfig(self._libraryId)

	if self._libraryCo then
		self._txttitle.text = self._libraryCo.title or ""
	end

	if self._libraryCo then
		self._txtcontent.text = self._libraryCo.content or ""
	end

	self._simagepic:LoadImage(ResUrl.getSp01AssassinSingleBg("library/assassinlibrary_detail_pic/" .. self._libraryCo.detail))
	ZProj.UGUIHelper.RebuildLayout(self._gocontent.transform)

	local contentHeight = recthelper.getHeight(self._gocontent.transform)
	local scrollHeight = recthelper.getHeight(self._scrollcontent.transform)

	self._couldScroll = scrollHeight < contentHeight

	gohelper.setActive(self._goarrow, self._couldScroll)

	self._dialogId = self._libraryCo and self._libraryCo.talk

	gohelper.setActive(self._btndialogue.gameObject, self._dialogId and self._dialogId ~= 0)
end

function AssassinLibraryDetailView:_onContentScrollValueChanged(value)
	gohelper.setActive(self._goarrow, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollcontent.verticalNormalizedPosition) > 0)
end

function AssassinLibraryDetailView:onClose()
	self._simagepic:UnLoadImage()
	AssassinLibraryModel.instance:readLibrary(self._libraryId)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("AssassinLibraryDetailView", self._libraryId)
end

function AssassinLibraryDetailView:onDestroyView()
	return
end

return AssassinLibraryDetailView
