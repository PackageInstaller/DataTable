-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgMainViewPresentor.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgMainViewPresentor", package.seeall)

local OriginTSDragonClgMainViewPresentor = class("OriginTSDragonClgMainViewPresentor", ViewPresentor)

function OriginTSDragonClgMainViewPresentor:ctor()
	OriginTSDragonClgMainViewPresentor.super.ctor(self)
end

function OriginTSDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginTSDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origintsdragonclg/origintsdragonclgmainview.prefab"
	}
end

function OriginTSDragonClgMainViewPresentor:buildViews()
	return {
		OriginTSDragonClgMainView.New()
	}
end

return OriginTSDragonClgMainViewPresentor
