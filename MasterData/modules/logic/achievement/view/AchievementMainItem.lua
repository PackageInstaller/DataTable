-- chunkname: @modules/logic/achievement/view/AchievementMainItem.lua

module("modules.logic.achievement.view.AchievementMainItem", package.seeall)

local AchievementMainItem = class("AchievementMainItem", ListScrollCellExtend)

function AchievementMainItem:onInitView()
	self._gosingle = gohelper.findChild(self.viewGO, "#go_single")
	self._gogroup = gohelper.findChild(self.viewGO, "#go_group")
	self._gogroup2 = gohelper.findChild(self.viewGO, "#go_group2")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_group/#image_bg")
	self._gogroupcontainer = gohelper.findChild(self.viewGO, "#go_group/#go_groupcontainer")
	self._goupgrade = gohelper.findChild(self.viewGO, "#go_group/#go_upgrade")
	self._goallcollect = gohelper.findChild(self.viewGO, "#go_group/#go_allcollect")
	self._gotop2 = gohelper.findChild(self.viewGO, "#go_group2/go_top2")
	self._simageAchievementGroupBG = gohelper.findChildSingleImage(self.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG")
	self._txtachievementgroupname = gohelper.findChildText(self.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	self._golayout = gohelper.findChild(self.viewGO, "#go_group2/#go_layout")
	self._btnpopup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_group2/go_top2/#btn_popup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainItem:addEvents()
	return
end

function AchievementMainItem:removeEvents()
	return
end

function AchievementMainItem:_btnpopupOnClick()
	local isFold = self._mo:getIsFold()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, self._mo.groupId, not isFold)
end

function AchievementMainItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self._groupBgImage = gohelper.findChildImage(self.viewGO, "#go_group/#image_bg")
	self._iconItems = self:getUserDataTb_()

	self.addEventCb(self, AchievementController.instance, AchievementEvent.OnGroupUpGrade, self._onGroupUpGrade, self)
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, self._onFocusFinished, self)
end

function AchievementMainItem:onDestroy()
	self:recycleIcons()
	self._simagebg:UnLoadImage()
	self._simageAchievementGroupBG:UnLoadImage()
	TaskDispatcher.cancelTask(self.playItemOpenAim, self)
	TaskDispatcher.cancelTask(self.playAchievementUnlockAnim, self)
end

function AchievementMainItem:onUpdateMO(mo)
	if self._mo ~= mo then
		self:recycleIcons()
	end

	self._mo = mo

	self:refreshUI()
end

function AchievementMainItem:refreshUI()
	local isGroup1 = AchievementUtils.isActivityGroup(self._mo.firstAchievementCo.id)
	local isGroup2 = AchievementUtils.isGamePlayGroup(self._mo.firstAchievementCo.id)
	local isSingle = not isGroup1 and not isGroup2

	gohelper.setActive(self._gosingle, isSingle)
	gohelper.setActive(self._gogroup, isGroup1)
	gohelper.setActive(self._gogroup2, isGroup2)

	if isGroup1 then
		self:refreshGroup()
	elseif isGroup2 then
		self:refreshGroup2()
	else
		self:refreshSingle(self._gosingle, 1, self._mo.count)
	end

	self:playAchievementAnim()
end

AchievementMainItem.LockedIconColor = "#4D4D4D"
AchievementMainItem.UnLockedIconColor = "#FFFFFF"
AchievementMainItem.LockedNameAlpha = 0.5
AchievementMainItem.UnLockedNameAlpha = 1
AchievementMainItem.LockedGroupBgColor = "#808080"
AchievementMainItem.UnLockedGroupBgColor = "#FFFFFF"

