-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorMainViewPresentor", package.seeall)

local NsopIllusoryEmperorMainViewPresentor = class("NsopIllusoryEmperorMainViewPresentor", ViewPresentor)

function NsopIllusoryEmperorMainViewPresentor:ctor()
	NsopIllusoryEmperorMainViewPresentor.super.ctor(self)
end

function NsopIllusoryEmperorMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NsopIllusoryEmperorMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/illusoryemperor/nsopillusoryemperormainview.prefab"
	}
end

function NsopIllusoryEmperorMainViewPresentor:buildViews()
	return {
		NsopIllusoryEmperorMainView.New()
	}
end

return NsopIllusoryEmperorMainViewPresentor
