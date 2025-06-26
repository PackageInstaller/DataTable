-- chunkname: @IQIGame\\UI\\FirstRechargeUI.lua

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

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local LotteryRoleNameTemplate = require("IQIGame/UI/Lottery/Template/LotteryRoleNameTemplate")
local FirstRechargeUI = {}

FirstRechargeUI = Base:Extend("FirstRechargeUI", "IQIGame.Onigao.UI.FirstRechargeUI", FirstRechargeUI)

function FirstRechargeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

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
	self.roleNameTemplate = LotteryRoleNameTemplate.New(self.RoleNamePrefab)
end

function FirstRechargeUI:GetPreloadAssetPaths()
	return nil
end

function FirstRechargeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FirstRechargeUI:IsManualShowOnOpen(userData)
	return false
end

function FirstRechargeUI:GetBGM(userData)
	return nil
end

function FirstRechargeUI:OnOpen(userData)
	self:OnRefreshInfo()
end

function FirstRechargeUI:OnClose(userData)
	return
end

function FirstRechargeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ReceiveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetBtn)
	self.NotAchievedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNotAchievedBtn)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
end

function FirstRechargeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ReceiveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetBtn)
	self.NotAchievedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNotAchievedBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
end

function FirstRechargeUI:OnPause()
	return
end

function FirstRechargeUI:OnResume()
	return
end

function FirstRechargeUI:OnCover()
	return
end

function FirstRechargeUI:OnReveal()
	return
end

function FirstRechargeUI:OnRefocus(userData)
	return
end

function FirstRechargeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FirstRechargeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FirstRechargeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FirstRechargeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FirstRechargeUI:OnDestroy()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil

	self.roleNameTemplate:Dispose()
	AssetUtil.UnloadAsset(self)
end

function FirstRechargeUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.FirstRechargeUI)
end

function FirstRechargeUI:OnClickGetBtn()
	TaskSystemModule.SubmitTask({
		self.taskCid
	})
	UIModule.Close(Constant.UIControllerName.FirstRechargeUI)
end

function FirstRechargeUI:OnClickNotAchievedBtn()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) then
		UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
			Constant.ShopType.SoulStone.Type,
			enterType = Constant.ShopEnterType.Normal
		})
	else
		NoticeModule.ShowNotice(19001)
	end
end

function FirstRechargeUI:OnTaskNotifyEvent()
	self:OnRefreshInfo()
end

function FirstRechargeUI:OnRefreshInfo()
	local taskList = TaskSystemModule.GetTaskListByPlayer(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.Recharge_Frist)
	local ActionParamNormal = UIUtil.GetConfigArr(taskList[1].BaseData.ActionParam)
	local firstGiftId = ActionParamNormal[1][1]

	self.taskCid = taskList[1].cid
	self.itemCfg = CfgItemTable[firstGiftId]

	self.roleNameTemplate:Show(self.itemCfg.LikeId)

	self.itemList = ActionParamNormal

	self:RefreshItemList()
	LuaUtility.SetGameObjectShow(self.ReceiveBtn, taskList[1].status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.NotAchievedBtn, taskList[1].status == Constant.TaskStatus.doing)
end

function FirstRechargeUI:RefreshItemList()
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

return FirstRechargeUI
