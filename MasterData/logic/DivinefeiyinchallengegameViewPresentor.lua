-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengegameViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengegameViewPresentor", package.seeall)

local DivinefeiyinchallengegameViewPresentor = class("DivinefeiyinchallengegameViewPresentor", ViewPresentor)

function DivinefeiyinchallengegameViewPresentor:ctor()
	DivinefeiyinchallengegameViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengegameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengegameViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengegameview.prefab"
	}
end

function DivinefeiyinchallengegameViewPresentor:buildViews()
	return {
		DivinefeiyinchallengegameView.New()
	}
end

return DivinefeiyinchallengegameViewPresentor
