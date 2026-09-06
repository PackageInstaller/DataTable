-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/EternalDragonMainViewPresentor.lua

module("logic.extensions.eternaldragon.view.EternalDragonMainViewPresentor", package.seeall)

local EternalDragonMainViewPresentor = class("EternalDragonMainViewPresentor", ViewPresentor)

function EternalDragonMainViewPresentor:ctor()
	EternalDragonMainViewPresentor.super.ctor(self)
end

function EternalDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/eternaldragon/eternaldragonmainview.prefab"
	}
end

function EternalDragonMainViewPresentor:buildViews()
	return {
		EternalDragonMainView.New()
	}
end

return EternalDragonMainViewPresentor
