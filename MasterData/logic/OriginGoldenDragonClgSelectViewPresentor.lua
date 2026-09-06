-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgSelectViewPresentor.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgSelectViewPresentor", package.seeall)

local OriginGoldenDragonClgSelectViewPresentor = class("OriginGoldenDragonClgSelectViewPresentor", ViewPresentor)

function OriginGoldenDragonClgSelectViewPresentor:ctor()
	OriginGoldenDragonClgSelectViewPresentor.super.ctor(self)
end

function OriginGoldenDragonClgSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGoldenDragonClgSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoldendragonclg/origingoldendragonclgselectview.prefab"
	}
end

function OriginGoldenDragonClgSelectViewPresentor:buildViews()
	return {
		OriginGoldenDragonClgSelectView.New()
	}
end

return OriginGoldenDragonClgSelectViewPresentor
