-- chunkname: @IQIGame\\UI\\TransformUI\\TransContent_NeedItemView.lua

local TransContent_NeedItemView = {}

function TransContent_NeedItemView.New(go, mainView)
	local o = Clone(TransContent_NeedItemView)

	o:Initialize(go, mainView)

	return o
end

function TransContent_NeedItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TransContent_NeedItemView:InitComponent()
	return
end

function TransContent_NeedItemView:InitDelegate()
	return
end

function TransContent_NeedItemView:AddListener()
	return
end

function TransContent_NeedItemView:RemoveListener()
	return
end

function TransContent_NeedItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function TransContent_NeedItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function TransContent_NeedItemView:Refresh(Data)
	self.Data = Data

	local itemId = self.Data.Id
	local itemNum = 0
	local ItemData = ItemData.CreateByCIDAndNumber(itemId, itemNum)
	local itemCell = ItemCell.New(self.CommonSlotUI, false)

	itemCell:SetItem(ItemData)
	LuaUtility.SetText(self.costNum, self.Data.Count)

	local haveNum = WarehouseModule.GetItemNumByCfgID(self.Data.Id)

	LuaUtility.SetText(self.haveNum, haveNum)
end

return TransContent_NeedItemView
