-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightBoneDragonDungeonGameViewPresentor.lua

module("logic.extensions.originfight.view.OriginFightBoneDragonDungeonGameViewPresentor", package.seeall)

local OriginFightBoneDragonDungeonGameViewPresentor = class("OriginFightBoneDragonDungeonGameViewPresentor", ViewPresentor)

function OriginFightBoneDragonDungeonGameViewPresentor:ctor()
	OriginFightBoneDragonDungeonGameViewPresentor.super.ctor(self)
end

function OriginFightBoneDragonDungeonGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightBoneDragonDungeonGameViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightbonedragondungeongameview.prefab"
	}
end

function OriginFightBoneDragonDungeonGameViewPresentor:buildViews()
	return {
		OriginFightBoneDragonDungeonGameView.New()
	}
end

return OriginFightBoneDragonDungeonGameViewPresentor
