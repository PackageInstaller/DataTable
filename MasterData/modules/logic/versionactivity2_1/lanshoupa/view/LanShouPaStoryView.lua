-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaStoryView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaStoryView", package.seeall)

local LanShouPaStoryView = class("LanShouPaStoryView", BaseView)

function LanShouPaStoryView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btncloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaStoryView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btncloseMask:AddClickListener(self._btncloseMaskOnClick, self)
end

function LanShouPaStoryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btncloseMask:RemoveClickListener()
end

function LanShouPaStoryView:_btnCloseOnClick()
	self:closeThis()
end

function LanShouPaStoryView:_btncloseMaskOnClick()
	self:closeThis()
end

function LanShouPaStoryView:_editableInitView()
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_Title/txt_TitleEn")
end

function LanShouPaStoryView:onOpen()
	LanShouPaStoryListModel.instance:init(self.viewParam.actId, self.viewParam.episodeId)

	local expiodeCfg = Activity164Config.instance:getEpisodeCo(self.viewParam.actId, self.viewParam.episodeId)
	local list = Activity164Config.instance:getEpisodeCoList(self.viewParam.actId)
	local index = tabletool.indexOf(list, expiodeCfg)

	if expiodeCfg then
		self._txtTitle.text = expiodeCfg.name or ""
	end

	self._txtTitleEn.text = string.format("STAGE %02d", index)
end

function LanShouPaStoryView:onClose()
	return
end

function LanShouPaStoryView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
end

return LanShouPaStoryView
