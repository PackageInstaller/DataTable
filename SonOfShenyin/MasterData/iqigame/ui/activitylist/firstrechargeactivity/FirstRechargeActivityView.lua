-- chunkname: @IQIGame\\UI\\ActivityList\\FirstRechargeActivity\\FirstRechargeActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local ItemDetailView = {}

function ItemDetailView.New(view)
	local obj = Clone(ItemDetailView)

	obj:Init(view)

	return obj
end

function ItemDetailView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonSlot = ItemCell.New(self.CommonSlotUI, true)
end

function ItemDetailView:SetData(itemData)
	self.commonSlot:SetItemByCid(itemData[1])
	self.commonSlot:SetNum(itemData[2])
end

function ItemDetailView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function ItemDetailView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function ItemDetailView:Dispose()
	self.commonSlot:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnClickGetBtn()
		self:OnClickGetBtn()
	end

	function self.DelegateOnClickNotAchievedBtn()
		self:OnClickNotAchievedBtn()
	end

	function self.DelegateOnTaskNotifyEvent()
		self:OnTaskNotifyEvent()
	end

	self.previewItemPool = UIViewObjectPool.New(self.ItemDetailPrefab, self.ItemDetailContent.transform, function(_view)
		return ItemDetailView.New(_view)
	end)
end

function m:__AddListeners()
	self.ReceiveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetBtn)
	self.NotAchievedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNotAchievedBtn)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
end

function m:__RemoveListeners()
	self.ReceiveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetBtn)
	self.NotAchievedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNotAchievedBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
end

function m:__SetData()
	self:OnRefreshInfo()
end

function m:__Dispose()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil
end

function m:OnClickGetBtn()
	TaskSystemModule.SubmitTask({
		self.taskCid
	})
end

function m:OnClickNotAchievedBtn()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) then
		UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
			shopType = Constant.ShopType.SoulStone.Type,
			enterType = Constant.ShopEnterType.Normal
		})
	else
		NoticeModule.ShowNotice(19001)
	end
end

function m:OnTaskNotifyEvent()
	self:OnRefreshInfo()
end

function m:OnRefreshInfo()
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)
	local ActionParamNormal = UIUtil.GetConfigArr(taskList[1].BaseData.ActionParam)
	local firstGiftId = ActionParamNormal[1][1]

	self.taskCid = taskList[1].cid
	self.itemList = ActionParamNormal

	self:RefreshItemList()
	LuaUtility.SetGameObjectShow(self.ReceiveBtn, taskList[1].status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.ReceivedParent, taskList[1].status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.NotAchievedBtn, taskList[1].status == Constant.TaskStatus.doing)

	if taskList[1].status == Constant.TaskStatus.doing then
		-- block empty
	end
end

function m:RefreshItemList()
	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.itemList do
		local previewItem = self.previewItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		previewItem:SetData(self.itemList[i])
		previewItem:Show()
	end
end

return m
