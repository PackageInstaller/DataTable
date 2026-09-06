-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerFmtAdjustDetailViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerFmtAdjustDetailViewPresentor", package.seeall)

local GodStatuesWarTowerFmtAdjustDetailViewPresentor = class("GodStatuesWarTowerFmtAdjustDetailViewPresentor", ViewPresentor)

function GodStatuesWarTowerFmtAdjustDetailViewPresentor:ctor()
	GodStatuesWarTowerFmtAdjustDetailViewPresentor.super.ctor(self)
end

function GodStatuesWarTowerFmtAdjustDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarTowerFmtAdjustDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswartowerfmtadjustdetailview.prefab"
	}
end

function GodStatuesWarTowerFmtAdjustDetailViewPresentor:buildViews()
	return {
		GodStatuesWarTowerFmtAdjustDetailView.New()
	}
end

return GodStatuesWarTowerFmtAdjustDetailViewPresentor
