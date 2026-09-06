-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NiannianchallViewPresentor.lua

module("logic.extensions.niannianchall.view.NiannianchallViewPresentor", package.seeall)

local NiannianchallViewPresentor = class("NiannianchallViewPresentor", ViewPresentor)

function NiannianchallViewPresentor:ctor()
	NiannianchallViewPresentor.super.ctor(self)
end

function NiannianchallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NiannianchallViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianchall/niannianchallview.prefab"
	}
end

function NiannianchallViewPresentor:buildViews()
	return {
		NianNianChallView.New()
	}
end

return NiannianchallViewPresentor
