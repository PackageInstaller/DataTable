-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneThemeStoryItem.lua

module("modules.logic.college.view.milestone.CollegeMilestoneThemeStoryItem", package.seeall)

local CollegeMilestoneThemeStoryItem = class("CollegeMilestoneThemeStoryItem", SimpleListItem)

function CollegeMilestoneThemeStoryItem:onInit()
	self._goLock = gohelper.findChild(self.viewGO, "go_Lock")
	self._goUnlock = gohelper.findChild(self.viewGO, "go_Unlock")
	self._goActive = gohelper.findChild(self.viewGO, "go_Active")
	self._txtTitle = gohelper.findChildText(self.viewGO, "go_Active/#txt_Title")
	self._txtItemNum = gohelper.findChildText(self.viewGO, "go_Unlock/#txt_ItemNum")
	self._imageItemIcon = gohelper.findChildImage(self.viewGO, "go_Unlock/#txt_ItemNum/image_icon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_Click")
	self._goNew = gohelper.findChild(self.viewGO, "#go_reddot")
	self._mileStoneBox = CollegeModel.instance:getSceneMo().milestoneBox
	self._costComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtItemNum.gameObject, CollegeCostComp)

	self._costComp:setIconAndTxt(self._imageItemIcon, self._txtItemNum)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = gohelper.findComponentAnim(self.viewGO)

	local comp = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.MaterialPropsCtrl))

	comp.enabled = true
end

function CollegeMilestoneThemeStoryItem:onAddListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnStoryPlayEnd, self._onStoryPlayEnd, self)
end

function CollegeMilestoneThemeStoryItem:onRemoveListeners()
	self._btnClick:RemoveClickListener()
end

function CollegeMilestoneThemeStoryItem:_btnClickOnClick()
	if self._status == CollegeEnum.StoryNodeStatus.Active then
		CollegeStoryHelper.instance:playStory(self._storyId, true)
	elseif self._status == CollegeEnum.StoryNodeStatus.Unlocked then
		if not CollegeModel.instance:isEnoughItems(self._storyCo.unlockCost) then
			GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

			return
		else
			CollegeRpc.instance:sendCollegeMilestoneActiveNode(self._storyId)
		end
	end
end

function CollegeMilestoneThemeStoryItem:onItemShow(storyCo)
	self._preStoryId = self._storyId
	self._preStatus = self._status
	self._storyCo = storyCo
	self._storyId = storyCo.id
	self._themeMo = self._mileStoneBox.themeMap[storyCo.themeId]
	self._status = self._themeMo and self._themeMo:getNodeStatus(self._storyId)
	self._status = self._status or CollegeEnum.StoryNodeStatus.Locked

	self:initRedDot()
	self:refreshUI()
	self._animator:Play("idle", 0, 0)
end

function CollegeMilestoneThemeStoryItem:initRedDot()
	if self._redDotStoryCo and self._redDotStoryCo == self._storyCo then
		return
	end

	self._redDotStoryCo = self._storyCo

	RedDotController.instance:addRedDot(self._goNew, RedDotEnum.DotNode.CollegeMileStoneStory, self._storyId)
end

function CollegeMilestoneThemeStoryItem:refreshUI()
	if self._preStoryId == self._storyId and self._preStatus ~= self._status and self._status == CollegeEnum.StoryNodeStatus.Active then
		self:_tryPlayActiveAnim()

		return
	end

	self:forceRefreshUI()
end

function CollegeMilestoneThemeStoryItem:forceRefreshUI()
	gohelper.setActive(self._goLock, self._status == CollegeEnum.StoryNodeStatus.Locked)
	gohelper.setActive(self._goUnlock, self._status == CollegeEnum.StoryNodeStatus.Unlocked)
	gohelper.setActive(self._goActive, self._status == CollegeEnum.StoryNodeStatus.Active)

	if self._status == CollegeEnum.StoryNodeStatus.Active then
		self._txtTitle.text = self._storyCo.title
	elseif self._status == CollegeEnum.StoryNodeStatus.Unlocked then
		self._costComp:setCost(self._storyCo.unlockCost)
	end
end

function CollegeMilestoneThemeStoryItem:_tryPlayActiveAnim()
	if CollegeStoryHelper.instance:isPlayingStory() then
		self._waitRefresh = true

		return
	end

	GameUtil.setActiveUIBlock("CollegeMilestoneThemeStoryItem", true, false)

	self._waitRefresh = false

	self._animatorPlayer:Play("active", self._onPlayActiveAnimDone, self)

	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(self.viewGO.transform)

	CollegeController.instance:dispatchEvent(CollegeEvent.PlayMilestoneEffect, screenPosX, screenPosY)
end

function CollegeMilestoneThemeStoryItem:_onPlayActiveAnimDone()
	self:forceRefreshUI()
	GameUtil.setActiveUIBlock("CollegeMilestoneThemeStoryItem", false, true)
end

function CollegeMilestoneThemeStoryItem:_onStoryPlayEnd()
	if not self._waitRefresh then
		return
	end

	self:_tryPlayActiveAnim()
end

function CollegeMilestoneThemeStoryItem:onDestroy()
	GameUtil.setActiveUIBlock("CollegeMilestoneThemeStoryItem", false, true)
end

return CollegeMilestoneThemeStoryItem
