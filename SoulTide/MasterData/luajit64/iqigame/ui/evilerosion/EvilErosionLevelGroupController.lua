-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionLevelGroupController.lua

local EvilErosionLevelCell = require("IQIGame.UI.EvilErosion.EvilErosionLevelCell")
local m = {
	BuildingView = false,
	LevelCells = {}
}

function m.New(parentGO, uiController)
	local obj = Clone(m)

	obj:Init(parentGO, uiController)

	return obj
end

function m:Init(parentGO, uiController)
	self.ParentGO = parentGO
	self.UIController = uiController
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:Refresh()
	local levelIndex = table.indexOf(EvilErosionModule.GetGlobalData().EvilErosionLevel, EvilErosionModule.GetCurrentLevelCid())
	local levelGroupPrefabPath = UIGlobalApi.GetUIPrefab(EvilErosionUIApi:GetString("LevelGroupPrefabPath", levelIndex))

	if self.LastPath ~= levelGroupPrefabPath then
		if self.BuildingView then
			logError("恶域蚀入主界面关卡组资源正在加载，刷新失败。")

			return
		end

		if self.LastPath ~= nil then
			self:ClearView()
			UnityEngine.Object.Destroy(self.View)
		end

		self.LastPath = levelGroupPrefabPath

		self:RebuildView(levelGroupPrefabPath)
	else
		self:RefreshData()
	end
end

function m:RebuildView(path)
	self.BuildingView = true

	local prefab = self.UIController:GetPreloadedAsset(path)

	if prefab ~= nil then
		self:OnAssetPreparedOnRebuild(prefab)
	else
		AssetUtil.LoadAsset(self, path, self.OnLoadBgSuccess)
	end
end

function m:OnLoadBgSuccess(assetName, asset, duration, userData)
	self:OnAssetPreparedOnRebuild(asset)
end

function m:OnAssetPreparedOnRebuild(prefab)
	self.View = UnityEngine.Object.Instantiate(prefab)

	self.View.transform:SetParent(self.ParentGO.transform, false)
	LuaCodeInterface.BindOutlet(self.View, self)
	UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), self.View)
	self:OnInit()
	self:AddListeners()

	self.BuildingView = false

	self:RefreshData()
end

function m:OnInit()
	for i = 1, 5 do
		local cell = EvilErosionLevelCell.New(UnityEngine.Object.Instantiate(self.CellPrefab))

		cell.View.transform:SetParent(self.PointNode.transform:Find("Point_" .. i), false)
		table.insert(self.LevelCells, cell)
	end
end

function m:RefreshData()
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()

	for i = 1, #cfgEvilErosionGlobalData.EvilErosionLevel, 5 do
		local isInThisGroup = false

		for j = 0, 4 do
			local levelIndex = i + j
			local levelCid = cfgEvilErosionGlobalData.EvilErosionLevel[levelIndex]

			if levelCid == EvilErosionModule.GetCurrentLevelCid() then
				isInThisGroup = true

				break
			end
		end

		if isInThisGroup then
			for j = 0, 4 do
				local levelIndex = i + j
				local levelCid = cfgEvilErosionGlobalData.EvilErosionLevel[levelIndex]
				local cellIndex = j + 1
				local cell = self.LevelCells[cellIndex]

				cell:SetData(levelCid, cellIndex)
			end

			break
		end
	end
end

function m:ClearView()
	self:RemoveListeners()

	for i = 1, #self.LevelCells do
		local cell = self.LevelCells[i]

		cell:Dispose()
	end

	self.LevelCells = {}

	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)
end

function m:Dispose()
	self:ClearView()

	self.ParentGO = nil
	self.View = nil
end

return m
