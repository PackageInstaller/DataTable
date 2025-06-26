-- chunkname: @IQIGame\\UI\\TransformUI\\TransformUIConfirmPanel.lua

local TransformUIConfirmPanel = {}
local CompoundContent_NeedItemViewClass = require("IQIGame.UI.TransformUI.CompoundContent_NeedItemView")

function TransformUIConfirmPanel.New(go, mainView)
	local o = Clone(TransformUIConfirmPanel)

	o:Initialize(go, mainView)

	return o
end

function TransformUIConfirmPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransformUIConfirmPanel:InitMember()
	self.ItemCellArray = {}
end

function TransformUIConfirmPanel:InitComponent()
	return
end

function TransformUIConfirmPanel:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.delegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.delegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function TransformUIConfirmPanel:AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
	self.cancelBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCancelBtn)
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickConfirmBtn)
end

function TransformUIConfirmPanel:RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
	self.cancelBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCancelBtn)
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickConfirmBtn)
end

function TransformUIConfirmPanel:OnDestroy()
	self:RemoveListener()

	local len = #self.ItemCellArray

	for i = 1, len do
		self.ItemCellArray[i]:Dispose()
	end

	self.ItemCellArray = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function TransformUIConfirmPanel:OnClickConfirmBtn()
	local composites = {}

	composites[self.CfgCombinationID] = self.Consume

	ItemModule.CompositeItem(composites)
	self:Close()
end

function TransformUIConfirmPanel:OnClickCancelBtn()
	self:Close()
end

function TransformUIConfirmPanel:OnClickCloseBtn()
	self:Close()
end

function TransformUIConfirmPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TransformUIConfirmPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function TransformUIConfirmPanel:Refresh(CfgCombinationID, consume)
	self.CfgCombinationID = CfgCombinationID
	self.Consume = consume

	local cfg = CfgUtil.GetCfgCombinationDataWithID(self.CfgCombinationID)
	local outputID = cfg.Output[1]
	local num = cfg.Output[2]
	local itemData = ItemData.CreateByCIDAndNumber(outputID, num * self.Consume)
	local itemCell = ItemCell.New(self.resultItem)

	itemCell:SetItem(itemData)

	local combinationData = cfg.Combination
	local len = #combinationData
	local index = 1
	local money = -9999

	for i = 1, len - 1, 2 do
		if combinationData[i] ~= Constant.ItemCid.GOLD then
			local c = self:_GetItem(index)
			local tb = {}

			tb.Id = combinationData[i]
			tb.Count = combinationData[i + 1] * self.Consume

			c:Refresh(tb)
			c:Show()

			index = index + 1
		else
			money = combinationData[i + 1]
		end
	end

	if index > 1 then
		self.ItemCellArray[index - 1]:HideAddImage()
	end

	LuaUtility.SetText(self.numText, money * self.Consume)

	len = #self.ItemCellArray

	for i = index, len do
		self.ItemCellArray[i]:Hide()
	end

	if cfg.Type == Constant.CombinationType.ItemCombination then
		LuaUtility.SetText(self.titleText, CfgUtil.GetCfgTipsTextWithID(230004))
	elseif cfg.Type == Constant.CombinationType.ItemTransform then
		LuaUtility.SetText(self.titleText, CfgUtil.GetCfgTipsTextWithID(230005))
	end
end

function TransformUIConfirmPanel:_GetItem(index)
	if not self.ItemCellArray[index] then
		local o = GameObject.Instantiate(self.materialsItem, self.materialGrid.transform)
		local itemCell = CompoundContent_NeedItemViewClass.New(o, self)

		self.ItemCellArray[index] = itemCell
	end

	return self.ItemCellArray[index]
end

return TransformUIConfirmPanel
