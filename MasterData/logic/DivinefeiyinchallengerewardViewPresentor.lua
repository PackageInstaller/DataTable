-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengerewardViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengerewardViewPresentor", package.seeall)

local DivinefeiyinchallengerewardViewPresentor = class("DivinefeiyinchallengerewardViewPresentor", ViewPresentor)

function DivinefeiyinchallengerewardViewPresentor:ctor()
	DivinefeiyinchallengerewardViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengerewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengerewardViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengerewardview.prefab"
	}
end

function DivinefeiyinchallengerewardViewPresentor:buildViews()
	return {
		DivinefeiyinchallengerewardView.New()
	}
end

return DivinefeiyinchallengerewardViewPresentor
