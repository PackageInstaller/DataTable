-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengecimeliainfoViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengecimeliainfoViewPresentor", package.seeall)

local DivinefeiyinchallengecimeliainfoViewPresentor = class("DivinefeiyinchallengecimeliainfoViewPresentor", ViewPresentor)

function DivinefeiyinchallengecimeliainfoViewPresentor:ctor()
	DivinefeiyinchallengecimeliainfoViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengecimeliainfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengecimeliainfoViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengecimeliainfoview.prefab"
	}
end

function DivinefeiyinchallengecimeliainfoViewPresentor:buildViews()
	return {
		DivinefeiyinchallengecimeliainfoView.New()
	}
end

return DivinefeiyinchallengecimeliainfoViewPresentor
