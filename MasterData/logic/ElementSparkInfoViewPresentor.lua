-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkInfoViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkInfoViewPresentor", package.seeall)

local ElementSparkInfoViewPresentor = class("ElementSparkInfoViewPresentor", ViewPresentor)

function ElementSparkInfoViewPresentor:ctor()
	ElementSparkInfoViewPresentor.super.ctor(self)
end

function ElementSparkInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkinfoview.prefab"
	}
end

function ElementSparkInfoViewPresentor:buildViews()
	return {
		ElementSparkInfoView.New()
	}
end

return ElementSparkInfoViewPresentor
