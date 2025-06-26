-- chunkname: @IQIGame\\UI\\Dup\\IntergralRewardView.lua

local IntergralRewardItem = {}

function IntergralRewardItem.New(view)
	local obj = Clone(IntergralRewardItem)

	obj:Init(view)

	return obj
end

function IntergralRewardItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell1 = ItemCell.New(self.CommonSlotUI1, true)

	self.itemCell1:SetClickHandler(function()
		self:OnButtonClick(self.itemCell1)
	end)

	self.itemCell2 = ItemCell.New(self.CommonSlotUI2, true)

	self.itemCell2:SetClickHandler(function()
		self:OnButtonClick(self.itemCell2)
	end)

	self.sliderImgCom = self.SliderImg:GetComponent("Image")

	self:AddListeners()
end

function IntergralRewardItem:AddListeners()
	return
end

function IntergralRewardItem:RemoveListeners()
	return
end

function IntergralRewardItem:SetData(taskData, previousData, curScheduleNum, needScheduleNum)
	self.taskCid = taskData.cid
	self.rewardState = taskData.status

	self.itemCell1:SetItemByCid(taskData.cfgTaskConfig.ActionParam[1])
	self.itemCell1:SetNum(taskData.cfgTaskConfig.ActionParam[2])

	if table.len(taskData.cfgTaskConfig.ActionParam) / 2 >= 2 then
		LuaUtility.SetGameObjectShow(self.Reward2, true)
		self.itemCell2:SetItemByCid(taskData.cfgTaskConfig.ActionParam[3])
		self.itemCell2:SetNum(taskData.cfgTaskConfig.ActionParam[4])
	else
		LuaUtility.SetGameObjectShow(self.Reward2, false)
	end

	if taskData.status == Constant.passTaskStatus.hasDone or taskData.status == Constant.passTaskStatus.hadGot then
		UGUIUtil.SetText(self.NeedIntergralText, string.format(ColorCfg.DupIntergral.White, taskData.needSchedule))
	else
		UGUIUtil.SetText(self.NeedIntergralText, string.format(ColorCfg.DupIntergral.Gray, taskData.needSchedule))
	end

	LuaUtility.SetGameObjectShow(self.canGetImg1, taskData.status == Constant.passTaskStatus.hasDone or taskData.status == Constant.passTaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.canGetEffect1, taskData.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.haveGetState1, taskData.status == Constant.passTaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.canGetImg2, taskData.status == Constant.passTaskStatus.hasDone or taskData.status == Constant.passTaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.canGetEffect2, taskData.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.haveGetState2, taskData.status == Constant.passTaskStatus.hadGot)

	if previousData == nil then
		LuaUtility.SetGameObjectShow(self.ReceviedImg, false)
		LuaUtility.SetGameObjectShow(self.NotReceivedImg, false)
	elseif previousData.status == Constant.passTaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.ReceviedImg, false)
		LuaUtility.SetGameObjectShow(self.NotReceivedImg, true)
	else
		LuaUtility.SetGameObjectShow(self.ReceviedImg, true)
		LuaUtility.SetGameObjectShow(self.NotReceivedImg, false)
	end

	local previousSchedule = previousData == nil and 0 or previousData.schedule

	if curScheduleNum >= taskData.needSchedule then
		self.sliderImgCom.fillAmount = 1
	else
		self.sliderImgCom.fillAmount = (taskData.schedule - previousSchedule) / (taskData.needSchedule - previousSchedule)
	end
end

function IntergralRewardItem:OnButtonClick(itemCell)
	if self.rewardState == Constant.TaskStatus.hasDone then
		TaskSystemModule.SubmitTask({
			self.taskCid
		})
	else
		itemCell:OnClick()
	end
end

function IntergralRewardItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function IntergralRewardItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function IntergralRewardItem:Dispose()
	self:RemoveListeners()
	self.itemCell2:Dispose()
	self.itemCell1:Dispose()

	self.sliderImgCom = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	TaskItemList = {}
}

m.IntergralRewardItemView = IntergralRewardItem

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:__InitDelegate()
	self:__InitComponent()
	self:AddListeners()
end

function m:__InitDelegate()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function m:__InitComponent()
	self.scrollRect = self.RewardScroll:GetComponent("ScrollRect")
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:SetData(taskList, curScheduleNum, needScheduleNum)
	self.taskList = taskList
	self.curScheduleNum = curScheduleNum
	self.needScheduleNum = needScheduleNum

	UGUIUtil.SetText(self.CurIntergralText, self.curScheduleNum .. "/")
	UGUIUtil.SetText(self.AllIntergralText, self.needScheduleNum)

	local startIndex = 0

	for i = 1, #self.taskList do
		if self.taskList[i].status == Constant.passTaskStatus.hadGot then
			startIndex = startIndex + 1
		end
	end

	self:RefreshTaskItem()

	local pos = 1 / #self.taskList * startIndex

	self.scrollRect.horizontalNormalizedPosition = pos

	self:RefreshCountdown()
end

function m:RefreshCountdown()
	self:UpdateSurplusTime()

	self.timer = Timer.New(function()
		self:UpdateSurplusTime()
	end, 1, -1)

	self.timer:Start()
end

function m:UpdateSurplusTime()
	local surplusTime = tonumber(PlayerModule.PlayerInfo.baseInfo.weekResetTime) / 1000 - PlayerModule.GetServerTime()

	UGUIUtil.SetText(self.CountdownText, DateTimeFormat(surplusTime, self:GetTimeSurplusState(surplusTime)))
end

function m:RefreshTaskItem()
	for i = 1, #self.taskList do
		local scheduleItem = self:CreatrItem(i)
		local data = self.taskList[i]
		local previousData = self.taskList[i - 1]

		scheduleItem:SetData(data, previousData, self.curScheduleNum, self.needScheduleNum)
		scheduleItem:Show()
	end
end

function m:CreatrItem(index)
	local scheduleItem = self.TaskItemList[index]

	if scheduleItem == nil then
		local obj = GameObject.Instantiate(self.SchedulePrefab)

		obj.transform:SetParent(self.ContentGrid.transform, false)

		scheduleItem = m.IntergralRewardItemView.New(obj)
		self.TaskItemList[index] = scheduleItem
	end

	return scheduleItem
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:GetTimeSurplusState(second)
	if second <= 3600 then
		return MazeApi:GetTimeFormat(1)
	elseif second <= 86400 then
		return MazeApi:GetTimeFormat(2)
	else
		return MazeApi:GetTimeFormat(3)
	end
end

function m:DisposeTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	self:DisposeTimer()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:DisposeTimer()
	self:RemoveListeners()

	for k, v in pairs(self.TaskItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
