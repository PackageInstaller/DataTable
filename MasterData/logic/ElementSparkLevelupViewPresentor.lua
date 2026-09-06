-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkLevelupViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkLevelupViewPresentor", package.seeall)

local ElementSparkLevelupViewPresentor = class("ElementSparkLevelupViewPresentor", ViewPresentor)

function ElementSparkLevelupViewPresentor:ctor()
	ElementSparkLevelupViewPresentor.super.ctor(self)
end

function ElementSparkLevelupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkLevelupViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparklevelupview.prefab"
	}
end

function ElementSparkLevelupViewPresentor:buildViews()
	return {
		ElementSparkLevelupView.New()
	}
end

return ElementSparkLevelupViewPresentor
