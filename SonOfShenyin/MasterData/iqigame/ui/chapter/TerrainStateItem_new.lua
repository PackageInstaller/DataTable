-- chunkname: @IQIGame\\UI\\Chapter\\TerrainStateItem_new.lua

local TerrainStateItem = {}

function TerrainStateItem.New(gameObjectPrefab, parentTransform, terrainType)
	local tbl = Clone(TerrainStateItem)
	local obj = UnityEngine.Object.Instantiate(gameObjectPrefab, parentTransform)

	tbl.terrainType = terrainType

	tbl:OnInit(obj)

	return tbl
end

function TerrainStateItem:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(gameObject, self)
	self.BuffPrefab:SetActive(false)

	local terrainCfg = CfgTerrainTable[self.terrainType]

	AssetUtil.LoadImage(self, TerrainApi:GetTipsImgPath(self.terrainType), self.BigIconImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, TerrainApi:GetSmallImgPath(self.terrainType), self.DetailIconImage:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, terrainCfg.Name)
	UGUIUtil.SetText(self.DescribeText, terrainCfg.Describe)

	for i, buffID in pairs(terrainCfg.Buff or {}) do
		local buffItem = self:NewBuffItem(self.BuffPrefab, self.BuffScrollView.transform, buffID)

		buffItem.gameObject:SetActive(true)
	end
end

function TerrainStateItem:OnDestroy(userData)
	logDebug("TerrainStateItem:OnDestroy")
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	self.gameObject.transform:SetParent(nil)
	GameObject.Destroy(self.gameObject)
	AssetUtil.UnloadAsset(self)
end

function TerrainStateItem:OnAddListeners()
	return
end

function TerrainStateItem:OnRemoveListeners()
	return
end

function TerrainStateItem:NewBuffItem(gameObjectPrefab, parentTransform, buffID)
	local obj = UnityEngine.Object.Instantiate(gameObjectPrefab, parentTransform)
	local tbl = {
		gameObject = obj
	}

	LuaCodeInterface.BindOutlet(obj, tbl)
	UGUIUtil.SetText(tbl.DescribeText, CfgBuffTable[buffID].Describe)

	if CfgBuffTable[buffID].Icon ~= "" then
		AssetUtil.LoadImage(self, TerrainApi:GetBuffIconUrl(CfgBuffTable[buffID].Icon), tbl.IconImage:GetComponent("Image"))
	end

	return tbl
end

return TerrainStateItem
