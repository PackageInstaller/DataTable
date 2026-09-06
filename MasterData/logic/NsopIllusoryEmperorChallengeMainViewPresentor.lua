-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorChallengeMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorChallengeMainViewPresentor", package.seeall)

local NsopIllusoryEmperorChallengeMainViewPresentor = class("NsopIllusoryEmperorChallengeMainViewPresentor", ViewPresentor)

function NsopIllusoryEmperorChallengeMainViewPresentor:ctor()
	NsopIllusoryEmperorChallengeMainViewPresentor.super.ctor(self)
end

function NsopIllusoryEmperorChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NsopIllusoryEmperorChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/illusoryemperor/nsopillusoryemperorchallengemainview.prefab"
	}
end

function NsopIllusoryEmperorChallengeMainViewPresentor:buildViews()
	return {
		NsopIllusoryEmperorChallengeMainView.New()
	}
end

return NsopIllusoryEmperorChallengeMainViewPresentor
