-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/view/FireDimensionViewPresentor.lua

module("logic.extensions.firedimension.view.FireDimensionViewPresentor", package.seeall)

local FireDimensionViewPresentor = class("FireDimensionViewPresentor", ViewPresentor)

FireDimensionViewPresentor.Effect1 = "20230602/shenyaohuociyuan/fx_ui_syhcyhud_fw.prefab"

function FireDimensionViewPresentor:ctor()
	FireDimensionViewPresentor.super.ctor(self)
end

function FireDimensionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FireDimensionViewPresentor:dependWhatResources()
	return {
		"ui/views/firedimension/firedimensionview.prefab"
	}
end

function FireDimensionViewPresentor:buildViews()
	return {
		FireDimensionView.New()
	}
end

return FireDimensionViewPresentor
