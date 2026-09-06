-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgFmtViewPresentor.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgFmtViewPresentor", package.seeall)

local OriginTSDragonClgFmtViewPresentor = class("OriginTSDragonClgFmtViewPresentor", ViewPresentor)

function OriginTSDragonClgFmtViewPresentor:ctor()
	OriginTSDragonClgFmtViewPresentor.super.ctor(self)
end

function OriginTSDragonClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginTSDragonClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/origintsdragonclg/origintsdragonclgfmtview.prefab"
	}
end

function OriginTSDragonClgFmtViewPresentor:buildViews()
	return {
		OriginTSDragonClgFmtView.New()
	}
end

return OriginTSDragonClgFmtViewPresentor
