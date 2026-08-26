-- chunkname: @modules/logic/achievement/view/AchievementNamePlateListItem.lua

module("modules.logic.achievement.view.AchievementNamePlateListItem", package.seeall)

local AchievementNamePlateListItem = class("AchievementNamePlateListItem", ListScrollCellExtend)

function AchievementNamePlateListItem:onInitView()
	self._gotop1 = gohelper.findChild(self.viewGO, "go_top")
	self._gotop2 = gohelper.findChild(self.viewGO, "go_top2")
	self._txtachievementname = gohelper.findChildText(self.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	self._golayout1 = gohelper.findChild(self.viewGO, "go_layout")
	self._golayout = gohelper.findChild(self.viewGO, "go_layout_misihai")
	self._gotaskitem = gohelper.findChild(self.viewGO, "go_layout_misihai/go_taskitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementNamePlateListItem:addEvents()
	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, self._onFocusFinished, self)
end

function AchievementNamePlateListItem:removeEvents()
	return
end

function AchievementNamePlateListItem:_editableInitView()
	self._taskItemTab = self:getUserDataTb_()
	self._topAnimator = gohelper.onceAddComponent(self._gotop1, gohelper.Type_Animator)

	gohelper.setActive(self._golayout1, false)
	gohelper.setActive(self._gotop2, false)
end

function AchievementNamePlateListItem:onDestroy()
	self:recycleAchievementMainIcon()
end

function AchievementNamePlateListItem:onUpdateMO(mo)
	if AchievementMainCommonModel.instance:getCurrentViewType() ~= AchievementEnum.ViewType.List then
		return
	end

	self._mo = mo

	self:refreshUI()
end

function AchievementNamePlateListItem:refreshUI()
	local isNamePlate = AchievementMainCommonModel.instance:checkIsNamePlate()

	if not isNamePlate then
		return
	end

	local achievementCfg = AchievementConfig.instance:getAchievement(self._mo.id)

	if achievementCfg then
		self._groupId = achievementCfg.groupId

		local curSortType = AchievementMainCommonModel.instance:getCurrentSortType()
		local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
		local taskConfigList = self._mo:getFilterTaskList(curSortType, curFilterType)

		self:refreshTaskList(taskConfigList)
		self:refreshTopUI(achievementCfg)
	end
end

local finishTaskDescAlpha = 1
local unfinishTaskDescAlpha = 0.5
local finishTaskExtraDescAlpha = 1
local unfinishTaskExtraDescAlpha = 0.5

function AchievementNamePlateListItem:refreshTaskList(taskConfigList)
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
				local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
				local taskMaxProgress, taskCurProgress
				local listenerType = taskCfg.listenerType
				local selfMaxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
				local num

				if listenerType and listenerType == "TowerPassLayer" then
					if taskCfg.listenerParam and not string.nilorempty(taskCfg.listenerParam) then
						local temp = string.split(taskCfg.listenerParam, "#")

						num = temp and temp[3]
						num = num * 10
					end
				else
					num = taskCfg and taskCfg.maxProgress
				end

				taskMaxProgress = num
				taskCurProgress = num < selfMaxProgress and num or selfMaxProgress

				local tag = {
					taskCfg.desc,
					taskCurProgress,
					taskMaxProgress
				}

				taskItem.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), tag)
			end

			self:_refreshIcon(taskItem.levelItemList[index], taskCfg)
			self:playTaskAnim(taskItem)
			self:tryPlayUpgradeEffect(taskMO, taskItem)
		end
	end

	self:recycleUnuseTaskItem(useMap)
	self:onTasksPlayUpgradeEffectFinished()
end

function AchievementNamePlateListItem:_refreshIcon(item, taskCfg)
	local taskMO = AchievementModel.instance:getById(taskCfg.id)
	local prefabName, titlebgName, bgName

	if taskCfg.image and not string.nilorempty(taskCfg.image) then
		local temp = string.split(taskCfg.image, "#")

		prefabName = temp[1]
		titlebgName = temp[2]
		bgName = temp[3]
	end

	item.simagebg:LoadImage(ResUrl.getAchievementIcon(bgName))
	item.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))

	local listenerType = taskCfg.listenerType
	local achievementCfg = AchievementConfig.instance:getAchievement(taskCfg.achievementId)
	local maxProgress = AchievementUtils.getAchievementProgressBySourceType(achievementCfg.rule)
	local num

	if listenerType and listenerType == "TowerPassLayer" then
		if taskCfg.listenerParam and not string.nilorempty(taskCfg.listenerParam) then
			local temp = string.split(taskCfg.listenerParam, "#")

			num = temp and temp[3]
			num = num * 10
		end
	else
		num = taskCfg and taskCfg.maxProgress
	end

	item.txtlevel.text = num
