-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/view/FireDimensionLevelViewPresentor.lua

module("logic.extensions.firedimension.view.FireDimensionLevelViewPresentor", package.seeall)

local FireDimensionLevelViewPresentor = class("FireDimensionLevelViewPresentor", ViewPresentor)

FireDimensionLevelViewPresentor.Effect1 = "20230602/shenyaohuociyuan/fx_ui_shenyaohuociyuan_fw.prefab"
FireDimensionLevelViewPresentor.Effect2 = "20230602/shenyaohuociyuan/fx_ui_shenyaohuociyuan02_fw.prefab"
FireDimensionLevelViewPresentor.Effect3 = "20230602/shenyaohuociyuan/fx_ui_shenyaohuociyuan03_fw.prefab"

function FireDimensionLevelViewPresentor:ctor()
	FireDimensionLevelViewPresentor.super.ctor(self)
end

function FireDimensionLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FireDimensionLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/firedimension/firedimensionlevelview.prefab"
	}
end

function FireDimensionLevelViewPresentor:buildViews()
	return {
		FireDimensionLevelView.New()
	}
end

return FireDimensionLevelViewPresentor
