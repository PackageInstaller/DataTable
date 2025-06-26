-- chunkname: @IQIGame\\UI\\DupMultipleActivityUI.lua

local ActivityItemView = {}

function ActivityItemView.New(view)
	local obj = Clone(ActivityItemView)

	obj:Init(view)

	return obj
end

function ActivityItemView:Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end

	self:AddListeners()
end

function ActivityItemView:AddListeners()
	self.JumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function ActivityItemView:RemoveListeners()
	self.JumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
end

function ActivityItemView:SetData(activityPOD)
	self.activityCfg = CfgActivityTable[activityPOD.cid]

	UGUIUtil.SetText(self.Name, DupMultipleActivityUIApi:GetChapterNameByTag(self.activityCfg.ExtraParam[4]))
	UGUIUtil.SetText(self.DayNumText, string.format("(%s/%s)", self.activityCfg.ExtraParam[2] - activityPOD.dupDropPOD.dayNum, self.activityCfg.ExtraParam[2]))
	UGUIUtil.SetText(self.AllNumText, string.format("(%s/%s)", self.activityCfg.ExtraParam[1] - activityPOD.dupDropPOD.sumNum, self.activityCfg.ExtraParam[1]))
end

function ActivityItemView:OnClickJumpBtn()
	JumpModule.Jump(self.activityCfg.Source[1])
	UIModule.Close(Constant.UIControllerName.DupMultipleActivityUI)
end

function ActivityItemView:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local DupMultipleActivityUI = {
	ActivityItemList = {},
	ActivityDatas = {}
}

DupMultipleActivityUI = Base:Extend("DupMultipleActivityUI", "IQIGame.Onigao.UI.DupMultipleActivityUI", DupMultipleActivityUI)

function DupMultipleActivityUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.wrapContent = self.ScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end
end

function DupMultipleActivityUI:GetPreloadAssetPaths()
	return nil
end

function DupMultipleActivityUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DupMultipleActivityUI:IsManualShowOnOpen(userData)
	return false
end

function DupMultipleActivityUI:GetBGM(userData)
	return nil
end

function DupMultipleActivityUI:OnOpen(userData)
	self:RefreshActivityShow()
end

function DupMultipleActivityUI:OnClose(userData)
	return
end

function DupMultipleActivityUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DupMultipleActivityUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DupMultipleActivityUI:OnPause()
	return
end

function DupMultipleActivityUI:OnResume()
	return
end

function DupMultipleActivityUI:OnCover()
	return
end

function DupMultipleActivityUI:OnReveal()
	return
end

function DupMultipleActivityUI:OnRefocus(userData)
	return
end

function DupMultipleActivityUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DupMultipleActivityUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DupMultipleActivityUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DupMultipleActivityUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DupMultipleActivityUI:OnDestroy()
	for k, v in pairs(self.ActivityItemList) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function DupMultipleActivityUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DupMultipleActivityUI:RefreshActivityShow()
	self.ActivityDatas = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_DupMultiple_11,
		Constant.ActivityType.ActivityType_DupMultiple_12
	})

	self.wrapContent:Refresh(#self.ActivityDatas)
end

function DupMultipleActivityUI:OnRenderItem(cell)
	local activityData = self.ActivityDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ActivityItemList[instanceId]

	if itemCell == nil then
		itemCell = ActivityItemView.New(cell.gameObject)
		self.ActivityItemList[instanceId] = itemCell
	end

	itemCell:SetData(activityData)
end

return DupMultipleActivityUI
