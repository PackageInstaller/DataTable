-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTaskMainViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkTaskMainViewPresentor", package.seeall)

local ElementSparkTaskMainViewPresentor = class("ElementSparkTaskMainViewPresentor", ViewPresentor)

function ElementSparkTaskMainViewPresentor:ctor()
	ElementSparkTaskMainViewPresentor.super.ctor(self)
end

function ElementSparkTaskMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkTaskMainViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparktaskmainview.prefab"
	}
end

function ElementSparkTaskMainViewPresentor:buildViews()
	return {
		ElementSparkTaskMainView.New()
	}
end

return ElementSparkTaskMainViewPresentor
