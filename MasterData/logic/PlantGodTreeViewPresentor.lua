-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/view/PlantGodTreeViewPresentor.lua

module("logic.extensions.plantgodtree.view.PlantGodTreeViewPresentor", package.seeall)

local PlantGodTreeViewPresentor = class("PlantGodTreeViewPresentor", ViewPresentor)

function PlantGodTreeViewPresentor:ctor()
	PlantGodTreeViewPresentor.super.ctor(self)
end

function PlantGodTreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlantGodTreeViewPresentor:dependWhatResources()
	return {
		"ui/views/plantgodtree/plantgodtreeview.prefab"
	}
end

function PlantGodTreeViewPresentor:buildViews()
	return {
		PlantGodTreeView.New()
	}
end

return PlantGodTreeViewPresentor
