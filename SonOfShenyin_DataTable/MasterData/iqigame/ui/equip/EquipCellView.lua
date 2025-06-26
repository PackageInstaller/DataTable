-- chunkname: @IQIGame\\UI\\Equip\\EquipCellView.lua

local EquipCellView = {
	isChoose = false
}

function EquipCellView.New(go, partIndex, onToggleFunc, mainView)
	local o = Clone(EquipCellView)

	o:Initialize(go, partIndex, onToggleFunc, mainView)

	return o
end

function EquipCellView:Initialize(go, partIndex, onToggleFunc, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.partIndex = partIndex
	self.mainView = mainView
	self.OnEquipPartChanged = onToggleFunc

	self:InitData()
	self:OnAddListeners()
end

function EquipCellView:InitData()
	self.isChoose = false

	self:__HideQualityEffect()
end

function EquipCellView:RefreshData(data)
	self.data = data

	if self.data == nil then
		self.EquippedParent:SetActive(false)
		self.NotEquippedParent:SetActive(true)
		self:__HideQualityEffect()

		return
	end

	self.EquippedParent:SetActive(true)
	self.NotEquippedParent:SetActive(false)

	local itemCfg = CfgItemTable[data.itemCid]

	AssetUtil.LoadImage(self, EquipApi:GetEquipImagePath(data.cid), self.EquipImage:GetComponent("Image"))

	if self.mainView.gameObject.name == "EquipView" then
		AssetUtil.LoadImage(self, EquipApi:GetEquipCenterHoleBg(self.partIndex, itemCfg.Quality), self.QualityImage:GetComponent("Image"))
	else
		AssetUtil.LoadImage(self, EquipApi:GetEquipWarehouseQualityImagePath(self.partIndex, itemCfg.Quality), self.QualityImage:GetComponent("Image"))
	end

	self:__ShowQualityEffect(itemCfg.Quality)
	self.EquipLevelTipsText:SetActive(true)
	UGUIUtil.SetText(self.EquipLevelNumText, data.lv)
end

function EquipCellView:SetSelectState(isSelect)
	self.isChoose = isSelect

	self.SelectedFrame.gameObject:SetActive(self.isChoose)
end

function EquipCellView:SetPartName(index)
	LuaUtility.SetText(self.textPartName, EquipApi:GetPartName(index))
end

function EquipCellView:OnAddListeners()
	self.gameObject:GetComponent("Toggle").onValueChanged:AddListener(self.OnEquipPartChanged)
end

function EquipCellView:OnRemoveListeners()
	self.gameObject:GetComponent("Toggle").onValueChanged:RemoveListener(self.OnEquipPartChanged)
end

function EquipCellView:OnDestroy()
	self:__HideQualityEffect()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

function EquipCellView:__ShowQualityEffect(quality)
	self:__HideQualityEffect()

	local effectCfgId = EquipApi:GetEquipCellQualityEffect(quality)

	if effectCfgId <= 0 then
		return
	end

	if self.EffectRoot == nil then
		return
	end

	self.constantEffectId = GameEntry.Effect:PlayUIMountPointEffect(effectCfgId, 50000, 0, self.EffectRoot, 0)
end

function EquipCellView:__HideQualityEffect()
	if self.constantEffectId == nil then
		return
	end

	GameEntry.Effect:StopEffect(self.constantEffectId)

	self.constantEffectId = nil
end

return EquipCellView
