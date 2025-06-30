-- chunkname: @IQIGame\\UI\\Soul\\SoulCenterView.lua

local SoulCenterView = {
	loadInfoDic = {},
	soulPrefabPool = {}
}

function SoulCenterView.New(go, mainView)
	local o = Clone(SoulCenterView)

	o:Initialize(go, mainView)

	return o
end

function SoulCenterView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.mainView = mainView
	self.scrollList = self.goSoulList:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(cell)
		self:OnReachedMainPos(cell)
	end

	function self.scrollList.onBeginDrag(PointerEventData)
		self:OnBeginDrag(PointerEventData)
	end
end

function SoulCenterView:Refresh(soulData, switchList)
	self.soulData = soulData
	self.switchList = switchList

	self:RefreshList()
end

function SoulCenterView:OnHide()
	return
end

function SoulCenterView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulCenterView:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local soulData = self.switchList[luaIndex]
	local soulCid = soulData.soulCid
	local resCid = soulData:GetCfgDress2D().SoulResID

	if cell.transform.childCount > 0 then
		cell.transform:GetChild(0).transform:SetParent(self.goPool.transform, false)
	end

	local key = self:GetPrefabKey(soulCid, resCid)
	local soulPrefab = self.soulPrefabPool[key]

	if soulPrefab ~= nil then
		soulPrefab.transform:SetParent(cell.transform, false)
	else
		if self.loadInfoDic[key] == key then
			return
		end

		self.loadInfoDic[key] = key

		AssetUtil.LoadAsset(self, UIGlobalApi.GetSoulPortraitPath(soulCid, resCid), self.OnLoadSoulPrefabSuccess, nil, {
			cell,
			key
		})
	end

	local tabIndex = self.mainView.curTagIndex

	if tabIndex == nil then
		tabIndex = self.mainView.defaultTagIndex
	end
end

function SoulCenterView:OnReachedMainPos(cell)
	local luaIndex = cell.index + 1
	local soulData = self.switchList[luaIndex]

	self.mainView:Refresh(soulData)
end

function SoulCenterView:OnBeginDrag(PointerEventData)
	return
end

function SoulCenterView:OnLoadSoulPrefabSuccess(assetName, asset, duration, userData)
	local cell = userData[1]
	local key = userData[2]
	local luaIndex = cell.index + 1
	local cellSoulData = self.switchList[luaIndex]
	local cellSoulCid = cellSoulData.soulCid
	local cellResCid = cellSoulData:GetCfgDress2D().SoulResID
	local curCellKey = self:GetPrefabKey(cellSoulCid, cellResCid)
	local soulPrefab = UnityEngine.Object.Instantiate(asset)

	self.soulPrefabPool[key] = soulPrefab

	if self.loadInfoDic[key] == key and curCellKey == key then
		soulPrefab.transform:SetParent(cell.transform, false)
	else
		soulPrefab.transform:SetParent(self.goPool.transform, false)
	end

	self.loadInfoDic[key] = nil
end

function SoulCenterView:RefreshList()
	local soulIndex

	for i, v in ipairs(self.switchList) do
		if v.soulCid == self.soulData.soulCid then
			soulIndex = i

			break
		end
	end

	self.loadInfoDic = {}
	self.scrollList.startIndex = soulIndex - 1

	self.scrollList:Refresh(#self.switchList)
end

function SoulCenterView:SetActive(vs)
	self.goView:SetActive(vs)
end

function SoulCenterView:GetPrefabKey(soulCid, resCid)
	return soulCid .. "_" .. resCid
end

return SoulCenterView
