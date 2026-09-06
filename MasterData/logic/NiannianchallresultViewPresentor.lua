-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NiannianchallresultViewPresentor.lua

module("logic.extensions.niannianchall.view.NiannianchallresultViewPresentor", package.seeall)

local NiannianchallresultViewPresentor = class("NiannianchallresultViewPresentor", ViewPresentor)

function NiannianchallresultViewPresentor:ctor()
	NiannianchallresultViewPresentor.super.ctor(self)
end

function NiannianchallresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NiannianchallresultViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianchall/niannianchallresultview.prefab"
	}
end

function NiannianchallresultViewPresentor:buildViews()
	return {
		NianNianChallResultView.New()
	}
end

return NiannianchallresultViewPresentor
