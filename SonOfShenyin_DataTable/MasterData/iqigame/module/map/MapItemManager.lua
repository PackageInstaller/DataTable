-- chunkname: @IQIGame\\Module\\Map\\MapItemManager.lua

local mapItemCell = require("IQIGame.UI.Map.MainMap.MapItemCell")

MapItemManager = {
	mapItemPrefabs = {}
}

function MapItemManager.InitMapItemAsset()
	local assetPathList = {
		[Constant.MapStageType.MainLine] = UIGlobalApi.GetUIPrefab("/_MapMark/MainStagePrefab"),
		[Constant.MapStageType.BranchLine] = UIGlobalApi.GetUIPrefab("/_MapMark/BranchStagePrefab"),
		[Constant.MapStageType.Daily] = UIGlobalApi.GetUIPrefab("/_MapMark/DailyStagePrefab"),
		[Constant.MapStageType.Challenge] = UIGlobalApi.GetUIPrefab("/_MapMark/DailyStagePrefab")
	}

	for k, v in pairs(assetPathList) do
		AssetUtil.LoadAsset(MapItemManager, v, function(_, assetUrl, asset, duration, userData)
			MapItemManager.mapItemPrefabs[k] = asset
		end, nil)
	end
end

function MapItemManager.Initialize()
	MapItemManager.InitMapItemAsset()
end

function MapItemManager.CreateMapItem(stageType, parent, isMark)
	local asset = MapItemManager.mapItemPrefabs[stageType]

	if isMark == true then
		asset = MapItemManager.mapItemPrefabs[Constant.MapStageType.MainLine]
	end

	local obj = UnityEngine.Object.Instantiate(asset)

	obj.transform:SetParent(parent, false)

	return mapItemCell.New(obj)
end

function MapItemManager.ReleaseMapItem(mapItem)
	mapItem:Dispose()
end

function MapItemManager.Shutdown()
	MapItemManager.mapItemPrefabs = {}

	AssetUtil.UnloadAsset(MapItemManager)
end
