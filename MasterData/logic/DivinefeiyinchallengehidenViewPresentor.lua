-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengehidenViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengehidenViewPresentor", package.seeall)

local DivinefeiyinchallengehidenViewPresentor = class("DivinefeiyinchallengehidenViewPresentor", ViewPresentor)

function DivinefeiyinchallengehidenViewPresentor:ctor()
	DivinefeiyinchallengehidenViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengehidenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengehidenViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengehidenview.prefab"
	}
end

function DivinefeiyinchallengehidenViewPresentor:buildViews()
	return {
		DivinefeiyinchallengehidenView.New()
	}
end

return DivinefeiyinchallengehidenViewPresentor
