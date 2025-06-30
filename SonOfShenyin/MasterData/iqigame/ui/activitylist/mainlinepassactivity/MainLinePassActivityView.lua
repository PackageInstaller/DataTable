-- chunkname: @IQIGame\\UI\\ActivityList\\MainLinePassActivity\\MainLinePassActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local mainLineActivityScrollItemView = require("IQIGame.UI.ActivityList.MainLinePassActivity.MainLineActivityScrollItemView")
local m = Clone(ActivityViewBase)

m.ItemList = {}
m.ActivityDatas = {}

function m:__Init()
	self.optimizedPassScroll = self.ItemScrollView:GetComponent("OptimizedScrollRect")

	self.optimizedPassScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdatePassScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	function self.DelegateOnClickBuyHighBtn()
		self:OnClickBuyHighBtn()
	end

	function self.DelegateOnClickReceiveBtn()
		self:OnClickReceiveBtn()
	end

	function self.DelegateOnBuyItemResult()
		self:OnBuyItemResult()
	end

	function self.DelegateOnTaskNotifyEvent()
		self:OnTaskNotifyEvent()
	end

	self.ReceiveBtnCom = self.ReceiveBtn:GetComponent("Button")
end

function m:__AddListeners()
	self.BuyHighBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyHighBtn)
	self.ReceiveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReceiveBtn)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateOnBuyItemResult)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyEvent)
end

function m:__RemoveListeners()
	self.BuyHighBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuyHighBtn)
	self.ReceiveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReceiveBtn)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateOnBuyItemResult)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyEvent)
end

function m:__SetData()
	if self.View == nil then
		return
	end

	local activityPod = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_MainLine
	})
	local activityCfg = CfgActivityTable[activityPod[1].cid]

	self.normalMainTaskType = activityCfg.ExtraParam[1]
	self.normalExtTaskType = {
		activityCfg.ExtraParam[2],
		activityCfg.ExtraParam[3]
	}
	self.highMainTaskType = activityCfg.ExtraParam[4]
	self.highExtTaskType = {
		activityCfg.ExtraParam[5],
		activityCfg.ExtraParam[6]
	}
	self.normalTask = TaskSystemModule.GetTaskListByConfig(self.normalMainTaskType, self.normalExtTaskType)

	table.sort(self.normalTask, function(a, b)
		return a.cid < b.cid
	end)

	self.highTask = TaskSystemModule.GetTaskListByConfig(self.highMainTaskType, self.highExtTaskType)

	table.sort(self.highTask, function(a, b)
		return a.cid < b.cid
	end)

	if self.highTask[1].virtual == true and self.highTask[1].status == Constant.TaskStatus.doing then
		self.isBuy = false
	else
		self.isBuy = true
	end

	local len = math.max(#self.normalTask, #self.highTask)
	local startIndex = self:GetReceivedTaskIndex() - 1

	self.optimizedPassScroll:RefreshByItemCount(len)
	self.optimizedPassScroll:ScrollTo(startIndex)

	local count = 0

	for i = 1, #self.normalTask do
		count = count + self.normalTask[i].BaseData.ActionParam[2]
	end

	local itemCfg = CfgItemTable[self.normalTask[1].BaseData.ActionParam[1]]

	UGUIUtil.SetText(self.normalCountText, itemCfg.Name .. "×" .. count)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.SmallIcon), self.normalRewardItemIcon:GetComponent("Image"))

	count = 0

	for i = 1, #self.highTask do
		count = count + self.highTask[i].BaseData.ActionParam[2]
	end

	itemCfg = CfgItemTable[self.highTask[1].BaseData.ActionParam[1]]

	UGUIUtil.SetText(self.highCountText, itemCfg.Name .. "×" .. count)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.SmallIcon), self.highRewardItemIcon:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.PriceImg, false)

	self.commodityData = ActivityListModule.GetCommodityDataByActivityID(Constant.ShopType.PassShop.Type, activityPod[1].cid)

	if self.commodityData ~= nil then
		LuaUtility.SetGameObjectShow(self.PriceImg, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.commodityData:GetPriceIconId()].Icon), self.PriceImg:GetComponent("Image"))
		LuaUtility.SetText(self.PreiceText, self.commodityData:GetPrice())
	end

	LuaUtility.SetGameObjectShow(self.BuyHighBtn, not self.isBuy and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) and self.commodityData ~= nil)
	LuaUtility.SetGameObjectShow(self.payLockImg, not self.isBuy)

	local normalTrunkIsShow = TaskSystemModule.IsCanGetAward(self.normalMainTaskType, self.normalExtTaskType)
	local highTrunkIsShow = TaskSystemModule.IsCanGetAward(self.highMainTaskType, self.highExtTaskType)

	self.ReceiveBtnCom.interactable = highTrunkIsShow or normalTrunkIsShow
end

function m:__Dispose()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end
end

function m:UpdatePassScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local normalTaskData = self.normalTask[index + 1]
	local highTaskData = self.highTask[index + 1]

	if not self.ItemList[instanceID] then
		self.ItemList[instanceID] = mainLineActivityScrollItemView.New(viewGameObject, self)
	end

	self.ItemList[instanceID]:SetData(normalTaskData, highTaskData, self.isBuy)
end

function m:OnClickBuyHighBtn()
	ShopModule.BuyItem(self.commodityData, 1)
end

function m:OnClickReceiveBtn()
	local SubmitIDs = TaskSystemModule.GetCanReceiveTaskIDList({
		self.normalTask,
		self.highTask
	})

	TaskSystemModule.SubmitTask(SubmitIDs)
end

function m:OnBuyItemResult()
	self:__SetData()
end

function m:OnTaskNotifyEvent()
	self:__SetData()
end

function m:GetReceivedTaskIndex()
	local normalIndex = 1

	for i = 1, #self.normalTask do
		if self.normalTask[i].status == Constant.TaskStatus.hasDone then
			normalIndex = i

			break
		end
	end

	local highIndex = 1

	for i = 1, #self.highTask do
		if self.highTask[i].status == Constant.TaskStatus.hasDone then
			highIndex = i

			break
		end
	end

	if self.isBuy then
		return math.min(normalIndex, highIndex)
	else
		return normalIndex
	end
end

return m
