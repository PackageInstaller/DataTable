-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingDungeonMainViewPresentor.lua

module("logic.extensions.teachingdungeon.view.TeachingDungeonMainViewPresentor", package.seeall)

local TeachingDungeonMainViewPresentor = class("TeachingDungeonMainViewPresentor", ViewWithGuidePresentor)

function TeachingDungeonMainViewPresentor:ctor()
	TeachingDungeonMainViewPresentor.super.ctor(self)
end

function TeachingDungeonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeachingDungeonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/teachingdungeon/teachingdungeonmainview.prefab"
	}
end

function TeachingDungeonMainViewPresentor:buildViews()
	return {
		TeachingDungeonMainView.New()
	}
end

return TeachingDungeonMainViewPresentor
