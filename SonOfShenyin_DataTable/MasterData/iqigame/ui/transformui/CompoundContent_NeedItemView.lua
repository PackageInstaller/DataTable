-- chunkname: @IQIGame\\UI\\TransformUI\\CompoundContent_NeedItemView.lua

local CompoundContent_NeedItemView = {}

function CompoundContent_NeedItemView.New(go, mainView)
	local o = Clone(CompoundContent_NeedItemView)

	o:Initialize(go, mainView)

	return o
end

function CompoundContent_NeedItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function CompoundContent_NeedItemView:InitComponent()
	if self.haveNum then
		self.graphicColorChange = self.haveNum:GetComponent("GraphicColorChange")
	end
end

function CompoundContent_NeedItemView:InitDelegate()
	return
end

function CompoundContent_NeedItemView:AddListener()
	return
end

function CompoundContent_NeedItemView:RemoveListener()
	return
end

function CompoundContent_NeedItemView:OnDestroy()
	self:RemoveListener()

	if self.ItemCell then
		self.ItemCell:Dispose()

		self.ItemCell = nil
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function CompoundContent_NeedItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function CompoundContent_NeedItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function CompoundContent_NeedItemView:HideAddImage()
	LuaUtility.SetGameObjectShow(self.addImg, false)
end

function CompoundContent_NeedItemView:ShowAddImage()
	LuaUtility.SetGameObjectShow(self.addImg, true)
end

function CompoundContent_NeedItemView:Refresh(Data)
	self.Data = Data

	local itemId = self.Data.Id
	local itemNum = 0
	local ItemData = ItemData.CreateByCIDAndNumber(itemId, itemNum)

	if not self.ItemCell then
		self.ItemCell = ItemCell.New(self.CommonSlotUI, true)
	end

	self.ItemCell:SetItem(ItemData)
	self:UpdateCount(1)
	self:ShowAddImage()
end

function CompoundContent_NeedItemView:UpdateCount(count)
	local needCount = count <= 0 and self.Data.Count or self.Data.Count * count

	if self.costNum and self.haveNum then
		LuaUtility.SetText(self.costNum, needCount)

		local haveNum = WarehouseModule.GetItemNumByCfgID(self.Data.Id)

		LuaUtility.SetText(self.haveNum, haveNum)
		LuaUtility.SetGameObjectShow(self.greyState, haveNum < needCount)

		if needCount <= haveNum then
			self.graphicColorChange:EnablePreset(0)
		else
			self.graphicColorChange:EnablePreset(1)
		end
	else
		self.ItemCell:SetNum(needCount)
	end
end

return CompoundContent_NeedItemView
