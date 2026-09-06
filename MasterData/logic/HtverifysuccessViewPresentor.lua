-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HtverifysuccessViewPresentor.lua

module("logic.extensions.herotrial.view.HtverifysuccessViewPresentor", package.seeall)

local HtverifysuccessViewPresentor = class("HtverifysuccessViewPresentor", ViewPresentor)

function HtverifysuccessViewPresentor:ctor()
	HtverifysuccessViewPresentor.super.ctor(self)
end

function HtverifysuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HtverifysuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/herotrial/htverifysuccessview.prefab"
	}
end

function HtverifysuccessViewPresentor:buildViews()
	return {
		HTverifysuccessView.New()
	}
end

return HtverifysuccessViewPresentor
