-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/newerachallenge/NewEraQiClgLevelViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.newerachallenge.NewEraQiClgLevelViewPresentor", package.seeall)

local NewEraQiClgLevelViewPresentor = class("NewEraQiClgLevelViewPresentor", ViewPresentor)

function NewEraQiClgLevelViewPresentor:ctor()
	NewEraQiClgLevelViewPresentor.super.ctor(self)
end

function NewEraQiClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewEraQiClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/neweraqichallenge/neweraqiclglevelview.prefab"
	}
end

function NewEraQiClgLevelViewPresentor:buildViews()
	return {
		NewEraQiClgLevelView.New()
	}
end

return NewEraQiClgLevelViewPresentor
