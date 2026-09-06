-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerFmtAdjustViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerFmtAdjustViewPresentor", package.seeall)

local GodStatuesWarTowerFmtAdjustViewPresentor = class("GodStatuesWarTowerFmtAdjustViewPresentor", ViewPresentor)

function GodStatuesWarTowerFmtAdjustViewPresentor:ctor()
	GodStatuesWarTowerFmtAdjustViewPresentor.super.ctor(self)
end

function GodStatuesWarTowerFmtAdjustViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarTowerFmtAdjustViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartowerfmtadjustview.prefab"
	}
end

function GodStatuesWarTowerFmtAdjustViewPresentor:buildViews()
	return {
		GodStatuesWarTowerFmtAdjustView.New()
	}
end

return GodStatuesWarTowerFmtAdjustViewPresentor
