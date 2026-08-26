-- chunkname: @modules/logic/achievement/view/AchievementMainListItem.lua

module("modules.logic.achievement.view.AchievementMainListItem", package.seeall)

local AchievementMainListItem = class("AchievementMainListItem", ListScrollCellExtend)

function AchievementMainListItem:onInitView()
	self._gotop1 = gohelper.findChild(self.viewGO, "go_top")
	self._gotop2 = gohelper.findChild(self.viewGO, "go_top2")
	self._txtachievementname = gohelper.findChildText(self.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	self._simageAchievementGroupBG = gohelper.findChildSingleImage(self.viewGO, "go_top2/#simage_AchievementGroupBG")
	self._txtachievementgroupname = gohelper.findChildText(self.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	self._golayout = gohelper.findChild(self.viewGO, "go_layout")
	self._gotaskitem = gohelper.findChild(self.viewGO, "go_layout/go_taskitem")
	self._btnpopup = gohelper.findChildButtonWithAudio(self.viewGO, "go_top2/#btn_popup")
	self._goallcollect = gohelper.findChild(self.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname/#go_allcollect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainListItem:addEvents()
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, self._onFocusFinished, self)
end

function AchievementMainListItem:removeEvents()
	return
end

function AchievementMainListItem:_editableInitView()
	self._taskItemTab = self:getUserDataTb_()
	self._topAnimator = gohelper.onceAddComponent(self._gotop1, gohelper.Type_Animator)
	self._foldAnimComp = AchievementItemFoldAnimComp.Get(self._btnpopup.gameObject, self._gotop1)
end

function AchievementMainListItem:onDestroy()
	self._simageAchievementGroupBG:UnLoadImage()
	self:recycleAchievementMainIcon()
end

function AchievementMainListItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function AchievementMainListItem:refreshUI()
	local achievementCfg = AchievementConfig.instance:getAchievement(self._mo.id)

	if achievementCfg then
		self._groupId = achievementCfg.groupId

		local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
		local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
		local taskConfigList = self._mo:getFilterTaskList(curSortType, curFilterType)

		self:refreshTaskList(taskConfigList)
		self:refreshTopUI(achievementCfg)
		self._foldAnimComp:onUpdateMO(self._mo)
	end
end

local finishTaskDescAlpha = 1
local unfinishTaskDescAlpha = 0.5
local finishTaskExtraDescAlpha = 1
local unfinishTaskExtraDescAlpha = 0.5
local finshTaskIconColor = "#FFFFFF"
local unfinishTaskIconColor = "#4D4D4D"

function AchievementMainListItem:refreshTaskList(taskConfigList)
	local useMap
	local isFold = self._mo:getIsFold()

	gohelper.setActive(self._golayout, not isFold)

	self._hasTaskFinished = false

	if not isFold and taskConfigList then
		useMap = {}

		for index, taskCfg in ipairs(taskConfigList) do
			local taskItem = self:getOrCreateTaskItem(index)

			useMap[taskItem] = true

			local taskMO = AchievementModel.instance:getById(taskCfg.id)
			local taskHasFinished = taskMO and taskMO.hasFinished

			taskItem.txtTaskDesc2.text = taskCfg.extraDesc

			taskItem.taskIcon:setData(taskCfg)
			taskItem.taskIcon:setIconColor((taskHasFinished or nil) and (finshTaskIconColor or unfinishTaskIconColor))
			ZProj.UGUIHelper.SetColorAlpha(taskItem.txtTaskDesc2, (taskHasFinished or nil) and (finishTaskExtraDescAlpha or unfinishTaskExtraDescAlpha))
			ZProj.UGUIHelper.SetColorAlpha(taskItem.txtTaskDesc, (taskHasFinished or nil) and (finishTaskDescAlpha or unfinishTaskDescAlpha))
			gohelper.setActive(taskItem.goUnLockTime, taskHasFinished)
			gohelper.setActive(taskItem.goNormalBG, taskHasFinished)
			gohelper.setActive(taskItem.golockedBG, not taskHasFinished)

			if taskHasFinished then
				taskItem.txtUnLockedTime.text = TimeUtil.localTime2ServerTimeString(taskMO.finishTime)
				taskItem.txtTaskDesc.text = taskCfg.desc
				self._hasTaskFinished = true
			else
				local taskMaxProgress = taskCfg.maxProgress

				if taskMO then
					if not taskMO.progress then
						local taskCurProgress = 0
						local tag = {
							taskCfg.desc,
							taskCurProgress,
							taskMaxProgress
						}

						taskItem.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), tag)
					end
				end
			end

			self:playTaskAnim(taskItem)
			self:tryPlayUpgradeEffect(taskMO, taskItem)
		end
	end

	self:recycleUnuseTaskItem(useMap)
	self:onTasksPlayUpgradeEffectFinished()
