-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskView.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskView", package.seeall)

local Act183TaskView = class("Act183TaskView", BaseView)
local TaskCategorySelectConfigMap = {
	[Act183Enum.TaskType.Daily] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn1_1"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn2_1"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#C14A3E",
		"v2a5_challenge_reward_btn3_1"
	}
}
local TaskCategoryUnselectConfigMap = {
	[Act183Enum.TaskType.Daily] = {
		"#9B9899",
		"v2a5_challenge_reward_btn1_2"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#9B9899",
		"v2a5_challenge_reward_btn2_2"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#873D30",
		"v2a5_challenge_reward_btn3_2"
	}
}
local TaskScrollHeight_HasOneKey = 740
local TaskScrollHeight_NoneOneKey = 893
local TaskScrollPosY_HasOneKey = -106
local TaskScrollPosY_NoneOneKey = -25

function Act183TaskView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._gocategorys = gohelper.findChild(self.viewGO, "root/left/#go_categorys")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "root/left/#go_categorys/#go_categoryitem")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_task")
	self._goonekeypos = gohelper.findChild(self.viewGO, "root/right/#go_onekeypos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183TaskView:addEvents()
	return
end

function Act183TaskView:removeEvents()
	return
end

function Act183TaskView:_editableInitView()
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._onFinishTask, self)

	self._taskTypes = {
		Act183Enum.TaskType.Daily,
		Act183Enum.TaskType.NormalMain,
		Act183Enum.TaskType.HardMain
	}
	self._defaultSelectTaskType = self._taskTypes[1]
	self._categoryItemTab = self:getUserDataTb_()
	Act183TaskListModel.instance.startFrameCount = UnityEngine.Time.frameCount
end

function Act183TaskView:_onFinishTask()
	Act183TaskListModel.instance:refresh()
	self:initOrRefreshOneKeyTaskItem()
	self:refreshAllCategoryItemReddot()
end

function Act183TaskView:onUpdateParam()
	return
end

function Act183TaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenTaskView)
	self:initInfo()
	self:refresh()
end

function Act183TaskView:refresh()
	Act183TaskListModel.instance:init(self._activityId, self._selectTaskType)
	self:_initCategorys()
	self:initOrRefreshOneKeyTaskItem()
end

function Act183TaskView:initInfo()
	if self.viewParam then
		self._selectGroupType = self.viewParam.selectGroupType
		self._selectGroupId = self.viewParam.selectGroupId

		if self._selectGroupType then
			self._selectTaskType = Act183Enum.GroupTypeToTaskType[self._selectGroupType]
		end
	end

	self._selectTaskType = self._selectTaskType or self._defaultSelectTaskType
	self._activityId = Act183Model.instance:getActivityId()
end

function Act183TaskView:initOrRefreshOneKeyTaskItem()
	local oneKeyMo = Act183TaskListModel.instance:getOneKeyTaskItem()
	local needOneKeyItem = oneKeyMo ~= nil

	if self._oneKeyTaskItem then
		gohelper.setActive(self._oneKeyTaskItem.go, false)
	end

	recthelper.setHeight(self._scrolltask.transform, (needOneKeyItem or nil) and (TaskScrollHeight_HasOneKey or TaskScrollHeight_NoneOneKey))
	recthelper.setAnchorY(self._scrolltask.transform, (needOneKeyItem or nil) and (TaskScrollPosY_HasOneKey or TaskScrollPosY_NoneOneKey))

	if not needOneKeyItem then
		return
	end

	if not self._oneKeyTaskItem then
		local oneKeyItemResUrl = self.viewContainer._viewSetting.otherRes[3]
		local oneKeyItemGo = self:getResInst(oneKeyItemResUrl, self._goonekeypos)

		self._oneKeyTaskItem = MonoHelper.addLuaComOnceToGo(oneKeyItemGo, Act183TaskOneKeyItem)
		self._oneKeyTaskItem._index = 1
	end

	gohelper.setActive(self._oneKeyTaskItem.go, true)
	self._oneKeyTaskItem:onUpdateMO(oneKeyMo)
end

function Act183TaskView:onOpenFinish()
	self:focusTargetGroupTasks()
end

function Act183TaskView:focusTargetGroupTasks()
	if self._selectGroupType ~= Act183Enum.TaskType.Daily or not self._selectGroupId then
		return
	end

	local scrollOffsetY = 0
	local list = Act183TaskListModel.instance:getList()
	local isFocusSucc = false

	for _, cellInfo in ipairs(list) do
		if not Act183Enum.TaskItemHeightMap[cellInfo.type] then
			if cellInfo.data then
				local cellConfig = cellInfo.data.config

				if cellInfo.type == Act183Enum.TaskListItemType.Head and cellConfig ~= nil and cellConfig.groupId == self._selectGroupId then
					isFocusSucc = true

					break
				end

				scrollOffsetY = scrollOffsetY + Act183Enum.TaskItemHeightMap[cellInfo.type]
			end
		end
	end

	local resultOffsetY = isFocusSucc and scrollOffsetY or 0

	self:setTaskVerticalScrollPixel(resultOffsetY)
end

