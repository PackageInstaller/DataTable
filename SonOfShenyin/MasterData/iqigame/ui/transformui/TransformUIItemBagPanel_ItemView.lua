-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUIItemBagPanel_ItemView.lua

local TransformUIItemBagPanel_ItemView = {}

function TransformUIItemBagPanel_ItemView.New(go, mainView)
	local o = Clone(TransformUIItemBagPanel_ItemView)

	o:Initialize(go, mainView)

	return o
end

function TransformUIItemBagPanel_ItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransformUIItemBagPanel_ItemView:InitComponent()
	return
end

function TransformUIItemBagPanel_ItemView:InitDelegate()
	function self.delegateOnClickBtnGo()
		self:OnClickBtnGo()
	end

	function self.refreshSelectedDelegate()
		self:RefreshSelect()
	end
end

function TransformUIItemBagPanel_ItemView:AddListener()
	self.btnGo:GetComponent("Button").onClick:AddListener(self.delegateOnClickBtnGo)
	EventDispatcher.AddEventListener(EventID.TransformUIBagRefreshSelectEvent, self.refreshSelectedDelegate)
end

function TransformUIItemBagPanel_ItemView:RemoveListener()
	self.btnGo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBtnGo)
	EventDispatcher.RemoveEventListener(EventID.TransformUIBagRefreshSelectEvent, self.refreshSelectedDelegate)
end

function TransformUIItemBagPanel_ItemView:OnDestroy()
	self:RemoveListener()

	if self.ItemCell then
		self.ItemCell:Dispose()

		self.ItemCell = nil
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TransformUIItemBagPanel_ItemView:OnClickBtnGo()
	if self.Data.Type == Constant.CombinationType.ItemCombination then
		EventDispatcher.Dispatch(EventID.TransformUICompoundSelectItemEvent, self.Data.Id, self.ItemCell)
	elseif self.Data.Type == Constant.CombinationType.ItemTransform then
		EventDispatcher.Dispatch(EventID.TransformUITransSelectItemEvent, self.Data.Id, self.ItemCell)
	end

	self.mainView:SetCurrentSelectItemID(self.Data.Id)
	EventDispatcher.Dispatch(EventID.TransformUIBagRefreshSelectEvent)
end

function TransformUIItemBagPanel_ItemView:Select()
	LuaUtility.SetGameObjectShow(self.selectImg, true)
end

function TransformUIItemBagPanel_ItemView:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectImg, false)
end

function TransformUIItemBagPanel_ItemView:Refresh(Data, itemIndex)
	self.Data = Data
	self.ItemIndex = itemIndex

	local itemId = self.Data.Output[1]
	local itemNum = self.Data.Output[2]
	local ItemData = ItemData.CreateByCIDAndNumber(itemId, 0)

	self.ItemCell = ItemCell.New(self.CommonSlotUI, false)

	self.ItemCell:SetItem(ItemData)
	LuaUtility.SetText(self.nameText, ItemData:GetCfg().Name)
	self:RefreshSelect()
	self:CheckCanBeCompose()
end

function TransformUIItemBagPanel_ItemView:RefreshSelect()
	if self.mainView:GetCurrentSelectItemID() and self.mainView:GetCurrentSelectItemID() == self.Data.Id then
		self:Select()
	else
		self:UnSelect()
	end
end

function TransformUIItemBagPanel_ItemView:CheckCanBeCompose()
	local allRecipe = TransformModule.GetAllRecipeArray(self.Data.Type, self.Data.Output[1])
	local len = #allRecipe

	for i = 1, len do
		local canBeCompose = true
		local needArray = allRecipe[i].Combination
		local len2 = #needArray

		for j = 1, len2 - 1, 2 do
			local enough = TransformModule.CheckItemIsEnough(needArray[j], needArray[j + 1])

			if not enough then
				canBeCompose = false

				break
			end
		end

		if canBeCompose then
			LuaUtility.SetGameObjectShow(self.greyState, false)

			return
		end
	end

	LuaUtility.SetGameObjectShow(self.greyState, true)
end

return TransformUIItemBagPanel_ItemView
