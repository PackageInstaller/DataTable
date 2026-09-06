-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengecimeliaViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengecimeliaViewPresentor", package.seeall)

local DivinefeiyinchallengecimeliaViewPresentor = class("DivinefeiyinchallengecimeliaViewPresentor", ViewPresentor)

function DivinefeiyinchallengecimeliaViewPresentor:ctor()
	DivinefeiyinchallengecimeliaViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengecimeliaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengecimeliaViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengecimeliaview.prefab"
	}
end

function DivinefeiyinchallengecimeliaViewPresentor:buildViews()
	return {
		DivinefeiyinchallengecimeliaView.New()
	}
end

return DivinefeiyinchallengecimeliaViewPresentor