function Act183TaskView:setTaskVerticalScrollPixel(scrollOffsetY)
	local taskScrollView = self.viewContainer:getTaskScrollView()
	local csMixScrollView = taskScrollView and taskScrollView:getCsScroll()

	if csMixScrollView then
		csMixScrollView.VerticalScrollPixel = scrollOffsetY
	end
end

function Act183TaskView:_initCategorys()
	for index, taskType in ipairs(self._taskTypes) do
		local categoryItem = self:_getOrCreateCategoryItem(index)

		categoryItem.txtselecttitle.text = luaLang(Act183Enum.TaskNameLangId[taskType])
		categoryItem.txtunselecttitle.text = luaLang(Act183Enum.TaskNameLangId[taskType])
		categoryItem.reddot = RedDotController.instance:addRedDot(categoryItem.goreddot, RedDotEnum.DotNode.V2a5_Act183Task, taskType, self._categoryReddotOverrideFunc, taskType)

		local isSelect = taskType == self._selectTaskType

		gohelper.setActive(categoryItem.goselect, isSelect)
		gohelper.setActive(categoryItem.gounselect, not isSelect)
		gohelper.setActive(categoryItem.viewGO, true)

		local selectCategoryCo = TaskCategorySelectConfigMap[taskType]
		local unselectCategoryCo = TaskCategoryUnselectConfigMap[taskType]

		SLFramework.UGUI.GuiHelper.SetColor(categoryItem.txtselecttitle, selectCategoryCo[1])
		SLFramework.UGUI.GuiHelper.SetColor(categoryItem.txtunselecttitle, unselectCategoryCo[1])
		UISpriteSetMgr.instance:setChallengeSprite(categoryItem.imageselectbg, selectCategoryCo[2])
		UISpriteSetMgr.instance:setChallengeSprite(categoryItem.imageunselectbg, unselectCategoryCo[2])
		gohelper.setActive(categoryItem.goselect_normaleffect, isSelect and taskType ~= Act183Enum.TaskType.HardMain)
		gohelper.setActive(categoryItem.goselect_hardeffect, isSelect and taskType == Act183Enum.TaskType.HardMain)
	end
end

function Act183TaskView._categoryReddotOverrideFunc(taskType, reddotIcon)
	local isDotShow = false
	local taskMoList = Act183TaskListModel.instance:getTaskMosByType(taskType)

	if taskMoList then
		for _, taskMo in ipairs(taskMoList) do
			local canGetReward = Act183Helper.isTaskCanGetReward(taskMo.id)

			if canGetReward then
				isDotShow = true

				break
			end
		end
	end

	reddotIcon.show = isDotShow

	reddotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function Act183TaskView:refreshAllCategoryItemReddot()
	for index, taskType in ipairs(self._taskTypes) do
		local categoryItem = self:_getOrCreateCategoryItem(index)

		categoryItem.reddot:refreshDot()
	end
end

function Act183TaskView:_getOrCreateCategoryItem(index)
	local categoryItem = self._categoryItemTab[index]

	if not categoryItem then
		categoryItem = self:getUserDataTb_()
		categoryItem.viewGO = gohelper.cloneInPlace(self._gocategoryitem, "categoryitem_" .. index)
		categoryItem.goselect = gohelper.findChild(categoryItem.viewGO, "go_select")
		categoryItem.gounselect = gohelper.findChild(categoryItem.viewGO, "go_unselect")
		categoryItem.imageselectbg = gohelper.findChildImage(categoryItem.viewGO, "go_select/bg")
		categoryItem.imageunselectbg = gohelper.findChildImage(categoryItem.viewGO, "go_unselect/bg")
		categoryItem.txtselecttitle = gohelper.findChildText(categoryItem.viewGO, "go_select/txt_title")
		categoryItem.txtunselecttitle = gohelper.findChildText(categoryItem.viewGO, "go_unselect/txt_title")
		categoryItem.goreddot = gohelper.findChild(categoryItem.viewGO, "go_reddot")
		categoryItem.goselect_normaleffect = gohelper.findChild(categoryItem.viewGO, "go_select/vx_normal")
		categoryItem.goselect_hardeffect = gohelper.findChild(categoryItem.viewGO, "go_select/vx_hard")
		categoryItem.btnclick = gohelper.findChildButtonWithAudio(categoryItem.viewGO, "btn_click")

		categoryItem.btnclick:AddClickListener(self._onClickCategoryItem, self, index)

		self._categoryItemTab[index] = categoryItem
	end

	return categoryItem
end

function Act183TaskView:_onClickCategoryItem(index)
	local taskType = self._taskTypes[index]

	if not taskType or self._selectTaskType == taskType then
		return
	end

	self._selectTaskType = taskType

	self:setTaskVerticalScrollPixel(0)
	self:refresh()
end

function Act183TaskView:relreaseAllCategoryItems()
	if self._categoryItemTab then
		for _, categoryItem in pairs(self._categoryItemTab) do
			categoryItem.btnclick:RemoveClickListener()
		end
	end
end

function Act183TaskView:playTaskItmeAnimation()
	local taskScrollView = self.viewContainer:getTaskScrollView()

	if not taskScrollView then
		return
	end
end

function Act183TaskView:onClose()
	self:relreaseAllCategoryItems()
end

function Act183TaskView:onDestroyView()
	return
end

return Act183TaskView
