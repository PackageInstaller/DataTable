-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NsopMagicChallengeMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.NsopMagicChallengeMainViewPresentor", package.seeall)

local NsopMagicChallengeMainViewPresentor = class("NsopMagicChallengeMainViewPresentor", ViewPresentor)

function NsopMagicChallengeMainViewPresentor:ctor()
	NsopMagicChallengeMainViewPresentor.super.ctor(self)
end

function NsopMagicChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NsopMagicChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/nsopmagicchallengemainview.prefab"
	}
end

function NsopMagicChallengeMainViewPresentor:buildViews()
	return {
		NsopMagicChallengeMainView.New()
	}
end

return NsopMagicChallengeMainViewPresentor
