-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9StoryPagePopView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9StoryPagePopView", package.seeall)

local Season123_1_9StoryPagePopView = class("Season123_1_9StoryPagePopView", BaseView)

function Season123_1_9StoryPagePopView:onInitView()
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

function Season123_1_9StoryPagePopView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_1_9StoryPagePopView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123_1_9StoryPagePopView:_btncloseOnClick()
	self:closeThis()
end

function Season123_1_9StoryPagePopView:_editableInitView()
	self.transScrollDesc = self._scrolldesc.gameObject:GetComponent(gohelper.Type_RectTransform)
end

function Season123_1_9StoryPagePopView:onUpdateParam()
	return
end

function Season123_1_9StoryPagePopView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	self.actId = self.viewParam.actId
	self.stageId = self.viewParam.stageId

	self:refreshDetailPageUI()
	self:fitScrollHeight()
end

function Season123_1_9StoryPagePopView:refreshDetailPageUI()
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

Season123_1_9StoryPagePopView.scrollDescHeight = 650
Season123_1_9StoryPagePopView.maxDescSpacing = 41
Season123_1_9StoryPagePopView.minDescSpacing = 35
Season123_1_9StoryPagePopView.minDescFontSize = 27

function Season123_1_9StoryPagePopView:fitScrollHeight()
	local singleAuthorHeight = ZProj.GameHelper.GetTmpLineHeight(self._txtAuthor, 1)
	local heightOffset = self._txtAuthor.preferredHeight - singleAuthorHeight

	recthelper.setHeight(self.transScrollDesc, Season123_1_9StoryPagePopView.scrollDescHeight - heightOffset)
	TaskDispatcher.cancelTask(self.setDescSpacing, self)
	TaskDispatcher.runDelay(self.setDescSpacing, self, 0.01)
end

function Season123_1_9StoryPagePopView:setDescSpacing()
	self._txtdesc.lineSpacing = Mathf.Lerp(Season123_1_9StoryPagePopView.maxDescSpacing, Season123_1_9StoryPagePopView.minDescSpacing, self._txtdesc.fontSize - Season123_1_9StoryPagePopView.minDescFontSize)
end

function Season123_1_9StoryPagePopView:onClose()
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	TaskDispatcher.cancelTask(self.setDescSpacing, self)
end

function Season123_1_9StoryPagePopView:onDestroyView()
	self._simagePolaroid:UnLoadImage()
end

return Season123_1_9StoryPagePopView
