-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkResourceViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkResourceViewPresentor", package.seeall)

local ElementSparkResourceViewPresentor = class("ElementSparkResourceViewPresentor", ViewPresentor)

function ElementSparkResourceViewPresentor:ctor()
	ElementSparkResourceViewPresentor.super.ctor(self)
end

function ElementSparkResourceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkResourceViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkresourceview.prefab"
	}
end

function ElementSparkResourceViewPresentor:buildViews()
	return {
		ElementSparkResourceView.New()
	}
end

return ElementSparkResourceViewPresentor