end

function AchievementNamePlateListItem:tryPlayUpgradeEffect(taskMO, taskItem)
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

function AchievementNamePlateListItem:onTasksPlayUpgradeEffectFinished()
	if self._isNeedPlayEffect and self._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(self._achievementId)
	end
end

function AchievementNamePlateListItem:_onFocusFinished(viewType)
	if viewType ~= AchievementEnum.ViewType.List then
		return
	end

	local isNamePlate = AchievementMainCommonModel.instance:checkIsNamePlate()

	if not isNamePlate then
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

function AchievementNamePlateListItem:playTaskAnim(taskItem)
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

function AchievementNamePlateListItem:getOrCreateTaskItem(index)
	local taskItem = self._taskItemTab[index]

	if not taskItem then
		taskItem = self:getUserDataTb_()
		taskItem.viewGO = gohelper.cloneInPlace(self._gotaskitem, "task_" .. index)
		taskItem.goNormalBG = gohelper.findChild(taskItem.viewGO, "#go_NormalBG")
		taskItem.golockedBG = gohelper.findChild(taskItem.viewGO, "#go_lockedBG")
		taskItem.txtTaskDesc = gohelper.findChildText(taskItem.viewGO, "Descr/taskdesc/txt_taskdesc")
		taskItem.txtTaskDesc2 = gohelper.findChildText(taskItem.viewGO, "Descr/txt_taskdesc2")
		taskItem.goUnLockTime = gohelper.findChild(taskItem.viewGO, "UnLockedTime")
		taskItem.txtUnLockedTime = gohelper.findChildText(taskItem.viewGO, "UnLockedTime/#txt_UnLockedTime")
		taskItem.goupgrade = gohelper.findChild(taskItem.viewGO, "#go_upgrade")
		taskItem.goupgradeAnimator = gohelper.onceAddComponent(taskItem.goupgrade, gohelper.Type_Animator)
		taskItem.goIcon = gohelper.findChild(taskItem.viewGO, "go_icon")
		taskItem.levelItemList = {}

		for i = 1, 3 do
			local item = {}

			item.go = gohelper.findChild(taskItem.goIcon, "level" .. i)
			item.simagebg = gohelper.findChildSingleImage(item.go, "#simage_bg")
			item.simagetitle = gohelper.findChildSingleImage(item.go, "#simage_title")
			item.txtlevel = gohelper.findChildText(item.go, "#txt_level")

			gohelper.setActive(item.go, false)
			table.insert(taskItem.levelItemList, item)
		end

		if taskItem.levelItemList[index] then
			gohelper.setActive(taskItem.levelItemList[index].go, true)
		end

		taskItem.animator = gohelper.onceAddComponent(taskItem.viewGO, gohelper.Type_Animator)
		self._taskItemTab[index] = taskItem
	end

	gohelper.setActive(taskItem.viewGO, true)

	return taskItem
end

function AchievementNamePlateListItem:_iconClickCallBack()
	return
end

function AchievementNamePlateListItem:recycleUnuseTaskItem(useMap)
	if useMap and self._taskItemTab then
		for _, taskItem in pairs(self._taskItemTab) do
			if not useMap[taskItem] then
				gohelper.setActive(taskItem.viewGO, false)
			end
		end
	end
end

function AchievementNamePlateListItem:refreshTopUI(achievementCfg)
	local isFold = self._mo:getIsFold()

	if not isFold then
		self:refreshSingleTopUI(achievementCfg)
	end

	gohelper.setActive(self._gotop1, not isFold)

	if not isFold then
		self:playTopAnim()
	end
end

function AchievementNamePlateListItem:playTopAnim()
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

function AchievementNamePlateListItem:refreshSingleTopUI(achievementCfg)
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

function AchievementNamePlateListItem:recycleAchievementMainIcon()
	if self._taskItemTab then
		for _, taskItem in pairs(self._taskItemTab) do
			-- block empty
		end
	end
end

return AchievementNamePlateListItem
