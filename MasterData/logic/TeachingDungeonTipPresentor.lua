-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingDungeonTipPresentor.lua

module("logic.extensions.teachingdungeon.view.TeachingDungeonTipPresentor", package.seeall)

local TeachingDungeonTipPresentor = class("TeachingDungeonTipPresentor", ViewPresentor)

function TeachingDungeonTipPresentor:ctor()
	TeachingDungeonTipPresentor.super.ctor(self)
end

function TeachingDungeonTipPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TeachingDungeonTipPresentor:dependWhatResources()
	return {
		"ui/views/teachingdungeon/teachingdungeontip.prefab"
	}
end

function TeachingDungeonTipPresentor:buildViews()
	return {
		TeachingDungeonTip.New()
	}
end

return TeachingDungeonTipPresentor
