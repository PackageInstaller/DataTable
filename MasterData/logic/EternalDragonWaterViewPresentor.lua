-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternaldragon/view/EternalDragonWaterViewPresentor.lua

module("logic.extensions.eternaldragon.view.EternalDragonWaterViewPresentor", package.seeall)

local EternalDragonWaterViewPresentor = class("EternalDragonWaterViewPresentor", ViewPresentor)

function EternalDragonWaterViewPresentor:ctor()
	EternalDragonWaterViewPresentor.super.ctor(self)
end

function EternalDragonWaterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalDragonWaterViewPresentor:dependWhatResources()
	return {
		"ui/views/eternaldragon/eternaldragonwaterview.prefab"
	}
end

function EternalDragonWaterViewPresentor:buildViews()
	return {
		EternalDragonWaterView.New()
	}
end

return EternalDragonWaterViewPresentor
