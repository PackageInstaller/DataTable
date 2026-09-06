-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgFightEndViewPresentor.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgFightEndViewPresentor", package.seeall)

local OriginTSDragonClgFightEndViewPresentor = class("OriginTSDragonClgFightEndViewPresentor", ViewPresentor)

function OriginTSDragonClgFightEndViewPresentor:ctor()
	OriginTSDragonClgFightEndViewPresentor.super.ctor(self)
end

function OriginTSDragonClgFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginTSDragonClgFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/origintsdragonclg/origintsdragonclgfightendview.prefab"
	}
end

function OriginTSDragonClgFightEndViewPresentor:buildViews()
	return {
		OriginTSDragonClgFightEndView.New()
	}
end

return OriginTSDragonClgFightEndViewPresentor
