-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaSceneViewPresentor.lua

module("logic.extensions.fruitninja.view.FruitNinjaSceneViewPresentor", package.seeall)

local FruitNinjaSceneViewPresentor = class("FruitNinjaSceneViewPresentor", ViewPresentor)

FruitNinjaSceneViewPresentor.PathPre = "ui/views/fruitninja/cell/%s.prefab"
FruitNinjaSceneViewPresentor.TempCellPrefabName = "fruitninjanormalcell"
FruitNinjaSceneViewPresentor.TempClipPrefabName = "fruitninjanormalclip"

function FruitNinjaSceneViewPresentor:ctor()
	FruitNinjaSceneViewPresentor.super.ctor(self)
end

function FruitNinjaSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FruitNinjaSceneViewPresentor:dependWhatResources()
	local resPathList = {}
	local params = self:getOpenParam() or {}

	table.insert(resPathList, "ui/views/fruitninja/fruitninjasceneview.prefab")
	table.insert(resPathList, string.format(FruitNinjaSceneViewPresentor.PathPre, FruitNinjaSceneViewPresentor.TempCellPrefabName))
	table.insert(resPathList, string.format(FruitNinjaSceneViewPresentor.PathPre, FruitNinjaSceneViewPresentor.TempClipPrefabName))

	return resPathList
end

function FruitNinjaSceneViewPresentor:buildViews()
	return {
		FruitNinjaSceneView.New()
	}
end

return FruitNinjaSceneViewPresentor
