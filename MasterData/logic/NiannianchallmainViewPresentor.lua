-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NiannianchallmainViewPresentor.lua

module("logic.extensions.niannianchall.view.NiannianchallmainViewPresentor", package.seeall)

local NiannianchallmainViewPresentor = class("NiannianchallmainViewPresentor", ViewPresentor)

function NiannianchallmainViewPresentor:ctor()
	NiannianchallmainViewPresentor.super.ctor(self)
end

function NiannianchallmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NiannianchallmainViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianchall/niannianchallmainview.prefab"
	}
end

function NiannianchallmainViewPresentor:buildViews()
	return {
		NianNianChallMainView.New()
	}
end

return NiannianchallmainViewPresentor
