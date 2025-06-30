-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\FavorGiftItemView.lua

local FavorGiftItemView = {}

function FavorGiftItemView.New(go, mainView)
	local o = Clone(FavorGiftItemView)

	o:Initialize(go, mainView)

	return o
end

function FavorGiftItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FavorGiftItemView:InitComponent()
	return
end

function FavorGiftItemView:InitDelegate()
	function self.OnClickDelegate()
		self:OnClick()
	end

	function self.OnLongClickDelegate()
		self:OnLongClick()
	end

	function self.delegateOnClickReduceBtn()
		self:OnClickReduceBtn()
	end
end

function FavorGiftItemView:AddListener()
	self.views:GetComponent("LongButton").onLongDownClick:AddListener(self.OnClickDelegate)
	self.views:GetComponent("LongButton").onClick:AddListener(self.OnLongClickDelegate)
	self.reduceBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickReduceBtn)
end

function FavorGiftItemView:RemoveListener()
	self.views:GetComponent("LongButton").onLongDownClick:RemoveListener(self.OnClickDelegate)
	self.views:GetComponent("LongButton").onClick:RemoveListener(self.OnLongClickDelegate)
	self.reduceBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickReduceBtn)
end

function FavorGiftItemView:OnLongClick()
	self:OnClick()
end

function FavorGiftItemView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FavorGiftItemView:OnClickReduceBtn()
	if self.prepareCostNum <= 0 then
		self:RefreshFlags()

		return
	end

	self.prepareCostNum = self.prepareCostNum - 1

	self:RefreshFlags()
	self.mainView:ReduceFavorItemSelect(self.data.itemId)
	EventDispatcher.Dispatch(EventID.FavorPrepareReduceEvent, self.data.value)
end

function FavorGiftItemView:OnClick()
	if self.mainView:ValidatePrepareLvIsMax() then
		NoticeModule.ShowNotice(14009)

		return
	end

	if self.prepareCostNum >= self.data.count then
		NoticeModule.ShowNotice(12003)

		return
	end

	self.mainView:SetGiftDescShow(self.cfgItem.Name, self.cfgItem.ItemTips, self.data.value)

	self.prepareCostNum = self.prepareCostNum + 1

	self:RefreshFlags()
	self.mainView:AddFavorItemSelect(self.data.itemId)
	EventDispatcher.Dispatch(EventID.FavorPrepareAddEvent, self.data.value)
end

function FavorGiftItemView:Refresh(Data)
	self.data = Data
	self.prepareCostNum = 0
	self.cfgItem = CfgUtil.GetItemCfgDataWithID(self.data.itemId)
	self.itemCell = ItemCell.New(self.CommonSlotUI, false)

	self.itemCell:SetItemByCid(self.data.itemId, self.data.count)
	self.itemCell:SetNum(self.data.count)
	LuaUtility.SetText(self.textFavorValue, string.format("+%s", self.data.value))
	self:RestoreSelection()
	self:RefreshFlags()
end

function FavorGiftItemView:RefreshFlags()
	if self.prepareCostNum <= 0 then
		LuaUtility.SetGameObjectShow(self.costItem, false)
		LuaUtility.SetGameObjectShow(self.reduceBtn, false)
	else
		LuaUtility.SetGameObjectShow(self.costItem, true)
		LuaUtility.SetGameObjectShow(self.reduceBtn, true)
	end

	LuaUtility.SetText(self.costNumText, self.prepareCostNum)
end

function FavorGiftItemView:RestoreSelection()
	local cost = self.mainView.selectList[self.cfgItem.Id]

	if cost then
		self.prepareCostNum = cost
	end
end

return FavorGiftItemView
