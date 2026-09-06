-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerViewPresentor", package.seeall)

local GodStatuesWarTowerViewPresentor = class("GodStatuesWarTowerViewPresentor", ViewPresentor)

function GodStatuesWarTowerViewPresentor:ctor()
	GodStatuesWarTowerViewPresentor.super.ctor(self)
end

function GodStatuesWarTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartowerview.prefab"
	}
end

function GodStatuesWarTowerViewPresentor:buildViews()
	return {
		GodStatuesWarTowerView.New()
	}
end

return GodStatuesWarTowerViewPresentor
