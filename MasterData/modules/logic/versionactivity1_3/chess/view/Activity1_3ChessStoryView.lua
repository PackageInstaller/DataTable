-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessStoryView.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryView", package.seeall)

local Activity1_3ChessStoryView = class("Activity1_3ChessStoryView", BaseView)

function Activity1_3ChessStoryView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btncloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessStoryView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btncloseMask:AddClickListener(self._btncloseMaskOnClick, self)
end

function Activity1_3ChessStoryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btncloseMask:RemoveClickListener()
end

function Activity1_3ChessStoryView:_btnCloseOnClick()
	self:closeThis()
end

function Activity1_3ChessStoryView:_btncloseMaskOnClick()
	self:closeThis()
end

function Activity1_3ChessStoryView:_editableInitView()
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_Title/txt_TitleEn")

	self._simagePanelBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_storybg"))
end

function Activity1_3ChessStoryView:onUpdateParam()
	return
end

function Activity1_3ChessStoryView:onOpen()
	Activity122StoryListModel.instance:init(self.viewParam.actId, self.viewParam.episodeId)

	local expiodeCfg = Activity122Config.instance:getEpisodeCo(self.viewParam.actId, self.viewParam.episodeId)

	if expiodeCfg then
		self._txtTitle.text = expiodeCfg.name or ""
	end

	if expiodeCfg then
		self._txtTitleEn.text = expiodeCfg.orderId or ""
	end
end

function Activity1_3ChessStoryView:onClose()
	return
end

function Activity1_3ChessStoryView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
end

return Activity1_3ChessStoryView
