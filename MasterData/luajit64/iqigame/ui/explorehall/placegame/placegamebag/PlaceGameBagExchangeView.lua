-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameBag\\PlaceGameBagExchangeView.lua

local m = {
	EntityId = 0,
	changeMaxNum = 1,
	changeNum = 1,
	boxExchangeDataList = {},
	exchangeItemCellPool = {}
}
local PlaceGameBagExchangeItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameBag.PlaceGameBagExchangeItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnBoxTip()
		self:OnBtnBoxTip()
	end

	function self.DelegateBtnReduce()
		self:OnBtnReduce()
	end

	function self.DelegateBtnAdd()
		self:OnBtnAdd()
	end

	function self.DelegateBtnMin()
		self:OnBtnMin()
	end

	function self.DelegateBtnMax()
		self:OnBtnMax()
	end

	function self.DelegateBtnExchange()
		self:OnBtnExchange()
	end

	function self.DelegateUpdateExchange()
		self:OnUpdateExchange()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateSpineActionEnd()
		self:OnSpineActionEnd()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnBoxTip:GetComponent("Button").onClick:AddListener(self.DelegateBtnBoxTip)
	self.BtnReduce:GetComponent("Button").onClick:AddListener(self.DelegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:AddListener(self.DelegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.DelegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.DelegateBtnMax)
	self.BtnExchange:GetComponent("Button").onClick:AddListener(self.DelegateBtnExchange)
	EventDispatcher.AddEventListener(EventID.PlaceGameUpdateExchange, self.DelegateUpdateExchange)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	self.BtnBoxTip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBoxTip)
	self.BtnReduce:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReduce)
	self.BtnAdd:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAdd)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnMin)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnMax)
	self.BtnExchange:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnExchange)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameUpdateExchange, self.DelegateUpdateExchange)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:ShowBoxElement(EntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, EntityCid, 0, self.BoxSpine.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.skeletonAnimationState = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState

		if self.skeletonAnimationState then
			self.skeletonAnimationState:SetEmptyAnimation(0, 0)
			self.skeletonAnimationState:SetAnimation(0, "idle", true)
		end
	end
end

function m:PlayOpenBoxEffect()
	if self.skeletonAnimationState then
		self.skeletonAnimationState:SetEmptyAnimation(0, 0)
		self.skeletonAnimationState:SetAnimation(0, "open", false)

		self.skeletonAnimationState.Complete = self.skeletonAnimationState.Complete + self.DelegateSpineActionEnd
	end
end

function m:OnSpineActionEnd()
	self.skeletonAnimationState.Complete = self.skeletonAnimationState.Complete - self.DelegateSpineActionEnd

	self.skeletonAnimationState:SetEmptyAnimation(0, 0)
	self.skeletonAnimationState:SetAnimation(0, "idle", true)
end

function m:GetDefaultData()
	local index = 1
	local maxExchangeData

	if self.selectExchangeData then
		for i = 1, #PlaceGameModule.boxExchangeDataList do
			local exchangeData = PlaceGameModule.boxExchangeDataList[i]

			if self.selectExchangeData.cid == exchangeData.cid then
				index = i
				maxExchangeData = exchangeData

				break
			end
		end
	else
		for i = 1, #PlaceGameModule.boxExchangeDataList do
			local exchangeData = PlaceGameModule.boxExchangeDataList[i]

			if exchangeData:IsOpen() then
				index = i
				maxExchangeData = exchangeData
			end
		end
	end

	return maxExchangeData, index
end

function m:OnUpdateExchange()
	self:UpdateView()
end

function m:UpdateView()
	self.boxExchangeDataList = PlaceGameModule.boxExchangeDataList

	local selectData, index = self:GetDefaultData()

	self.selectExchangeData = selectData
	self.ScrollArea:GetComponent("ScrollAreaList").startIndex = index - 1

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.boxExchangeDataList)
	self:RefreshSelectBox()
end

function m:OnRenderCell(cell)
	local exchangeData = self.boxExchangeDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local exchangeItemCell = self.exchangeItemCellPool[instanceID]

	if exchangeItemCell == nil then
		exchangeItemCell = PlaceGameBagExchangeItemCell.New(cell.gameObject)
		self.exchangeItemCellPool[instanceID] = exchangeItemCell
	end

	exchangeItemCell:SetData(exchangeData)

	if self.selectExchangeData == nil then
		self.selectExchangeData = exchangeData
	end

	exchangeItemCell:SetSelect(self.selectExchangeData:GetCfgData().Id == exchangeData:GetCfgData().Id)
end

function m:OnSelectedCell(cell)
	local exchangeData = self.boxExchangeDataList[cell.index + 1]

	if not exchangeData:IsOpen() then
		NoticeModule.ShowNotice(21045097)

		return
	end

	self.selectExchangeData = exchangeData

	for i, v in pairs(self.exchangeItemCellPool) do
		v:SetSelect(v.exchangeData:GetCfgData().Id == self.selectExchangeData:GetCfgData().Id)
	end

	self:RefreshSelectBox()
end

function m:RefreshSelectBox()
	self.changeMaxNum = CfgPlaceGameControlTable[PlaceGameModule.GlobalCid].BoxNumMax

	if self.selectExchangeData then
		self:ShowBoxElement(self.selectExchangeData:GetCfgData().BoxEnity)
		UGUIUtil.SetText(self.TextBoxName, self.selectExchangeData:GetCfgData().Name)

		local itemID = self.selectExchangeData:GetCfgData().Cost[1]
		local needNum = self.selectExchangeData:GetCfgData().Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)
		local changeNum = math.floor(haveNum / needNum)

		if changeNum < self.changeMaxNum then
			self.changeMaxNum = changeNum
		end

		local path = UIGlobalApi.GetIconPath(CfgItemTable[itemID].Icon)

		AssetUtil.LoadImage(self, path, self.NeedItemIcon:GetComponent("Image"))
		self:RefreshChangeCount()
	end

	self.changeNum = self.changeNum > self.changeMaxNum and self.changeMaxNum or self.changeNum
end

function m:RefreshChangeCount()
	UGUIUtil.SetText(self.TextNum, self.changeNum)

	if self.selectExchangeData then
		UGUIUtil.SetText(self.TextNeedNum, self.changeNum * self.selectExchangeData:GetCfgData().Cost[2])
	end
end

function m:OnBtnBoxTip()
	if self.selectExchangeData then
		UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
			self.selectExchangeData:GetCfgData().Desc
		})
	end
end

function m:OnBtnReduce()
	if self.changeNum > 1 then
		self.changeNum = self.changeNum - 1

		self:RefreshChangeCount()
	end
end

function m:OnBtnAdd()
	if self.changeNum < self.changeMaxNum then
		self.changeNum = self.changeNum + 1

		self:RefreshChangeCount()
	end
end

function m:OnBtnMin()
	self.changeNum = 1

	self:RefreshChangeCount()
end

function m:OnBtnMax()
	self.changeNum = self.changeMaxNum > 0 and self.changeMaxNum or 1

	self:RefreshChangeCount()
end

function m:OnBtnExchange()
	if self.changeNum <= 0 then
		return
	end

	if self.changeNum <= self.changeMaxNum and self.selectExchangeData then
		self:PlayOpenBoxEffect()
		PlaceGameModule.BuyATreasureChest(self.changeNum, self.selectExchangeData.cid)
	end
end

function m:Open()
	self.View:SetActive(true)

	self.selectExchangeData = nil

	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:HideEntity()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:HideEntity()

	for i, v in pairs(self.exchangeItemCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
