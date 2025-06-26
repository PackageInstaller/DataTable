-- chunkname: @IQIGame\\UI\\Bag\\ExtendItemCell.lua

ExtendItemCell = {}

function ExtendItemCell.New(go)
	local o = Clone(ExtendItemCell)

	o:Initialize(go)

	return o
end

function ExtendItemCell:Initialize(go)
	self.gameObject = go
end

function ExtendItemCell:InitializeExtend1()
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	local itemObj = UnityEngine.Object.Instantiate(self.Obj.gameObject)

	itemObj.transform:SetParent(self.DefaultItemRoot.gameObject.transform, false)

	self.BaseItemCell = ItemCell.New(itemObj, true, true)
	self.CurOwnText = self.Num:GetComponent("Text")
end

function ExtendItemCell:SetData(itemData)
	self.BaseItemCell:SetItem(itemData)

	self.CurOwnText.text = itemData.num
end

function ExtendItemCell:InitializeExtend2()
	LuaCodeInterface.BindOutlet(self.gameObject, self)

	local itemObj = UnityEngine.Object.Instantiate(self.Obj.gameObject)

	itemObj.transform:SetParent(self.ItemRoot.gameObject.transform, false)

	itemObj.name = "10000000"
	self.BaseItemCell = ItemCell.New(itemObj, true, true)
	self.NameText = self.Name:GetComponent("Text")
	self.OldNumText = self.OldNum:GetComponent("Text")
	self.NewNumText = self.NewNum:GetComponent("Text")
end

function ExtendItemCell:SetData2(itemData, addnum)
	local cfgItemData = itemData:GetCfg()

	self.BaseItemCell:SetItem(itemData)

	self.NameText.text = cfgItemData.Name
	self.OldNumText.text = itemData.num
	self.NewNumText.text = itemData.num + addnum
end

function ExtendItemCell:SetAwardData(itemData, needNun)
	local cfgItemData = itemData:GetCfg()

	self.BaseItemCell:SetItem(itemData)
	self.Extend:SetActive(true)

	self.ExtendAwardNumText.text = "X" .. needNun
end

function ExtendItemCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end
