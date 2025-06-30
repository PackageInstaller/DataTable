-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionFormationCell.lua

local m = {
	Index = 0,
	EquipTagImgComList = {}
}

function m.New(view, index, onToggleChangedCallback)
	local obj = Clone(m)

	obj:Init(view, index, onToggleChangedCallback)

	return obj
end

function m:Init(view, index, onToggleChangedCallback)
	self.View = view
	self.Index = index
	self.OnToggleChangedCallback = onToggleChangedCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnViewToggleChanged(isOn)
		self:OnViewToggleChanged(isOn)
	end

	function self.DelegateOnClickEmptyView()
		self:OnClickEmptyView()
	end

	self.SoulHeadCell = SoulHeadCell.New(self.SoulHeadCellGO, true, false)

	self.SoulHeadCell:SetMouseEnabled(false)

	for i = 1, 3 do
		self.EquipTagImgComList[i] = self["EquipTag" .. i]:GetComponent("Image")
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnViewToggleChanged)
	self.EmptyView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEmptyView)
end

function m:RemoveListeners()
	self.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnViewToggleChanged)
	self.EmptyView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEmptyView)
end

function m:SetData(soulPrefabPOD)
	self.SoulPrefabPOD = soulPrefabPOD

	self.EmptyView:SetActive(soulPrefabPOD == nil)
	self.NormalView:SetActive(soulPrefabPOD ~= nil)

	if soulPrefabPOD == nil then
		return
	end

	local soulData = SoulModule.CreateCustomSoulData(soulPrefabPOD.soulCid, {
		mood = 150,
		cid = soulPrefabPOD.soulCid,
		lv = soulPrefabPOD.lv,
		dress2DCid = soulPrefabPOD.dress2DCid,
		dress3DCid = soulPrefabPOD.dress3DCid,
		qualityId = soulPrefabPOD.qualityId,
		soulAttr = soulPrefabPOD.attr,
		activationSkillStrengthen = soulPrefabPOD.allSkillStrengths
	})

	self.SoulHeadCell:RefreshView(soulData)
	self.FrontTag:SetActive(soulPrefabPOD.position == 1)
	self.BackTag:SetActive(soulPrefabPOD.position == 2)

	for i = 1, #self.EquipTagImgComList do
		local imageCom = self.EquipTagImgComList[i]
		local equipId = soulPrefabPOD.equipments[i]
		local quality

		if equipId ~= nil and equipId ~= 0 then
			local itemData = WarehouseModule.GetItemDataById(equipId)

			quality = itemData:GetCfg().Quality
		end

		AssetUtil.LoadImage(self, EvilErosionLevelDetailUIApi:GetString("FormationCell_EquipTagPath", quality), imageCom)
	end
end

function m:SetSelected()
	local toggle = self.View:GetComponent("Toggle")

	if toggle.isOn then
		return false
	end

	toggle.isOn = true

	return true
end

function m:OnViewToggleChanged(isOn)
	if isOn then
		self.OnToggleChangedCallback(self.Index, false)
	end
end

function m:OnClickEmptyView()
	self.OnToggleChangedCallback(self.Index, true)
end

function m:IsSelected()
	local toggle = self.View:GetComponent("Toggle")

	return toggle.isOn
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.SoulHeadCell:Dispose()

	for i = 1, #self.EquipTagImgComList do
		self.EquipTagImgComList[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.SoulPrefabPOD = nil
end

return m
