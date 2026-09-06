-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengeballoonViewPresentor.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengeballoonViewPresentor", package.seeall)

local DivinefeiyinchallengeballoonViewPresentor = class("DivinefeiyinchallengeballoonViewPresentor", ViewPresentor)

function DivinefeiyinchallengeballoonViewPresentor:ctor()
	DivinefeiyinchallengeballoonViewPresentor.super.ctor(self)
end

function DivinefeiyinchallengeballoonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefeiyinchallengeballoonViewPresentor:dependWhatResources()
	return {
		"ui/views/divinefeiyin/divinefeiyinchallengeballoonview.prefab"
	}
end

function DivinefeiyinchallengeballoonViewPresentor:buildViews()
	return {
		DivinefeiyinchallengeballoonView.New()
	}
end

return DivinefeiyinchallengeballoonViewPresentor
