-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgResultViewPresentor.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgResultViewPresentor", package.seeall)

local OriginGoldenDragonClgResultViewPresentor = class("OriginGoldenDragonClgResultViewPresentor", ViewPresentor)

function OriginGoldenDragonClgResultViewPresentor:ctor()
	OriginGoldenDragonClgResultViewPresentor.super.ctor(self)
end

function OriginGoldenDragonClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGoldenDragonClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoldendragonclg/origingoldendragonclgresultview.prefab"
	}
end

function OriginGoldenDragonClgResultViewPresentor:buildViews()
	return {
		OriginGoldenDragonClgResultView.New()
	}
end

return OriginGoldenDragonClgResultViewPresentor