function AchievementMainItem:refreshSingle(goparent, startIndex, itemCount)
	self:checkInitIcon(itemCount, goparent)

	for i = 1, itemCount do
		local item = self._iconItems[i]
		local go = item.viewGO
		local rect = go.transform
		local achievementIndex = startIndex + i - 1

		recthelper.setAnchor(rect, AchievementMainItem.IconStartX + (i - 1) * AchievementMainItem.IconIntervalX, 0)
		item:setClickCall(self.onClickSingleIcon, self, achievementIndex)

		local achievementCO = self._mo.achievementCfgs[achievementIndex]

		gohelper.setActive(item.viewGO, achievementCO ~= nil)

		if achievementCO then
			local achievementId = achievementCO.id
			local taskCO = AchievementController.instance:getMaxLevelFinishTask(achievementId)

			if taskCO then
				item:setData(taskCO)

				local isLocked = AchievementModel.instance:achievementHasLocked(achievementId)

				item:setIsLocked(isLocked)
				item:setIconColor((isLocked or nil) and (AchievementMainItem.LockedIconColor or AchievementMainItem.UnLockedIconColor))
				item:setNameTxtAlpha((isLocked or nil) and (AchievementMainItem.LockedNameAlpha or AchievementMainItem.UnLockedNameAlpha))
				item:setNameTxtVisible(true)
				item:setSelectIconVisible(false)
				item:setBgVisible(true)
			else
				gohelper.setActive(item.viewGO, false)
			end
		end
	end
end

function AchievementMainItem:refreshGroup()
	local groupCO = AchievementConfig.instance:getGroup(self._mo.groupId)

	if groupCO then
		gohelper.setActive(self._goupgrade, false)
		self:refreshGroupBg(groupCO)
		self:refreshSingleInGroup()
	end
end

function AchievementMainItem:refreshGroup2()
	self._txtachievementgroupname.text = AchievementConfig.instance:getGroupName(self._mo.groupId)

	self._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", self._mo.groupId)))
	self:refreshSingle(self._golayout, 1, self._mo.count)
	gohelper.setActive(self._gotop2, self._mo.isGroupTop)

	self._foldAnimComp = AchievementItemFoldAnimComp.Get(self._btnpopup.gameObject, self._golayout)

	self._foldAnimComp:onUpdateMO(self._mo)
end

function AchievementMainItem:refreshGroupBg(groupCO)
	if groupCO then
		local isUnLockAchievementFinished = AchievementModel.instance:isAchievementTaskFinished(groupCO.unLockAchievement)
		local groupBgUrl = AchievementConfig.instance:getGroupBgUrl(self._mo.groupId, AchievementEnum.GroupParamType.List, isUnLockAchievementFinished)

		self._simagebg:LoadImage(groupBgUrl)

		local isLocked = AchievementModel.instance:achievementGroupHasLocked(self._mo.groupId)

		SLFramework.UGUI.GuiHelper.SetColor(self._groupBgImage, (isLocked or nil) and (AchievementMainItem.LockedGroupBgColor or AchievementMainItem.UnLockedGroupBgColor))
	end
end

function AchievementMainItem:refreshSingleInGroup()
	local idTabs = AchievementConfig.instance:getGroupParamIdTab(self._mo.groupId, AchievementEnum.GroupParamType.List)

	if idTabs then
		if not #idTabs then
			local idCount = 0

			self:checkInitIcon(idCount, self._gogroupcontainer)

			for i = 1, idCount do
				local item = self._iconItems[i]

				item:setClickCall(self.onClickSingleIcon, self, idTabs[i])
				self:_setGroupAchievementPosAndScale(item.viewGO, self._mo.groupId, i)

				local achievementCO = self._mo.achievementCfgs[idTabs[i]]

				gohelper.setActive(item.viewGO, achievementCO ~= nil)

				if achievementCO then
					local achievementId = achievementCO.id
					local taskCO = AchievementController.instance:getMaxLevelFinishTask(achievementId)

					if taskCO then
						item:setData(taskCO)

						local isLocked = AchievementModel.instance:achievementHasLocked(achievementId)

						item:setIsLocked(isLocked)
						item:setIconColor((isLocked or nil) and (AchievementMainItem.LockedIconColor or AchievementMainItem.UnLockedIconColor))
						item:setSelectIconVisible(false)
						item:setNameTxtVisible(false)
						item:setBgVisible(false)
					else
						gohelper.setActive(item.viewGO, false)
					end
				end
			end

			local isGroupFinish = AchievementModel.instance:isGroupFinished(self._mo.groupId)

			gohelper.setActive(self._goallcollect, isGroupFinish)
		end
	end
end

