-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgFmtExViewPresentor.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgFmtExViewPresentor", package.seeall)

local OriginGoldenDragonClgFmtExViewPresentor = class("OriginGoldenDragonClgFmtExViewPresentor", ViewPresentor)

function OriginGoldenDragonClgFmtExViewPresentor:ctor()
	OriginGoldenDragonClgFmtExViewPresentor.super.ctor(self)
end

function OriginGoldenDragonClgFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGoldenDragonClgFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoldendragonclg/origingoldendragonclgfmtexview.prefab"
	}
end

function OriginGoldenDragonClgFmtExViewPresentor:buildViews()
	return {
		OriginGoldenDragonClgFmtExView.New()
	}
end

return OriginGoldenDragonClgFmtExViewPresentor
