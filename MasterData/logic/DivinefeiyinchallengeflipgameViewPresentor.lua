-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengeflipgameViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengeflipgameViewPresentor", package.seeall)

local DivinefeiyinchallengeflipgameViewPresentor = class("DivinefeiyinchallengeflipgameViewPresentor", ViewPresentor)

function DivinefeiyinchallengeflipgameViewPresentor:ctor()
	DivinefeiyinchallengeflipgameViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengeflipgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengeflipgameViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengeflipgameview.prefab"
	}
end

function DivinefeiyinchallengeflipgameViewPresentor:buildViews()
	return {
		DivinefeiyinchallengeflipgameView.New()
	}
end

return DivinefeiyinchallengeflipgameViewPresentor
