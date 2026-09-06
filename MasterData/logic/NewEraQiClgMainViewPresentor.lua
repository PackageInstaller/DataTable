-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/newerachallenge/NewEraQiClgMainViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.newerachallenge.NewEraQiClgMainViewPresentor", package.seeall)

local NewEraQiClgMainViewPresentor = class("NewEraQiClgMainViewPresentor", ViewPresentor)

function NewEraQiClgMainViewPresentor:ctor()
	NewEraQiClgMainViewPresentor.super.ctor(self)
end

function NewEraQiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewEraQiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/neweraqichallenge/neweraqiclgmainview.prefab"
	}
end

function NewEraQiClgMainViewPresentor:buildViews()
	return {
		NewEraQiClgMainView.New()
	}
end

return NewEraQiClgMainViewPresentor
