-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkbossbridgeViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkbossbridgeViewPresentor", package.seeall)

local ElementsparkbossbridgeViewPresentor = class("ElementsparkbossbridgeViewPresentor", ViewPresentor)

function ElementsparkbossbridgeViewPresentor:ctor()
	ElementsparkbossbridgeViewPresentor.super.ctor(self)
end

function ElementsparkbossbridgeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementsparkbossbridgeViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkbossbridgeview.prefab"
	}
end

function ElementsparkbossbridgeViewPresentor:buildViews()
	return {
		ElementsparkbossbridgeView.New()
	}
end

return ElementsparkbossbridgeViewPresentor
