-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgMainViewPresentor.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgMainViewPresentor", package.seeall)

local OriginGoldenDragonClgMainViewPresentor = class("OriginGoldenDragonClgMainViewPresentor", ViewPresentor)

function OriginGoldenDragonClgMainViewPresentor:ctor()
	OriginGoldenDragonClgMainViewPresentor.super.ctor(self)
end

function OriginGoldenDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGoldenDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoldendragonclg/origingoldendragonclgmainview.prefab"
	}
end

function OriginGoldenDragonClgMainViewPresentor:buildViews()
	return {
		OriginGoldenDragonClgMainView.New()
	}
end

return OriginGoldenDragonClgMainViewPresentor
