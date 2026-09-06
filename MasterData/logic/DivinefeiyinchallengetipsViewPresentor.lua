-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengetipsViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengetipsViewPresentor", package.seeall)

local DivinefeiyinchallengetipsViewPresentor = class("DivinefeiyinchallengetipsViewPresentor", ViewPresentor)

function DivinefeiyinchallengetipsViewPresentor:ctor()
	DivinefeiyinchallengetipsViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengetipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengetipsViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengetipsview.prefab"
	}
end

function DivinefeiyinchallengetipsViewPresentor:buildViews()
	return {
		DivinefeiyinchallengetipsView.New()
	}
end

return DivinefeiyinchallengetipsViewPresentor
