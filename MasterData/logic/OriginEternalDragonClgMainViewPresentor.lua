-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/view/OriginEternalDragonClgMainViewPresentor.lua

module("logic.extensions.origineternaldragonclg.view.OriginEternalDragonClgMainViewPresentor", package.seeall)

local OriginEternalDragonClgMainViewPresentor = class("OriginEternalDragonClgMainViewPresentor", ViewPresentor)

function OriginEternalDragonClgMainViewPresentor:ctor()
	OriginEternalDragonClgMainViewPresentor.super.ctor(self)
end

function OriginEternalDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginEternalDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origineternaldragonclg/origineternaldragonclgmainview.prefab"
	}
end

function OriginEternalDragonClgMainViewPresentor:buildViews()
	return {
		OriginEternalDragonClgMainView.New()
	}
end

return OriginEternalDragonClgMainViewPresentor
