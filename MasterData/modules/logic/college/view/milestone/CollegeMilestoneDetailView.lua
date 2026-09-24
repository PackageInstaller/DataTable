-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneDetailView.lua

module("modules.logic.college.view.milestone.CollegeMilestoneDetailView", package.seeall)

local CollegeMilestoneDetailView = class("CollegeMilestoneDetailView", BaseView)
local TitleFirstWordFontSize = 70

function CollegeMilestoneDetailView:onInitView()
	self._goDetail = gohelper.findChild(self.viewGO, "root/#go_Detail")
	self._simageThemeIcon = gohelper.findChildSingleImage(self.viewGO, "root/#go_Detail/#go_ListItemRoot/#simage_ThemeIcon")
	self._txtThemeTitle = gohelper.findChildText(self.viewGO, "root/#go_Detail/titledec/#txt_ThemeTitle")
	self._txtThemeProgress = gohelper.findChildText(self.viewGO, "root/#go_Detail/#txt_ThemeProgress")
	self._btnArrowRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Detail/#btn_ArrowRight")
	self._goRightRedDot = gohelper.findChild(self.viewGO, "root/#go_Detail/#btn_ArrowRight/#go_RightRedDot")
	self._btnArrowLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Detail/#btn_ArrowLeft")
	self._goLeftRedDot = gohelper.findChild(self.viewGO, "root/#go_Detail/#btn_ArrowLeft/#go_LeftRedDot")
	self._goItemRoot = gohelper.findChild(self.viewGO, "root/#go_Detail/#go_ListItemRoot")
	self._goStory = gohelper.findChild(self.viewGO, "root/#go_Detail/#scroll_Story")
	self._goStoryContent = gohelper.findChild(self.viewGO, "root/#go_Detail/#scroll_Story/Viewport/Content")
	self._goStoryItem = gohelper.findChild(self.viewGO, "root/#go_Detail/#scroll_Story/Viewport/Content/#go_StoryItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeMilestoneDetailView:addEvents()
	self._btnArrowRight:AddClickListener(self._btnArrowRightOnClick, self)
	self._btnArrowLeft:AddClickListener(self._btnArrowLeftOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnSelectTheme, self._onSelectTheme, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.MilestoneUpdate, self._onMilestoneUpdate, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.PlayMilestoneEffect, self._playMilestoneEffect, self)
end

function CollegeMilestoneDetailView:removeEvents()
	self._btnArrowRight:RemoveClickListener()
	self._btnArrowLeft:RemoveClickListener()
end

function CollegeMilestoneDetailView:_btnArrowRightOnClick()
	self:switchTheme(false)
end

function CollegeMilestoneDetailView:_btnArrowLeftOnClick()
	self:switchTheme(true)
end

function CollegeMilestoneDetailView:switchTheme(isLeft)
	if isLeft then
		if not (self._selectIndex - 1) then
			local targetIndex = self._selectIndex + 1
			local targetThemeMo = self._themeList[targetIndex]

			if not targetThemeMo then
				return
			end

			GameUtil.setActiveUIBlock(self.viewName, true, false)

			self._switchTargetIndex = targetIndex

			local switchAnim = isLeft and "switch_left" or "switch_right"

			self._detailAnimator:Play(switchAnim, 0, 0)
			TaskDispatcher.runDelay(self._onPlaySwitchAnimDone, self, 0.3)
		end
	end
end

function CollegeMilestoneDetailView:_onPlaySwitchAnimDone()
	GameUtil.setActiveUIBlock(self.viewName, false, true)

	local targetThemeMo = self._themeList[self._switchTargetIndex]

	CollegeController.instance:dispatchEvent(CollegeEvent.OnSelectTheme, self._switchTargetIndex, targetThemeMo)
end

function CollegeMilestoneDetailView:_editableInitView()
	self._goLeftBtn = self._btnArrowLeft.gameObject
	self._goRightBtn = self._btnArrowRight.gameObject

	gohelper.setActive(self._goDetail, false)

	self._leftRedDot = RedDotController.instance:addNotEventRedDot(self._goLeftRedDot, self._checkIsLeftThemeUnlock, self)
	self._rightRedDot = RedDotController.instance:addNotEventRedDot(self._goRightRedDot, self._checkIsRightThemeUnlock, self)
	self._detailAnimator = gohelper.onceAddComponent(self._goDetail, gohelper.Type_Animator)
	self._iconAnimator = gohelper.onceAddComponent(self._goItemRoot, gohelper.Type_Animator)
	self._mileStoneBox = CollegeModel.instance:getSceneMo().milestoneBox
	self._goFlyEffect = gohelper.findChild(self.viewGO, "root/fly")
	self._flyEffectComp = self._goFlyEffect:GetComponent(typeof(UnityEngine.UI.UIFlying))

	gohelper.setActive(self._goFlyEffect, false)
end

function CollegeMilestoneDetailView:onOpen()
	self._themeList = self.viewContainer:getThemeList()

	if self._themeList then
		self._allThemeNum = #self._themeList or 0
	end
end

function CollegeMilestoneDetailView:refreshTheme(selectIndex, focusUnlock)
	self._selectIndex = selectIndex
	self._selectThemeMo = self._themeList[selectIndex]
	self._focusUnlock = focusUnlock

	self:refreshStoryList()
	self:refreshBtns()
end

function CollegeMilestoneDetailView:refreshStoryList()
	if not self._storyListComp then
		local listParam = SimpleListParam.New()

		listParam.cellClass = CollegeMilestoneThemeStoryItem
		listParam.lineCount = 2
		listParam.cellWidth = 525
		listParam.cellHeight = 120
		listParam.cellSpaceH = 0
		listParam.cellSpaceV = 0
		listParam.scrollDir = ScrollEnum.ScrollDirV

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._storyListComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goStory, SimpleListComp, scrollParam)

		self._storyListComp:setRes(self._goStoryItem)
		self._storyListComp:onCreate()
	end

	self._storyCoList = CollegeConfig.instance:getStoryListByThemeId(self._selectThemeMo.id)

	if self._storyCoList then
		self._allStoryNum = #self._storyCoList or 0
	end

	self._storyListComp:setData(self._storyCoList)

	self._txtThemeTitle.text = GameUtil.setFirstStrSize(self._selectThemeMo.co.title, TitleFirstWordFontSize)
	self._txtThemeProgress.text = string.format("<#FFEA73><size=63>%s</size></color>/%s", self._selectThemeMo:getActiveCount(), self._allStoryNum)

	self._simageThemeIcon:LoadImage(ResUrl.getCollegeSingleBg("milestone_stone" .. self._selectThemeMo.co.pic, "milestone"))
	self:checkPlayUnlockAnim()
