-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneThemeItem.lua

module("modules.logic.college.view.milestone.CollegeMilestoneThemeItem", package.seeall)

local CollegeMilestoneThemeItem = class("CollegeMilestoneThemeItem", SimpleListItem)
local csTweenHelper = ZProj.TweenHelper

CollegeMilestoneThemeItem.ScalerSelected = 1
CollegeMilestoneThemeItem.ScalerSelectedAdjacent = 0.67
CollegeMilestoneThemeItem.ScalerNormal = 0.67

local TitleFirstWordFontSize = 64

function CollegeMilestoneThemeItem:onInit(viewGO)
	self.viewGO = viewGO
	self.tran = self.viewGO.transform
	self._simageThemeIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#simage_panebg")
	self._simageThemeMask = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#go_Unselect/#simage_panebgmask")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_Root/titlebg/#txt_title")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Root/Image_numbg/#txt_num")
	self._goUnselect = gohelper.findChild(self.viewGO, "#go_Root/#go_Unselect")
	self._goNew = gohelper.findChild(self.viewGO, "#go_Root/#go_Unlock/#go_reddot")
	self._goUnlock = gohelper.findChild(self.viewGO, "#go_Root/#go_Unlock")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Click")

	gohelper.setActive(self._goUnselect, true)
	gohelper.setActive(self._goUnlock, false)

	self._imageThemeMask = self._simageThemeMask:GetComponent(gohelper.Type_Image)

	self:setScale(CollegeMilestoneThemeItem.ScalerSelectedAdjacent)
end

function CollegeMilestoneThemeItem:onAddListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function CollegeMilestoneThemeItem:onRemoveListeners()
	self._btnClick:RemoveClickListener()
end

function CollegeMilestoneThemeItem:_btnClickOnClick()
	CollegeController.instance:dispatchEvent(CollegeEvent.OnSelectTheme, self._index)
end

function CollegeMilestoneThemeItem:onUpdateMO(themeMo)
	self._themeMo = themeMo
	self._themeCo = themeMo.co
	self._themeId = self._themeCo.id
	self._activeCount = themeMo:getActiveCount()
	self._storyNum = themeMo.storyNum

	self:initRedDot()
	self:refreshUI()
end

function CollegeMilestoneThemeItem:setIndex(index)
	self._index = index
end

function CollegeMilestoneThemeItem:initRedDot()
	if self._redDotThemeCo and self._themeCo == self._redDotThemeCo then
		return
	end

	RedDotController.instance:addRedDotTag(self.viewGO, RedDotEnum.DotNode.CollegeMileStoneStory, nil, self._redDotCallback, self)

	self._redDotThemeCo = self._themeCo
end

function CollegeMilestoneThemeItem:_redDotCallback()
	gohelper.setActive(self._goUnlock, false)

	local storyList = CollegeConfig.instance:getStoryListByThemeId(self._themeId)

	for _, storyCo in ipairs(storyList or {}) do
		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CollegeMileStoneStory, storyCo.id) then
			gohelper.setActive(self._goUnlock, true)

			return
		end
	end
end

function CollegeMilestoneThemeItem:refreshUI()
	self._txtTitle.text = GameUtil.setFirstStrSize(self._themeCo.title, TitleFirstWordFontSize)
	self._txtNum.text = string.format("<size=62><#000000>%s</color></size>/%s", self._activeCount, self._storyNum)

	local iconName = string.format("milestone_stone%s", self._themeCo.pic)
	local maskIconName = string.format("milestone_stonemask%s", self._themeCo.pic)

	self._simageThemeIcon:LoadImage(ResUrl.getCollegeSingleBg(iconName, "milestone"))
	self._simageThemeMask:LoadImage(ResUrl.getCollegeSingleBg(maskIconName, "milestone"))
end

function CollegeMilestoneThemeItem:onSelect(isSelect)
	gohelper.setActive(self._goUnselect, true)
	ZProj.UGUIHelper.SetColorAlpha(self._imageThemeMask, isSelect and 0 or 1)
end

function CollegeMilestoneThemeItem:setScale(s, isAnim)
	if isAnim then
		self:tweenScale(s)
	elseif not self._tweenRotationId then
		transformhelper.setLocalScale(self.tran, s, s, s)
	end
end

function CollegeMilestoneThemeItem:setScale01(s)
	ZProj.UGUIHelper.SetColorAlpha(self._imageThemeMask, 1 - s)

	s = s or 1
	s = GameUtil.remap(s, 0, 1, CollegeMilestoneThemeItem.ScalerSelectedAdjacent, CollegeMilestoneThemeItem.ScalerSelected)

	self:setScale(s)
end

function CollegeMilestoneThemeItem:tweenScale(s, duration)
	duration = duration or 0.4

	self:_killTween()

	self._tweenRotationId = csTweenHelper.DOScale(self.tran, s, s, s, duration, self._onTweenEnd, self, nil, EaseType.OutQuad)
end

function CollegeMilestoneThemeItem:_onTweenEnd()
	self._tweenRotationId = nil
end

function CollegeMilestoneThemeItem:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenRotationId")
end

function CollegeMilestoneThemeItem:getPos()
	return recthelper.getAnchor(self.tran)
end

function CollegeMilestoneThemeItem:onDestroy()
	self:_killTween()
	self._simageThemeIcon:UnLoadImage()
	self._simageThemeMask:UnLoadImage()
end

return CollegeMilestoneThemeItem
