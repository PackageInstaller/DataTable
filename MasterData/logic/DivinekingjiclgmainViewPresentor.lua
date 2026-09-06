-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgmainViewPresentor.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgmainViewPresentor", package.seeall)

local DivinekingjiclgmainViewPresentor = class("DivinekingjiclgmainViewPresentor", ViewPresentor)

function DivinekingjiclgmainViewPresentor:ctor()
	DivinekingjiclgmainViewPresentor.super.ctor(self)
end

function DivinekingjiclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekingjiclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingjiclg/divinekingjiclgmainview.prefab"
	}
end

function DivinekingjiclgmainViewPresentor:buildViews()
	return {
		DivinekingjiclgmainView.New()
	}
end

return DivinekingjiclgmainViewPresentor