function AchievementMainItem:_setGroupAchievementPosAndScale(go, groupId, index)
	local posX, posY, scaleX, scaleY = AchievementConfig.instance:getAchievementPosAndScaleInGroup(groupId, index, AchievementEnum.GroupParamType.List)

	if go then
		recthelper.setAnchor(go.transform, posX or 0, posY or 0)
		transformhelper.setLocalScale(go.transform, scaleX or 1, scaleY or 1, 1)
	end
end

AchievementMainItem.IconStartX = -535
AchievementMainItem.IconIntervalX = 262

function AchievementMainItem:checkInitIcon(count, parent)
	if #self._iconItems == count then
		return
	end

	local poolView

	if self._view and self._view.viewContainer then
		poolView = self._view.viewContainer:getPoolView()

		if not poolView then
			return
		end
	end

	for i = 1, count do
		local item = poolView:getIcon(parent)

		gohelper.setActive(item.viewGO, true)

		self._iconItems[i] = item
	end
end

function AchievementMainItem:recycleIcons()
	local poolView

	if self._view and self._view.viewContainer then
		poolView = self._view.viewContainer:getPoolView()

		if not poolView then
			return
		end
	end

	if self._iconItems then
		for i, icon in pairs(self._iconItems) do
			poolView:recycleIcon(self._iconItems[i])

			self._iconItems[i] = nil
		end
	end
end

function AchievementMainItem:onClickSingleIcon(index)
	local achievementCO = self._mo.achievementCfgs[index]

	if achievementCO then
		local viewParam = {}

		viewParam.achievementId = achievementCO.id
		viewParam.achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()

		ViewMgr.instance:openView(ViewName.AchievementLevelView, viewParam)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

AchievementMainItem.AnimDelayDelta = 0.06

function AchievementMainItem:playAchievementAnim()
	self:playAchievementOpenAnim()
	TaskDispatcher.cancelTask(self.playAchievementUnlockAnim, self)
	TaskDispatcher.runDelay(self.playAchievementUnlockAnim, self, 0.5)
end

function AchievementMainItem:playAchievementOpenAnim()
	TaskDispatcher.cancelTask(self.playItemOpenAim, self)

	if not self.viewGO.activeInHierarchy then
		return
	end

	local curScrollFocus = AchievementMainTileModel.instance:getScrollFocusIndex()
	local hasPlayOpenAnim = AchievementMainTileModel.instance:hasPlayOpenAnim()

	if curScrollFocus then
		if not hasPlayOpenAnim then
			self._animator:Play("close", 0, 0)

			local delayPlayAnimTime = AchievementMainItem.AnimDelayDelta * Mathf.Clamp(self._index - curScrollFocus, 0, self._index)

			TaskDispatcher.runDelay(self.playItemOpenAim, self, delayPlayAnimTime)
		else
			self._animator:Play("idle", 0, 0)
		end
	else
		self._animator:Play("close", 0, 0)
	end
end

function AchievementMainItem:playItemOpenAim()
	self._animator:Play("open", 0, 0)
end

function AchievementMainItem:_onFocusFinished(viewType)
	if viewType ~= AchievementEnum.ViewType.Tile then
		return
	end

	self:playAchievementAnim()
end

function AchievementMainItem:playAchievementUnlockAnim()
	if self._iconItems then
		for _, v in ipairs(self._iconItems) do
			self:playSingleAchievementUnlockAnim(v)
		end
	end
end

function AchievementMainItem:playSingleAchievementUnlockAnim(achievementIcon)
	if not achievementIcon or not achievementIcon.viewGO or not achievementIcon.viewGO.activeInHierarchy then
		return
	end

	local taskCO = achievementIcon:getTaskCO()
	local achievementId = taskCO and taskCO.achievementId
	local isNew = AchievementModel.instance:achievementHasNew(achievementId)
	local hasShowNewEffect = AchievementMainCommonModel.instance:isAchievementPlayEffect(achievementId)

	if isNew then
		achievementIcon:playAnim((hasShowNewEffect or nil) and (AchievementMainIcon.AnimClip.Loop or AchievementMainIcon.AnimClip.New))
	else
		achievementIcon:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	AchievementMainCommonModel.instance:markAchievementPlayEffect(achievementId)
end

function AchievementMainItem:_onGroupUpGrade(groupId)
	if self._mo.groupId == groupId then
		gohelper.setActive(self._goupgrade, true)
	end
end

return AchievementMainItem
