-- chunkname: @IQIGame\\UI\\Chapter\\TerrainDetailView_new.lua

local TerrainDetailView = {}
local TerrainStateItem = require("IQIGame.UI.Chapter.TerrainStateItem_new")

function TerrainDetailView.New(obj)
	local view = Clone(TerrainDetailView)

	view:Init(obj)

	return view
end

function TerrainDetailView:Init(obj)
	self.gameObject = obj

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.TerrainIconPrefab:SetActive(false)
	self.TerrainStatePrefab:SetActive(false)

	self.FriendTerrainIconItems = {}
	self.EnemyTerrainIconItems = {}
	self.TerrainStateItems = {}

	self:AddListeners()
end

function TerrainDetailView:AddListeners()
	return
end

function TerrainDetailView:RemoveListeners()
	return
end

function TerrainDetailView:SetData(mapIdFriendly, mapIdEnemy)
	self:ResetTerrainOverviewFriendItems()

	for i, terrainType in pairs(TerrainModule.GetMap(mapIdFriendly).MapType) do
		local gameObject = UnityEngine.Object.Instantiate(self.TerrainIconPrefab, self.HeroTerrainParent.transform)

		AssetUtil.LoadImage(self, TerrainApi:GetSmallImgPath(terrainType), gameObject:GetComponent("Image"))
		gameObject:SetActive(true)
		self:AddTerrainOverviewFriendItem(gameObject)
	end

	self:ResetTerrainOverviewEnemyItems()

	for i, terrainType in pairs(TerrainModule.GetMap(mapIdEnemy).MapType) do
		local gameObject = UnityEngine.Object.Instantiate(self.TerrainIconPrefab, self.EnemyTerrainParent.transform)

		AssetUtil.LoadImage(self, TerrainApi:GetSmallImgPath(terrainType), gameObject:GetComponent("Image"))
		gameObject:SetActive(true)
		self:AddTerrainOverviewEnemyItem(gameObject)
	end

	local terrainTypeDict = TerrainDetailView:TerrainTypeDict(TerrainModule.GetMap(mapIdFriendly).MapType, TerrainModule.GetMap(mapIdEnemy).MapType)

	self:ResetTerrainStateItems()

	for terrainType, _ in pairs(terrainTypeDict) do
		if not TerrainDetailView:IsNormalTerrainType(terrainType) then
			local terrainStateItem = TerrainStateItem.New(self.TerrainStatePrefab, self.TerrainStateScrollView.transform, terrainType)

			terrainStateItem.gameObject:SetActive(true)
			self:AddTerrainStateItem(terrainStateItem)
		end
	end
end

function TerrainDetailView:TerrainTypeDict(...)
	local res = {}

	for _, list in ipairs({
		...
	}) do
		for _, type in pairs(list) do
			res[type] = true
		end
	end

	return res
end

function TerrainDetailView:IsNormalTerrainType(type)
	return type == 0
end

function TerrainDetailView:ResetTerrainOverviewFriendItems()
	for _, gameObject in pairs(self.FriendTerrainIconItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.FriendTerrainIconItems = {}
end

function TerrainDetailView:AddTerrainOverviewFriendItem(gameObject)
	table.insert(self.FriendTerrainIconItems, gameObject)
end

function TerrainDetailView:ResetTerrainOverviewEnemyItems()
	for _, gameObject in pairs(self.EnemyTerrainIconItems) do
		gameObject.transform:SetParent(nil)
		GameObject.Destroy(gameObject)
	end

	self.EnemyTerrainIconItems = {}
end

function TerrainDetailView:AddTerrainOverviewEnemyItem(gameObject)
	table.insert(self.EnemyTerrainIconItems, gameObject)
end

function TerrainDetailView:ResetTerrainStateItems()
	for _, item in pairs(self.TerrainStateItems) do
		item:OnDestroy()
	end

	self.TerrainStateItems = {}
end

function TerrainDetailView:AddTerrainStateItem(item)
	table.insert(self.TerrainStateItems, item)
end

function TerrainDetailView:Show()
	self.gameObject:SetActive(true)
end

function TerrainDetailView:Hide()
	self.gameObject:SetActive(false)
end

function TerrainDetailView:Dispose()
	self:RemoveListeners()
	self:ResetTerrainOverviewFriendItems()
	self:ResetTerrainOverviewEnemyItems()
	self:ResetTerrainStateItems()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil

	AssetUtil.UnloadAsset(self)
end

return TerrainDetailView
