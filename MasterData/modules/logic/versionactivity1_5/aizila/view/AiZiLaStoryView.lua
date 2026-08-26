-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaStoryView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryView", package.seeall)

local AiZiLaStoryView = class("AiZiLaStoryView", BaseView)

function AiZiLaStoryView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btncloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaStoryView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btncloseMask:AddClickListener(self._btncloseMaskOnClick, self)
end

function AiZiLaStoryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btncloseMask:RemoveClickListener()
end

function AiZiLaStoryView:_btnCloseOnClick()
	self:closeThis()
end

function AiZiLaStoryView:_btncloseMaskOnClick()
	self:closeThis()
end

function AiZiLaStoryView:_editableInitView()
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_Title/txt_TitleEn")
end

function AiZiLaStoryView:onUpdateParam()
	return
end

function AiZiLaStoryView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btnCloseOnClick, self)
	end

	self._episodeId = self.viewParam.episodeId
	self._actId = self.viewParam.actId
	self._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(self._actId, self._episodeId)

	AiZiLaStoryListModel.instance:init(self._actId, self._episodeId)
	self:refreshUI()
end

function AiZiLaStoryView:onClose()
	return
end

function AiZiLaStoryView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
end

function AiZiLaStoryView:refreshUI()
	if self._episodeCfg then
		self._txtTitle.text = self._episodeCfg.name
		self._txtTitleEn.text = self._episodeCfg.nameen
	end
end

return AiZiLaStoryView
