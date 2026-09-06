-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TechingtagPresentor.lua

module("logic.extensions.teachingdungeon.view.TechingtagPresentor", package.seeall)

local TechingtagPresentor = class("TechingtagPresentor", ViewPresentor)

function TechingtagPresentor:ctor()
	TechingtagPresentor.super.ctor(self)
end

function TechingtagPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TechingtagPresentor:dependWhatResources()
	return {
		"ui/views/teachingdungeon/techingtagview.prefab"
	}
end

function TechingtagPresentor:buildViews()
	return {
		TechingtagView.New()
	}
end

return TechingtagPresentor
