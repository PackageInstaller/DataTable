-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUICompoundContent.lua

local TransformUICompoundContent = class()
local CompoundContent_NeedItemViewClass = require("IQIGame.UI.TransformUI.CompoundContent_NeedItemView")
local MinValue = 1

function TransformUICompoundContent.New(go, mainView)
	local o = Clone(TransformUICompoundContent)

	o:Initialize(go, mainView)

	return o
end

function TransformUICompoundContent:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransformUICompoundContent:InitMember()
	self.NeedItemViewArray = {}
	self.Count = 0
	self.MoneyBase = -1
end

function TransformUICompoundContent:InitComponent()
	self.itemImg = self.itemImg:GetComponent("Image")
	self.Slider = self.Slider:GetComponent("Slider")
	self.buttonAdd = self.addBtn:GetComponent("Button")
	self.buttonReduce = self.reduceBtn:GetComponent("Button")
	self.ConsumeGoldCell = CommonConsumeGold.New(self.Com_ConsumeGold)
	self.numTextGraphicColorChange = self.numText:GetComponent("GraphicColorChange")
end

function TransformUICompoundContent:InitDelegate()
	function self.delegateOnClickReduceBtn()
		self:OnClickReduceBtn()
	end

	function self.delegateOnClickAddBtn()
		self:OnClickAddBtn()
	end

	function self.OnSliderChangeDelegate(value)
		self:OnSliderChange(value)
	end

	function self.delegateOnClickCompoundBtn()
		self:OnClickCompoundBtn()
	end

	function self.delegateOnClickItemImg()
		self:OnClickItemImg()
	end

	function self.delegateOnClickChangeBtn()
		self:OnClickChangeBtn()
	end

	function self.RefreshDelegate()
		self:Refresh(self.Data, self.ItemCell)
	end

	function self.ChangeRecipeRefresh(cfgCombinationID)
		self:Refresh(cfgCombinationID, self.ItemCell)
	end
end

function TransformUICompoundContent:AddListener()
	self.reduceBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickReduceBtn)
	self.addBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickAddBtn)
	self.compoundBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCompoundBtn)
	self.itemImg.transform:GetComponent("Button").onClick:AddListener(self.delegateOnClickItemImg)
	self.changeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickChangeBtn)
	self.Slider.onValueChanged:AddListener(self.OnSliderChangeDelegate)
	EventDispatcher.AddEventListener(EventID.CompositeItemResultEvent, self.RefreshDelegate)
	EventDispatcher.AddEventListener(EventID.TransformUIChangeRecipeRefresh, self.ChangeRecipeRefresh)
end

function TransformUICompoundContent:RemoveListener()
	self.reduceBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickReduceBtn)
	self.addBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickAddBtn)
	self.compoundBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCompoundBtn)
	self.itemImg.transform:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickItemImg)
	self.changeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickChangeBtn)
	self.Slider.onValueChanged:RemoveListener(self.OnSliderChangeDelegate)
	EventDispatcher.RemoveEventListener(EventID.CompositeItemResultEvent, self.RefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.TransformUIChangeRecipeRefresh, self.ChangeRecipeRefresh)
end

function TransformUICompoundContent:OnDestroy()
	self:RemoveListener()

	local len = #self.NeedItemViewArray

	for i = 1, len do
		self.NeedItemViewArray[i]:OnDestroy()
	end

	self.NeedItemViewArray = {}

	LuaCodeInterface.ClearUIBlurBackground()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	self.ConsumeGoldCell:Dispose()

	self.gameObject = nil
	self.itemImg = nil
	self.Slider = nil
	self.buttonAdd = nil
	self.buttonReduce = nil
end

function TransformUICompoundContent:OnClickChangeBtn()
	EventDispatcher.Dispatch(EventID.TransformUIShowChangeRecipe, self.Data, self.CfgCombination.Type, self.CfgItem.Id)
end

function TransformUICompoundContent:OnClickItemImg()
	ItemModule.OpenTip(self.ItemCell)
end

function TransformUICompoundContent:OnClickCompoundBtn()
	if self.Count <= 0 then
		NoticeModule.ShowNotice(70009)

		return
	end

	LuaCodeInterface.DrawUIBlurBackground(self.rawImage, function()
		EventDispatcher.Dispatch(EventID.TransformUIShowConfirmPanel, self.CfgCombination.Id, self.Count)
	end)
end

function TransformUICompoundContent:OnSliderChange(value)
	self.Count = value

	self:SetNumText(value)
	self:CheckButtonState()
	self:RefreshMoneyCost()
	self:RefreshNeedItemCount()
end

function TransformUICompoundContent:OnClickReduceBtn()
	if self.Count <= 0 then
		self:CheckButtonState()

		return
	end

	self.Count = self.Count - 1

	self:SetSlider(self.Count)
	self:CheckButtonState()
	self:RefreshMoneyCost()
	self:RefreshNeedItemCount()