end

function CollegeMilestoneDetailView:checkPlayUnlockAnim()
	self._iconAnimator:Play("idle", 0, 0)

	if self._storyCoList then
		for i, storyCo in ipairs(self._storyCoList) do
			local themeMo = self._mileStoneBox.themeMap[storyCo.themeId]

			if themeMo and themeMo:getNodeStatus(storyCo.id) == CollegeEnum.StoryNodeStatus.Unlocked then
				self._iconAnimator:Play("unlock", 0, 0)

				if self._focusUnlock then
					local lineCount = self._storyListComp.param.lineCount
					local lineIndex = lineCount ~= 0 and math.ceil(i / lineCount) or i

					self._storyListComp:moveTo(lineIndex)
				end

				return true
			end
		end
	end
end

function CollegeMilestoneDetailView:refreshBtns()
	gohelper.setActive(self._goLeftBtn, self._selectIndex > 1)
	gohelper.setActive(self._goRightBtn, self._selectIndex < self._allThemeNum)
	self._leftRedDot:refreshRedDot()
	self._rightRedDot:refreshRedDot()
end

function CollegeMilestoneDetailView:_onSelectTheme(themeIndex)
	self:refreshTheme(themeIndex, true)
end

function CollegeMilestoneDetailView:_onMilestoneUpdate()
	self:refreshTheme(self._selectIndex)
end

function CollegeMilestoneDetailView:_checkIsLeftThemeUnlock()
	return self:_isTargetThemeAreaUnlock(true)
end

function CollegeMilestoneDetailView:_checkIsRightThemeUnlock()
	return self:_isTargetThemeAreaUnlock(false)
end

function CollegeMilestoneDetailView:_isTargetThemeAreaUnlock(isLeft)
	if not self._selectIndex then
		return
	end

	local startIndex = isLeft and 1 or self._selectIndex + 1

	if isLeft then
		if not (self._selectIndex - 1) then
			local endIndex = self._allThemeNum

			for i = startIndex, endIndex do
				local themeMo = self._themeList[i]

				if themeMo then
					::label_18_0::

					local storyList = CollegeConfig.instance:getStoryListByThemeId(themeMo.id)

					if storyList then
						for _, storyCo in ipairs(storyList) do
							if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.CollegeMileStoneStory, storyCo.id) then
								return true
							end
						end
					end
				end
			end
		end
	end
end

function CollegeMilestoneDetailView:_playMilestoneEffect(screenStartPosX, screenStartPosY)
	local posX, posY = recthelper.screenPosToAnchorPos2(Vector2(screenStartPosX, screenStartPosY), self.viewGO.transform)

	self._flyEffectComp.startPosition = Vector2(posX, posY)

	gohelper.setActive(self._goFlyEffect, true)
	self._flyEffectComp:StartFlying()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.UnlockStory)
	TaskDispatcher.cancelTask(self._hideFlyEffect, self)
	TaskDispatcher.runDelay(self._hideFlyEffect, self, 1)
end

function CollegeMilestoneDetailView:_hideFlyEffect()
	gohelper.setActive(self._goFlyEffect, false)
end

function CollegeMilestoneDetailView:onClose()
	TaskDispatcher.cancelTask(self._onPlaySwitchAnimDone, self)
	TaskDispatcher.cancelTask(self._hideFlyEffect, self)
	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

function CollegeMilestoneDetailView:onDestroyView()
	self._simageThemeIcon:UnLoadImage()
end

return CollegeMilestoneDetailView
