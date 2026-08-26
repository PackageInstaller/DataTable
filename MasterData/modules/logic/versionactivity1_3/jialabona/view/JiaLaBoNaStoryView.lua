-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaStoryView.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaStoryView", package.seeall)

local JiaLaBoNaStoryView = class("JiaLaBoNaStoryView", BaseView)

function JiaLaBoNaStoryView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btncloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeMask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaStoryView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btncloseMask:AddClickListener(self._btncloseMaskOnClick, self)
end

function JiaLaBoNaStoryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btncloseMask:RemoveClickListener()
end

function JiaLaBoNaStoryView:_btnCloseOnClick()
	self:closeThis()
end

function JiaLaBoNaStoryView:_btncloseMaskOnClick()
	self:closeThis()
end

function JiaLaBoNaStoryView:_editableInitView()
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_Title/txt_TitleEn")

	self._simagePanelBG:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_storybg"))
end

function JiaLaBoNaStoryView:onUpdateParam()
	return
end

function JiaLaBoNaStoryView:onOpen()
	JiaLaBoNaStoryListModel.instance:init(self.viewParam.actId, self.viewParam.episodeId)

	local expiodeCfg = Activity120Config.instance:getEpisodeCo(self.viewParam.actId, self.viewParam.episodeId)

	if expiodeCfg then
		self._txtTitle.text = expiodeCfg.name or ""
	end

	if expiodeCfg then
		self._txtTitleEn.text = expiodeCfg.orderId or ""
	end
end

function JiaLaBoNaStoryView:onClose()
	return
end

function JiaLaBoNaStoryView:onDestroyView()
	self._simagePanelBG:UnLoadImage()
end

return JiaLaBoNaStoryView
