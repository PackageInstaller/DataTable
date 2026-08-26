-- chunkname: @modules/logic/explore/view/ExploreRewardView.lua

module("modules.logic.explore.view.ExploreRewardView", package.seeall)

local ExploreRewardView = class("ExploreRewardView", BaseView)

function ExploreRewardView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._btnbox = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_box")
	self._txtprogress0 = gohelper.findChildTextMesh(self.viewGO, "#btn_box/#txt_progress")
	self._txtprogress1 = gohelper.findChildTextMesh(self.viewGO, "Top/title1/#txt_progress")
	self._txtprogress2 = gohelper.findChildTextMesh(self.viewGO, "Top/title2/#txt_progress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreRewardView:addEvents()
	self._btnbox:AddClickListener(self.openBoxView, self)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, self._onUpdateTaskList, self)
end

function ExploreRewardView:removeEvents()
	self._btnbox:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, self._onUpdateTaskList, self)
end

function ExploreRewardView:openBoxView()
	ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, self.viewParam)
end

function ExploreRewardView:_editableInitView()
	return
end

function ExploreRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	local chapterCo = self.viewParam
	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getChapterCoinCount(chapterCo.id)

	self._txtprogress0.text = string.format("%d/%d", bonusNum, bonusNumTotal)
	self._txtprogress1.text = string.format("%d/%d", purpleCoin, purpleCoinTotal)
	self._txtprogress2.text = string.format("%d/%d", goldCoin, goldCoinTotal)

	local allTaskIds = {}

	for i = 1, 2 do
		local model = ExploreTaskModel.instance:getTaskList(3 - i)
		local taskList = ExploreConfig.instance:getTaskList(chapterCo.id, i)

		for _, task in pairs(taskList) do
			local taskMO = TaskModel.instance:getTaskById(task.id)

			if taskMO and taskMO.progress >= task.maxProgress and taskMO.finishCount == 0 then
				table.insert(allTaskIds, task.id)
			end
		end

		model:setList(taskList)
	end

	if #allTaskIds > 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Explore, nil, allTaskIds)
	end
end

function ExploreRewardView:_onUpdateTaskList()
	return
end

function ExploreRewardView:_setitem(go, data, index)
	local progressbar = gohelper.findChildImage(go, "bottom/image_progresssilder")
	local txt_point = gohelper.findChildTextMesh(go, "bottom/txt_point")
	local bg = gohelper.findChildImage(go, "bottom/bg")
	local icon_parent = gohelper.findChild(go, "icons")
	local btnClick = gohelper.findChildButtonWithAudio(go, "btn_click")
	local rewards = GameUtil.splitString2(data.bonus, true)

	txt_point.text = data.maxProgress

	local taskMO = TaskModel.instance:getTaskById(data.id)

	if taskMO then
		if not taskMO.progress then
			local nowCount = 0
			local isGet = taskMO and taskMO.finishCount > 0 or false
			local fillAmount = 1
			local isFinish = nowCount >= data.maxProgress

			if isFinish then
				if index == #self._taskList then
					fillAmount = 1
				else
					local nextTaskMo = TaskModel.instance:getTaskById(self._taskList[index + 1].id)

					nowCount = nextTaskMo and nextTaskMo.progress or nowCount
					fillAmount = Mathf.Clamp((nowCount - data.maxProgress) / (self._taskList[index + 1].maxProgress - data.maxProgress), 0, 0.5) + 0.5
				end
			else
				fillAmount = index == 1 and nowCount / data.maxProgress * 0.5 or Mathf.Clamp((nowCount - self._taskList[index - 1].maxProgress) / (data.maxProgress - self._taskList[index - 1].maxProgress), 0.5, 1) - 0.5
			end

			progressbar.fillAmount = fillAmount

			ZProj.UGUIHelper.SetColorAlpha(bg, isFinish and 1 or 0.15)
			SLFramework.UGUI.GuiHelper.SetColor(txt_point, isFinish and "#000000" or "#d2c197")
			self.addClickCb(self, btnClick, self._getReward, self, data)
			gohelper.setActive(btnClick, not isGet and isFinish)

			self._isGet = isGet

			gohelper.CreateObjList(self, self._setRewardItem, rewards, icon_parent, self._gorewarditemicon)
		end
	end
end

function ExploreRewardView:_setRewardItem(go, data, index)
	local icon = gohelper.findChild(go, "go_icon")
	local hasget = gohelper.findChild(go, "go_receive")
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(icon)

	itemIcon:setMOValue(data[1], data[2], data[3], nil, true)
	itemIcon:setCountFontSize(46)
	itemIcon:SetCountBgHeight(31)
	gohelper.setActive(hasget, self._isGet)
end

function ExploreRewardView:_getReward(data)
	TaskRpc.instance:sendFinishTaskRequest(data.id)
end

return ExploreRewardView
