-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/newerachallenge/NewEraQiClgResetViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.newerachallenge.NewEraQiClgResetViewPresentor", package.seeall)

local NewEraQiClgResetViewPresentor = class("NewEraQiClgResetViewPresentor", ViewPresentor)

function NewEraQiClgResetViewPresentor:ctor()
	NewEraQiClgResetViewPresentor.super.ctor(self)
end

function NewEraQiClgResetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewEraQiClgResetViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/neweraqichallenge/neweraqiclgresetview.prefab"
	}
end

function NewEraQiClgResetViewPresentor:buildViews()
	return {
		NewEraQiClgResetView.New()
	}
end

return NewEraQiClgResetViewPresentor
