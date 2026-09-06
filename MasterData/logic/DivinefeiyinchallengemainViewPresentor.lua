-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengemainViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengemainViewPresentor", package.seeall)

local DivinefeiyinchallengemainViewPresentor = class("DivinefeiyinchallengemainViewPresentor", ViewPresentor)

function DivinefeiyinchallengemainViewPresentor:ctor()
	DivinefeiyinchallengemainViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengemainview.prefab"
	}
end

function DivinefeiyinchallengemainViewPresentor:buildViews()
	return {
		DivinefeiyinchallengemainView.New()
	}
end

return DivinefeiyinchallengemainViewPresentor
