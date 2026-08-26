-- chunkname: @modules/logic/season/view3_0/Season3_0StoryPagePopView.lua

module("modules.logic.season.view3_0.Season3_0StoryPagePopView", package.seeall)

local Season3_0StoryPagePopView = class("Season3_0StoryPagePopView", BaseView)

function Season3_0StoryPagePopView:onInitView()
	self._godetailPage = gohelper.findChild(self.viewGO, "Root/#go_detailPage")
	self._txtdetailTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	self._simagePolaroid = gohelper.findChildSingleImage(self.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	self._txtdetailPageTitle = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	self._txtAuthor = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	self._goarrow = gohelper.findChild(self.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.scrollDescHeight = 650
	self.maxDescSpacing = 41
	self.minDescSpacing = 35
	self.minDescFontSize = 27

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0StoryPagePopView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season3_0StoryPagePopView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season3_0StoryPagePopView:_btncloseOnClick()
	self:closeThis()
end

function Season3_0StoryPagePopView:_editableInitView()
	self.transScrollDesc = self._scrolldesc.gameObject:GetComponent(gohelper.Type_RectTransform)
end

function Season3_0StoryPagePopView:onUpdateParam()
	return
end

function Season3_0StoryPagePopView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	self.actId = self.viewParam.actId
	self.stageId = self.viewParam.stageId

	self:refreshDetailPageUI()
	self:fitScrollHeight()
end

function Season3_0StoryPagePopView:refreshDetailPageUI()
	local storyConfig = SeasonConfig.instance:getStoryConfig(self.actId, self.stageId)

	self._txtdetailTitle.text = GameUtil.setFirstStrSize(storyConfig.title, 80)

	local iconUrl = SeasonViewHelper.getIconUrl("singlebg/%s/storycover/%s.png", storyConfig.picture, self.actId)

	self._simagePolaroid:LoadImage(iconUrl)

	self._txtdetailPageTitle.text = storyConfig.subTitle
	self._txtAuthor.text = storyConfig.subContent

	gohelper.setActive(self._txtAuthor.gameObject, not string.nilorempty(storyConfig.subContent))
	recthelper.setHeight(self._scrolldesc.gameObject.transform, string.nilorempty(storyConfig.subContent) and 705 or 585)

	self._txtdesc.text = storyConfig.content
end

function Season3_0StoryPagePopView:fitScrollHeight()
	local singleAuthorHeight = ZProj.GameHelper.GetTmpLineHeight(self._txtAuthor, 1)
	local heightOffset = self._txtAuthor.preferredHeight - singleAuthorHeight

	recthelper.setHeight(self.transScrollDesc, self.scrollDescHeight - heightOffset)
	TaskDispatcher.cancelTask(self.setDescSpacing, self)
	TaskDispatcher.runDelay(self.setDescSpacing, self, 0.01)
end

function Season3_0StoryPagePopView:setDescSpacing()
	self._txtdesc.lineSpacing = Mathf.Lerp(self.maxDescSpacing, self.minDescSpacing, self._txtdesc.fontSize - self.minDescFontSize)
end

function Season3_0StoryPagePopView:onClose()
	TaskDispatcher.cancelTask(self.setDescSpacing, self)
end

function Season3_0StoryPagePopView:onDestroyView()
	self._simagePolaroid:UnLoadImage()
end

return Season3_0StoryPagePopView
