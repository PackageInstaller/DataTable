-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkMainViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkMainViewPresentor", package.seeall)

local ElementSparkMainViewPresentor = class("ElementSparkMainViewPresentor", ViewPresentor)

function ElementSparkMainViewPresentor:ctor()
	ElementSparkMainViewPresentor.super.ctor(self)
end

function ElementSparkMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkMainViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkmainview.prefab"
	}
end

function ElementSparkMainViewPresentor:buildViews()
	return {
		ElementSparkMainView.New(),
		MainChatView.New()
	}
end

function ElementSparkMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ElementSparkMainViewPresentor