end

function AchievementMainListItem:tryPlayUpgradeEffect(taskMO, taskItem)
	if AchievementMainCommonModel.instance:isCurrentScrollFocusing() or not self.viewGO.activeInHierarchy or not taskMO or not taskItem then
		return
	end

	local taskCfg = AchievementConfig.instance:getTask(taskMO.id)

	self._achievementId = taskCfg and taskCfg.achievementId

	local isAchievementPlayEffect = AchievementMainCommonModel.instance:isAchievementPlayEffect(self._achievementId)

	self._isNeedPlayEffect = false

	if taskMO and taskMO.hasFinished and taskMO.isNew and not isAchievementPlayEffect then
		self._isNeedPlayEffect = true
	end

	gohelper.setActive(taskItem.goupgrade, self._isNeedPlayEffect)

	if self._isNeedPlayEffect then
		local hasPlayEffect = AchievementMainCommonModel.instance:isTaskPlayFinishedEffect(taskMO.id)

		taskItem.goupgradeAnimator:Play("upgrade2", 0, hasPlayEffect and 1 or 0)

		if not hasPlayEffect then
			AchievementMainCommonModel.instance:markTaskPlayFinishedEffect(taskMO.id)
		end
	end
end

function AchievementMainListItem:onTasksPlayUpgradeEffectFinished()
	if self._isNeedPlayEffect and self._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(self._achievementId)
	end
end

function AchievementMainListItem:_onFocusFinished(viewType)
	if viewType ~= AchievementEnum.ViewType.List then
		return
	end

	if self._taskItemTab then
		local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
		local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
		local taskConfigList = self._mo:getFilterTaskList(curSortType, curFilterType)

		for index, taskCfg in ipairs(taskConfigList) do
			local taskItem = self:getOrCreateTaskItem(index)
			local taskMO = AchievementModel.instance:getById(taskCfg.id)

			self:tryPlayUpgradeEffect(taskMO, taskItem)
		end

		self:onTasksPlayUpgradeEffectFinished()
	end
end

function AchievementMainListItem:playTaskAnim(taskItem)
	if not taskItem or not taskItem.viewGO.activeInHierarchy then
		return
	end

	local isCurTaskNeedPlayIdleAnim = AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim()

	if isCurTaskNeedPlayIdleAnim then
		taskItem.animator:Play("idle", 0, 0)
	else
		taskItem.animator:Play("open", 0, 0)
	end
end

