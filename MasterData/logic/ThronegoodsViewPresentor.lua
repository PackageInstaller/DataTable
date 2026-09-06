-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronegoodsViewPresentor.lua

module("logic.extensions.throne.view.ThronegoodsViewPresentor", package.seeall)

local ThronegoodsViewPresentor = class("ThronegoodsViewPresentor", ViewWithGuidePresentor)

function ThronegoodsViewPresentor:ctor()
	ThronegoodsViewPresentor.super.ctor(self)
end

function ThronegoodsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThronegoodsViewPresentor:dependWhatResources()
	return {
		"ui/views/throne/thronegoodsview.prefab"
	}
end

function ThronegoodsViewPresentor:buildViews()
	return {
		ThronegoodsView.New()
	}
end

function ThronegoodsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ThronegoodsViewPresentor
