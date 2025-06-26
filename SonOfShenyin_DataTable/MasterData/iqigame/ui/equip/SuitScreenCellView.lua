-- chunkname: @IQIGame\\UI\\Equip\\SuitScreenCellView.lua

SuitScreenCellView = {
	isChoose = false,
	suitTipsCellList = {}
}

local EquipSuitTipsCell = require("IQIGame.UI.Equip.EquipSuitTipsCell")

function SuitScreenCellView.New(go)
	local o = Clone(SuitScreenCellView)

	o:Initialize(go)

	return o
end

function SuitScreenCellView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.iconImage = self.Icon:GetComponent("Image")
	self.nameText = self.Name:GetComponent("Text")
	self.countText = self.Count:GetComponent("Text")
end

function SuitScreenCellView:IsChooseItem(isChoose)
	self.isChoose = isChoose

	self:RefreshChoose(self.isChoose)
end

local gray4D = Color.New(0.30196078431372547, 0.30196078431372547, 0.30196078431372547, 1)
local grayAF = Color.New(0.6862745098039216, 0.6862745098039216, 0.6862745098039216, 1)

function SuitScreenCellView:Refresh(equipSuitData, list)
	self.equipSuitData = equipSuitData

	local path = UIGlobalApi.IconPath .. equipSuitData.SuitIcon

	AssetUtil.LoadImage(self, path, self.iconImage)

	self.nameText.text = equipSuitData.Name

	self:ResetSuitTipsScrollView()

	for i, SuitTipID in pairs(equipSuitData.SuitTips) do
		local suitTips = CfgUtil.GetCfgTipsTextWithID(SuitTipID)
		local gameObject = UnityEngine.Object.Instantiate(self.AttributeItem, self.AttributeGrid.transform)
		local cell = EquipSuitTipsCell.New(gameObject)

		cell:Refresh(suitTips)
		self:AddSuitTipsScrollView(cell)
		gameObject:SetActive(true)
	end

	self.countText.text = #EquipModule.GetSuitScreenConfigList(list, equipSuitData.SuitID)

	self:RefreshChoose(self.isChoose)
end

function SuitScreenCellView:ResetSuitTipsScrollView()
	for _, cell in pairs(self.suitTipsCellList) do
		local gameObject = cell.gameObject

		cell:OnDestroy()
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.suitTipsCellList = {}
end

function SuitScreenCellView:AddSuitTipsScrollView(cell)
	table.insert(self.suitTipsCellList, cell)
end

function SuitScreenCellView:RefreshChoose(isChoose)
	self.SelectedBg.gameObject:SetActive(isChoose)

	if isChoose then
		UGUIUtil.SetColor(self.nameText, gray4D)
	else
		UGUIUtil.SetColor(self.nameText, grayAF)
	end

	self.xSelectState:SetActive(isChoose)
	self.xNormalState:SetActive(not isChoose)
	UGUIUtil.SetColor(self.countText, isChoose and gray4D or grayAF)

	for i, cell in pairs(self.suitTipsCellList) do
		cell:RefreshChoose(isChoose)
	end
end

function SuitScreenCellView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return SuitScreenCellView
