-- chunkname: @IQIGame\\UI\\Formation\\FormationTerrainDetailsView.lua

local m = {
	terrainItemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self:AddListeners()
	self.noneState.gameObject:SetActive(false)
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:SetData(friendly)
	self:SetTerrainInfo(friendly)
end

function m:SetTerrainInfo(friendly)
	local environmentBuff = FormationModule.GetFormationEnvironmentBuff(FormationModule.CfgDupStageOrStoryBattleCfg, friendly)
	local totalEnvironmentBuff = {}

	for i, v in pairs(environmentBuff) do
		table.addAll(totalEnvironmentBuff, v)
	end

	local map = FormationModule.GetFormationTerrainData(FormationModule.CfgDupStageOrStoryBattleCfg, friendly)
	local allTerrainTypes = FormationModule.GetAllTerrainType(map.MapType)
	local list = {}

	table.addAll(list, totalEnvironmentBuff)
	table.addAll(list, allTerrainTypes)

	for i = 1, #self.terrainItemList do
		self.terrainItemList[i].View:SetActive(i <= #list)
	end

	local count = #list

	if count == 0 then
		self.noneState.gameObject:SetActive(true)

		return
	end

	self.noneState.gameObject:SetActive(false)

	for i = 1, #list do
		local cell = self:CreateTerrainItem(i)

		cell.terrainParent:SetActive(false)
		cell.weatherParent:SetActive(false)

		if i <= #totalEnvironmentBuff then
			cell.weatherParent:SetActive(true)

			local buffCfg = CfgBuffTable[list[i]]

			UGUIUtil.SetText(cell.titleText, buffCfg.Name)
			UGUIUtil.SetText(cell.weatherText, buffCfg.Describe)
			AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(buffCfg.Icon), cell.weatherImg:GetComponent("Image"))
		else
			cell.terrainParent:SetActive(true)

			local terrainCfg = CfgTerrainTable[list[i]]

			UGUIUtil.SetText(cell.TerrainName, terrainCfg.Name)
			UGUIUtil.SetText(cell.TerrainDesc, terrainCfg.Describe)
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(terrainCfg.TipsTerrainImg), cell.TerrainImg:GetComponent("Image"))
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(terrainCfg.SmallTerrainImg), cell.TerrainTitleImg:GetComponent("Image"))

			local buffs = terrainCfg.Buff

			for j = 1, #cell.attrList do
				cell.attrList[j].View:SetActive(j <= #buffs)
			end

			for j = 1, #buffs do
				local attrItme = self:CreateAttrItem(cell.attrList, j, cell.AttDescPrefab, cell.AttDescParent)

				UGUIUtil.SetText(attrItme.AttText, CfgBuffTable[buffs[j]].Describe)
				AssetUtil.LoadImage(self, BattleApi:GetAttributeIconUrl(CfgBuffTable[buffs[j]].Icon), attrItme.AttImg:GetComponent("Image"))
			end
		end
	end
end

function m:CreateTerrainItem(index)
	local item = self.terrainItemList[index]

	if item == nil then
		local obj = UnityEngine.Object.Instantiate(self.TerrainItemPrefab)

		obj.transform:SetParent(self.TerrainItemParent.transform, false)
		obj:SetActive(true)

		local bindlua = {
			attrList = {}
		}

		LuaCodeInterface.BindOutlet(obj, bindlua)

		self.terrainItemList[index] = bindlua
	end

	return self.terrainItemList[index]
end

function m:CreateAttrItem(attrList, index, prefab, parent)
	local item = attrList[index]

	if item == nil then
		local obj = UnityEngine.Object.Instantiate(prefab)

		obj.transform:SetParent(parent.transform, false)
		obj:SetActive(true)

		local bindlua = {}

		LuaCodeInterface.BindOutlet(obj, bindlua)

		attrList[index] = bindlua
	end

	return attrList[index]
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
