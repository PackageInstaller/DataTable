-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkEditViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkEditViewPresentor", package.seeall)

local ElementSparkEditViewPresentor = class("ElementSparkEditViewPresentor", ViewPresentor)

function ElementSparkEditViewPresentor:ctor()
	ElementSparkEditViewPresentor.super.ctor(self)
end

function ElementSparkEditViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkEditViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkeditview.prefab"
	}
end

function ElementSparkEditViewPresentor:buildViews()
	return {
		ElementSparkEditView.New()
	}
end

return ElementSparkEditViewPresentor
