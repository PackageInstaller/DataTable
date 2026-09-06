-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/DivineDualDragonClgLevelViewPresentor.lua

module("logic.extensions.divinedualdragonclg.view.DivineDualDragonClgLevelViewPresentor", package.seeall)

local DivineDualDragonClgLevelViewPresentor = class("DivineDualDragonClgLevelViewPresentor", ViewPresentor)

function DivineDualDragonClgLevelViewPresentor:ctor()
	DivineDualDragonClgLevelViewPresentor.super.ctor(self)
end

function DivineDualDragonClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineDualDragonClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinedualdragonclg/divinedualdragonclglevelview.prefab"
	}
end

function DivineDualDragonClgLevelViewPresentor:buildViews()
	return {
		DivineDualDragonClgLevelView.New()
	}
end

return DivineDualDragonClgLevelViewPresentor
