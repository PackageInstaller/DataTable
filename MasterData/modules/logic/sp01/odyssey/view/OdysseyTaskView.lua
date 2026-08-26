-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTaskView.lua

module("modules.logic.sp01.odyssey.view.OdysseyTaskView", package.seeall)

local OdysseyTaskView = class("OdysseyTaskView", BaseView)

function OdysseyTaskView:onInitView()
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "root/Task/#scroll_TaskList")
	self._txtreward = gohelper.findChildText(self.viewGO, "root/Reward/image_nameBG/#txt_reward")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "root/Reward/#simage_reward")
	self._imagereward = gohelper.findChildImage(self.viewGO, "root/Reward/#simage_reward")
	self._btnbigRewardClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/Reward/#simage_reward/#btn_bigRewardClick")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/Reward/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/Reward/#scroll_desc/Viewport/Content/#txt_desc")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/Reward/btn/#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "root/Reward/btn/#go_hasget")
	self._gonormal = gohelper.findChild(self.viewGO, "root/Reward/btn/#go_normal")
	self._scrollLeftTab = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_LeftTab")
	self._goTabContent = gohelper.findChild(self.viewGO, "root/#scroll_LeftTab/Viewport/#go_tabContent")
	self._goTabItem = gohelper.findChild(self.viewGO, "root/#scroll_LeftTab/Viewport/#go_tabContent/#go_tabItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTaskView:addEvents()
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnbigRewardClick:AddClickListener(self._btnbigRewardOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, self.refreshUI, self)
end

function OdysseyTaskView:removeEvents()
	self._btncanget:RemoveClickListener()
	self._btnbigRewardClick:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, self.refreshUI, self)
end

OdysseyTaskView.TaskMaskTime = 0.65
OdysseyTaskView.TaskGetAnimTime = 0.567

function OdysseyTaskView:_btncangetOnClick()
	self.bigRewardTaskMo = OdysseyTaskModel.instance:getBigRewardTaskMo()

	local isCanGet = OdysseyTaskModel.instance:isTaskCanGet(self.bigRewardTaskMo)

	if isCanGet then
		TaskRpc.instance:sendFinishTaskRequest(self.bigRewardTaskMo.id)
	end
end

function OdysseyTaskView:_onTabClick(tabItem)
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.NormalTask, tabItem.tabType)
	OdysseyTaskModel.instance:refreshList()
	self:refreshTabSelectState()
end

function OdysseyTaskView:_btnbigRewardOnClick()
	local rewardData = string.splitToNumber(self.bigRewardTaskConfig.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(rewardData[1], rewardData[2])
end

function OdysseyTaskView:_editableInitView()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer.scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(OdysseyTaskView.TaskMaskTime - OdysseyTaskView.TaskGetAnimTime)

	self.removeIndexTab = {}

	gohelper.setActive(self._goTabItem, false)

	self.tabTypeList = {
		OdysseyEnum.TaskGroupType.Story,
		OdysseyEnum.TaskGroupType.Fight,
		OdysseyEnum.TaskGroupType.Collect,
		OdysseyEnum.TaskGroupType.Myth
	}
	self.tabItemMap = self:getUserDataTb_()
end

function OdysseyTaskView:onUpdateParam()
	return
end

function OdysseyTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_task)

	self.bigRewardTaskConfig = OdysseyConfig.instance:getBigRewardTaskConfig()

	self:refreshUI()
end

function OdysseyTaskView:refreshUI()
	self:createAndRefreshTab()
	self:refreshBigReward()
	self:refreshReddot()

	self._scrollTaskList.verticalNormalizedPosition = 1
end

