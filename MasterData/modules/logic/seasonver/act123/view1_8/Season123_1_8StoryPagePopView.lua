-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8StoryPagePopView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8StoryPagePopView", package.seeall)

local Season123_1_8StoryPagePopView = class("Season123_1_8StoryPagePopView", BaseView)

function Season123_1_8StoryPagePopView:onInitView()
	self._godetailPage = gohelper.findChild(self.viewGO, "Root/#go_detailPage")
	self._txtdetailTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	self._simagePolaroid = gohelper.findChildSingleImage(self.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	self._txtdetailPageTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	self._txtAuthor = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	self._goarrow = gohelper.findChild(self.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8StoryPagePopView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_1_8StoryPagePopView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123_1_8StoryPagePopView:_btncloseOnClick()
	self:closeThis()
end

function Season123_1_8StoryPagePopView:_editableInitView()
	return
end

function Season123_1_8StoryPagePopView:onUpdateParam()
	return
end

function Season123_1_8StoryPagePopView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	self.actId = self.viewParam.actId
	self.stageId = self.viewParam.stageId

	self:refreshDetailPageUI()
end

function Season123_1_8StoryPagePopView:refreshDetailPageUI()
	local storyConfig = Season123Config.instance:getStoryConfig(self.actId, self.stageId)

	self._txtdetailTitle.text = GameUtil.setFirstStrSize(storyConfig.title, 80)

	local iconUrl = Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", storyConfig.picture, self.actId)

	self._simagePolaroid:LoadImage(iconUrl)

	self._txtdetailPageTitle.text = storyConfig.subTitle
	self._txtAuthor.text = storyConfig.subContent

	gohelper.setActive(self._txtAuthor.gameObject, not string.nilorempty(storyConfig.subContent))
	recthelper.setHeight(self._scrolldesc.gameObject.transform, string.nilorempty(storyConfig.subContent) and 705 or 585)

	self._txtdesc.text = storyConfig.content
end

function Season123_1_8StoryPagePopView:onClose()
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
end

function Season123_1_8StoryPagePopView:onDestroyView()
	self._simagePolaroid:UnLoadImage()
end

return Season123_1_8StoryPagePopView