function AchievementMainListItem:getOrCreateTaskItem(index)
	local taskItem = self._taskItemTab[index]

	if not taskItem then
		taskItem = self:getUserDataTb_()
		taskItem.viewGO = gohelper.cloneInPlace(self._gotaskitem, "task_" .. index)
		taskItem.goNormalBG = gohelper.findChild(taskItem.viewGO, "#go_NormalBG")
		taskItem.golockedBG = gohelper.findChild(taskItem.viewGO, "#go_lockedBG")
		taskItem.txtTaskDesc = gohelper.findChildText(taskItem.viewGO, "Descr/txt_taskdesc")
		taskItem.txtTaskDesc2 = gohelper.findChildText(taskItem.viewGO, "Descr/txt_taskdesc2")
		taskItem.goUnLockTime = gohelper.findChild(taskItem.viewGO, "UnLockedTime")
		taskItem.txtUnLockedTime = gohelper.findChildText(taskItem.viewGO, "UnLockedTime/#txt_UnLockedTime")
		taskItem.goupgrade = gohelper.findChild(taskItem.viewGO, "#go_upgrade")
		taskItem.goupgradeAnimator = gohelper.onceAddComponent(taskItem.goupgrade, gohelper.Type_Animator)
		taskItem.goIcon = gohelper.findChild(taskItem.viewGO, "go_icon")
		taskItem.animator = gohelper.onceAddComponent(taskItem.viewGO, gohelper.Type_Animator)

		if self._view and self._view.viewContainer then
			local poolView = self._view.viewContainer:getPoolView()

			if poolView then
				taskItem.taskIcon = poolView:getIcon(taskItem.goIcon)

				taskItem.taskIcon:setNameTxtVisible(false)
				taskItem.taskIcon:setClickCall(self._iconClickCallBack, self)
			end
		end

		self._taskItemTab[index] = taskItem
	end

	gohelper.setActive(taskItem.viewGO, true)

	return taskItem
end

function AchievementMainListItem:_iconClickCallBack()
	return
end

function AchievementMainListItem:recycleUnuseTaskItem(useMap)
	if useMap and self._taskItemTab then
		for _, taskItem in pairs(self._taskItemTab) do
			if not useMap[taskItem] then
				gohelper.setActive(taskItem.viewGO, false)
			end
		end
	end
end

function AchievementMainListItem:refreshTopUI(achievementCfg)
	local isGroup = achievementCfg and achievementCfg.groupId ~= 0
	local isNeedShowGroupTop = isGroup and self._mo.isGroupTop

	if isNeedShowGroupTop then
		self:refreshGroupTopUI(achievementCfg.groupId)
	end

	local isFold = self._mo:getIsFold()

	if not isFold then
		self:refreshSingleTopUI(achievementCfg)
	end

	gohelper.setActive(self._gotop1, not isFold)
	gohelper.setActive(self._gotop2, isNeedShowGroupTop)

	if not isFold then
		self:playTopAnim()
	end
end

function AchievementMainListItem:playTopAnim()
	if not self._gotop1.activeInHierarchy then
		return
	end

	local isCurTaskNeedPlayIdleAnim = AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim()

	if isCurTaskNeedPlayIdleAnim then
		self._topAnimator:Play("idle", 0, 0)
	else
		self._topAnimator:Play("open", 0, 0)
	end
end

local hasGetAchievementTitleAlpha = 1
local unGetAchievementTitleAlpha = 0.5

function AchievementMainListItem:refreshSingleTopUI(achievementCfg)
	if achievementCfg then
		self._txtachievementname.text = achievementCfg.name

		if self._hasTaskFinished then
			if not hasGetAchievementTitleAlpha then
				local targetTitleAlpha = unGetAchievementTitleAlpha

				ZProj.UGUIHelper.SetColorAlpha(self._txtachievementname, targetTitleAlpha)
			end
		end
	end
end

function AchievementMainListItem:refreshGroupTopUI(groupId)
	self._txtachievementgroupname.text = AchievementConfig.instance:getGroupName(groupId)

	local isGroupFinish = AchievementModel.instance:isGroupFinished(groupId)

	gohelper.setActive(self._goallcollect, groupId > 100 and isGroupFinish)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtachievementgroupname, (groupId > 100 or nil) and AchievementConfig.instance:getGroupTitleColorConfig(groupId, AchievementEnum.GroupParamType.Player))
	self._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", groupId)))
end

function AchievementMainListItem:recycleAchievementMainIcon()
	if self._taskItemTab then
		for _, taskItem in pairs(self._taskItemTab) do
			taskItem.taskIcon:dispose()
		end
	end
end

return AchievementMainListItem