end

function TransformUICompoundContent:OnClickAddBtn()
	if self.Count >= self.MaxGetNum then
		self:CheckButtonState()

		return
	end

	self.Count = self.Count + 1

	self:SetSlider(self.Count)
	self:CheckButtonState()
	self:RefreshMoneyCost()
	self:RefreshNeedItemCount()
end

function TransformUICompoundContent:RefreshNeedItemCount()
	ForArrayTable(self.NeedItemViewArray, function(_, _itemCell)
		if not _itemCell.gameObject.activeSelf then
			return
		end

		_itemCell:UpdateCount(self.Count)
	end)
end

function TransformUICompoundContent:Open()
	if self.IsShow == true then
		return
	end

	self.IsShow = true

	self:AddListener()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TransformUICompoundContent:Close()
	if self.IsShow == false then
		return
	end

	self.IsShow = false

	self:RemoveListener()

	self.Count = 0

	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function TransformUICompoundContent:Refresh(Data, itemCell)
	self.Data = Data
	self.CfgCombination = CfgUtil.GetCfgCombinationDataWithID(Data)
	self.CfgItem = CfgUtil.GetItemCfgDataWithID(self.CfgCombination.Output[1])
	self.ItemCell = itemCell

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.CfgItem.Icon), self.itemImg)
	LuaUtility.SetText(self.nameText, self.CfgItem.Name)
	self:RefreshNeedItem()
	self:CheckButtonState()
	self:RefreshMoneyCost()

	if self.MaxGetNum > 0 then
		self:SetSlider(1)
	else
		self:SetSlider(0)
	end
end

function TransformUICompoundContent:RefreshNeedItem()
	local data = self.CfgCombination.Combination
	local len = #data
	local viewIndex = 1

	self.MaxGetNum = 0

	for i = 1, len - 1, 2 do
		if not data[i + 1] then
			logError(string.format("合成物品配置id = %s，配置错误", self.CfgCombination.Id))

			return
		end

		local tb = {}

		tb.Id = data[i]
		tb.Count = data[i + 1]

		if data[i] ~= Constant.ItemCid.GOLD then
			local view = self:_GetItemView(viewIndex)

			view:Refresh(tb)
			view:Show()

			viewIndex = viewIndex + 1
		else
			self.MoneyBase = data[i + 1]
		end

		local haveNum = WarehouseModule.GetItemNumByCfgID(tb.Id)
		local needNum = tb.Count
		local getNum, _ = math.modf(haveNum / needNum)

		self.MaxGetNum = i == 1 and getNum or math.min(self.MaxGetNum, getNum)
	end

	if viewIndex > 1 then
		self.NeedItemViewArray[viewIndex - 1]:HideAddImage()
	end

	len = #self.NeedItemViewArray

	for i = viewIndex, len do
		self.NeedItemViewArray[i]:Hide()
	end

	local cfgMax = CfgUtil.GetCfgDiscreteFirstDataWithID(103)

	self.MaxGetNum = cfgMax >= self.MaxGetNum and self.MaxGetNum or cfgMax
	self.Slider.maxValue = self.MaxGetNum
	self.Slider.interactable = self.MaxGetNum ~= 0
end

function TransformUICompoundContent:RefreshMoneyCost()
	self.ConsumeGoldCell:InitIconImg(Constant.ItemCid.GOLD)
	self.ConsumeGoldCell:SetData(self.MoneyBase * self.Count)
	self.ConsumeGoldCell:SetAllMoney()
end

function TransformUICompoundContent:_GetItemView(index)
	if not self.NeedItemViewArray[index] then
		local o = GameObject.Instantiate(self.materialsItem, self.materialsGrid.transform)
		local view = CompoundContent_NeedItemViewClass.New(o, self)

		self.NeedItemViewArray[index] = view
	end

	return self.NeedItemViewArray[index]
end

function TransformUICompoundContent:SetSlider(v)
	self.Count = v

	self:SetNumText(v)

	if v <= 0 then
		self.Slider.value = 1
	else
		self.Slider.value = v
	end
end

function TransformUICompoundContent:CheckButtonState()
	if self.Count >= self.MaxGetNum then
		self.buttonAdd.interactable = false
	else
		self.buttonAdd.interactable = true
	end

	if self.Count <= MinValue then
		self.buttonReduce.interactable = false
	else
		self.buttonReduce.interactable = true
	end
end

function TransformUICompoundContent:SetNumText(v)
	if v <= 0 then
		LuaUtility.SetText(self.numText, 1)
		self.numTextGraphicColorChange:EnablePreset(1)
	else
		LuaUtility.SetText(self.numText, v)
		self.numTextGraphicColorChange:EnablePreset(0)
	end
end

return TransformUICompoundContent