function OdysseyTaskView:createAndRefreshTab()
	self.curTaskType, self.curSelectGroupTypeId = OdysseyTaskModel.instance:getCurSelectTaskTypeAndGroupId()

	for index, tabType in ipairs(self.tabTypeList) do
		local tabItem = self.tabItemMap[tabType]

		if not tabItem then
			tabItem = {
				tabType = tabType,
				go = gohelper.clone(self._goTabItem, self._goTabContent, "Tab" .. tabType)
			}
			tabItem.goNormal = gohelper.findChild(tabItem.go, "go_normal")
			tabItem.txtNormalName = gohelper.findChildText(tabItem.go, "go_normal/txt_normalName")
			tabItem.txtNormalNum = gohelper.findChildText(tabItem.go, "go_normal/txt_normalNum")
			tabItem.goSelect = gohelper.findChild(tabItem.go, "go_select")
			tabItem.txtSelectName = gohelper.findChildText(tabItem.go, "go_select/txt_selectName")
			tabItem.txtSelectNum = gohelper.findChildText(tabItem.go, "go_select/txt_selectNum")
			tabItem.goreddot = gohelper.findChild(tabItem.go, "go_reddot")
			tabItem.btnClick = gohelper.findChildButtonWithAudio(tabItem.go, "btn_click")

			tabItem.btnClick:AddClickListener(self._onTabClick, self, tabItem)

			self.tabItemMap[tabType] = tabItem
		end

		gohelper.setActive(tabItem.go, true)
		gohelper.setActive(tabItem.goNormal, tabItem.tabType ~= self.curSelectGroupTypeId)
		gohelper.setActive(tabItem.goSelect, tabItem.tabType == self.curSelectGroupTypeId)

		tabItem.txtNormalName.text = luaLang(OdysseyEnum.NormalTaskGroupTypeLang[tabType])
		tabItem.txtSelectName.text = luaLang(OdysseyEnum.NormalTaskGroupTypeLang[tabType])

		local taskList = OdysseyTaskModel.instance:getNormalTaskListByGroupType(tabItem.tabType)
		local finishCount = OdysseyTaskModel.instance:getTaskItemRewardCount(taskList)

		tabItem.txtNormalNum.text = string.format("%s/%s", finishCount, #taskList)
		tabItem.txtSelectNum.text = string.format("%s/%s", finishCount, #taskList)
	end
end

function OdysseyTaskView:refreshTabSelectState()
	self.curTaskType, self.curSelectGroupTypeId = OdysseyTaskModel.instance:getCurSelectTaskTypeAndGroupId()

	for index, tabItem in pairs(self.tabItemMap) do
		gohelper.setActive(tabItem.goNormal, tabItem.tabType ~= self.curSelectGroupTypeId)
		gohelper.setActive(tabItem.goSelect, tabItem.tabType == self.curSelectGroupTypeId)
	end

	self._scrollTaskList.verticalNormalizedPosition = 1
end

function OdysseyTaskView:refreshReddot()
	for index, tabItem in pairs(self.tabItemMap) do
		local canShowReddot = OdysseyTaskModel.instance:canShowReddot(OdysseyEnum.TaskType.NormalTask, tabItem.tabType)

		gohelper.setActive(tabItem.goreddot, canShowReddot)
	end
end

function OdysseyTaskView:refreshBigReward()
	local rewardData = string.splitToNumber(self.bigRewardTaskConfig.bonus, "#")
	local bigRewardConfig, bigRewardIcon = ItemModel.instance:getItemConfigAndIcon(rewardData[1], rewardData[2])

	self._txtreward.text = bigRewardConfig.name

	if rewardData[1] == MaterialEnum.MaterialType.Equip then
		self._simagereward:LoadImage(ResUrl.getHeroDefaultEquipIcon(bigRewardConfig.id), function()
			self._imagereward:SetNativeSize()
		end)
	else
		self._simagereward:LoadImage(bigRewardIcon)
	end

	self._scrolldesc.verticalNormalizedPosition = 1
	self._txtdesc.text = self.bigRewardTaskConfig.desc
	self.bigRewardTaskMo = OdysseyTaskModel.instance:getBigRewardTaskMo()

	local isHasGet = OdysseyTaskModel.instance:isTaskHasGet(self.bigRewardTaskMo)
	local isCanGet = OdysseyTaskModel.instance:isTaskCanGet(self.bigRewardTaskMo)

	gohelper.setActive(self._gohasget, isHasGet)
	gohelper.setActive(self._gonormal, not isHasGet and not isCanGet)
	gohelper.setActive(self._btncanget.gameObject, isCanGet)
end

function OdysseyTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, OdysseyTaskView.TaskGetAnimTime)
end

function OdysseyTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function OdysseyTaskView:onClose()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
end

function OdysseyTaskView:onDestroyView()
	for index, tabItem in pairs(self.tabItemMap) do
		tabItem.btnClick:RemoveClickListener()
	end

	self._simagereward:UnLoadImage()
end

return OdysseyTaskView
