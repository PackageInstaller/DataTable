-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengeballoontipsViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengeballoontipsViewPresentor", package.seeall)

local DivinefeiyinchallengeballoontipsViewPresentor = class("DivinefeiyinchallengeballoontipsViewPresentor", ViewPresentor)

function DivinefeiyinchallengeballoontipsViewPresentor:ctor()
	DivinefeiyinchallengeballoontipsViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengeballoontipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivinefeiyinchallengeballoontipsViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengeballoontipsview.prefab"
	}
end

function DivinefeiyinchallengeballoontipsViewPresentor:buildViews()
	return {
		DivinefeiyinchallengeballoontipsView.New()
	}
end

return DivinefeiyinchallengeballoontipsViewPresentor
