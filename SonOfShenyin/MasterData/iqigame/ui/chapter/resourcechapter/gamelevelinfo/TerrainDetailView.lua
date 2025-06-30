-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\TerrainDetailView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.MapTypeList = {}
	self.HeroTerrainList = {}
	self.EnemyTerrainList = {}

	local count = self.HeroTerrainParent.transform.childCount

	for i = 1, count do
		table.insert(self.HeroTerrainList, self.HeroTerrainParent.transform:GetChild(i - 1).gameObject)
	end

	count = self.EnemyTerrainParent.transform.childCount

	for i = 1, count do
		table.insert(self.EnemyTerrainList, self.EnemyTerrainParent.transform:GetChild(i - 1).gameObject)
	end

	self.TerrainwrapContent = self.TerrainStateParent:GetComponent("ScrollAreaList")

	function self.TerrainwrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	local texts = ChapterUIApi:GetPassInfoPanelTerrainInfo()

	UGUIUtil.SetText(self.OwnText, texts[1])
	UGUIUtil.SetText(self.EnemyText, texts[2])
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(mapID)
	self.MapDataCfg = CfgMapTable[mapID]
end

function m:ShowTerrainInfo()
	self.MapTypeList = {}

	for k, v in ipairs(self.MapDataCfg.MapType[1]) do
		if not self:IsHasMapType(v) then
			table.insert(self.MapTypeList, v)
		end
	end

	for k, v in ipairs(self.MapDataCfg.MapType[2]) do
		if not self:IsHasMapType(v) then
			table.insert(self.MapTypeList, v)
		end
	end

	table.sort(self.MapTypeList, function(a, b)
		return a < b
	end)
	self.TerrainwrapContent:Refresh(#self.MapTypeList)
	LuaUtility.SetGameObjectShow(self.noneState, #self.MapTypeList <= 0)
end

function m:IsHasMapType(mapType)
	for k, v in pairs(self.MapTypeList) do
		if v == mapType then
			return true
		end
	end

	return false
end

function m:OnRenderItem(cell)
	local Itemtable = {}

	LuaCodeInterface.BindOutlet(cell.gameObject, Itemtable)

	local path = ChapterUIApi:GetMapImg(self.MapTypeList[cell.index + 1])

	AssetUtil.LoadImage(self, path, Itemtable.TerrainImg:GetComponent("Image"))
	UGUIUtil.SetText(Itemtable.TerrainText, ChapterUIApi:GetMapTypeText(self.MapTypeList[cell.index + 1]))
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
