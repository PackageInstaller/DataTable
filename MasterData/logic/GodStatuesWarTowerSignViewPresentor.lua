-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerSignViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerSignViewPresentor", package.seeall)

local GodStatuesWarTowerSignViewPresentor = class("GodStatuesWarTowerSignViewPresentor", ViewPresentor)

function GodStatuesWarTowerSignViewPresentor:ctor()
	GodStatuesWarTowerSignViewPresentor.super.ctor(self)
end

function GodStatuesWarTowerSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarTowerSignViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartowersignview.prefab"
	}
end

function GodStatuesWarTowerSignViewPresentor:buildViews()
	return {
		GodStatuesWarTowerSignView.New()
	}
end

return GodStatuesWarTowerSignViewPresentor
