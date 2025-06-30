-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUIChangeBagPanel.lua

local TransformUIChangeBagPanel = {}
local ItemViewClass = require("IQIGame.UI.TransformUI.ChangeBagPanel_ItemView")

function TransformUIChangeBagPanel.New(go, mainView)
	local o = Clone(TransformUIChangeBagPanel)

	o:Initialize(go, mainView)

	return o
end

function TransformUIChangeBagPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransformUIChangeBagPanel:InitMember()
	self.BagScrollDataArray = {}
	self.BagScrollViewList = {}
end

function TransformUIChangeBagPanel:InitComponent()
	self.itemBagScroll = self.itemBagScroll:GetComponent("OptimizedScrollRect")

	self.itemBagScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateItemBagScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function TransformUIChangeBagPanel:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function TransformUIChangeBagPanel:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function TransformUIChangeBagPanel:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function TransformUIChangeBagPanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.BagScrollViewList) do
		v:OnDestroy()
	end

	self.BagScrollViewList = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.itemBagScroll = nil
end

function TransformUIChangeBagPanel:OnClickCloseBtn()
	self:Close()
end

function TransformUIChangeBagPanel:UpdateItemBagScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.BagScrollDataArray[index + 1]

	if not self.BagScrollViewList[instanceID] then
		self.BagScrollViewList[instanceID] = ItemViewClass.New(viewGameObject, self)
	end

	self.BagScrollViewList[instanceID]:Refresh(data)
end

function TransformUIChangeBagPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TransformUIChangeBagPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	self.CurrentSelectItem = nil
end

function TransformUIChangeBagPanel:Refresh(CfgCombinationID, type, itemID)
	self.Data = TransformModule.GetAllRecipeArray(type, itemID)

	self:SetSelectCombinationID(CfgCombinationID)
	self:RefreshBagScroll()
end

function TransformUIChangeBagPanel:RefreshBagScroll()
	self.BagScrollDataArray = self.Data

	self.itemBagScroll:RefreshByItemCount(#self.BagScrollDataArray)
end

function TransformUIChangeBagPanel:GetCommonSlot()
	return self.CommonSlotUI
end

function TransformUIChangeBagPanel:GetSelectCombinationID()
	return self.SelectCfgCombinationID
end

function TransformUIChangeBagPanel:SetSelectCombinationID(id, item)
	self.SelectCfgCombinationID = id

	if not item then
		return
	end

	if self.CurrentSelectItem then
		self.CurrentSelectItem:CancelSelect()
	end

	self.CurrentSelectItem = item
end

return TransformUIChangeBagPanel
