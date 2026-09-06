-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonStageViewPresentor.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonStageViewPresentor", package.seeall)

local OriginDualDragonStageViewPresentor = class("OriginDualDragonStageViewPresentor", ViewPresentor)

function OriginDualDragonStageViewPresentor:ctor()
	OriginDualDragonStageViewPresentor.super.ctor(self)
end

function OriginDualDragonStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDualDragonStageViewPresentor:dependWhatResources()
	return {
		"ui/views/origindualdragon/origindualdragonstageview.prefab"
	}
end

function OriginDualDragonStageViewPresentor:buildViews()
	return {
		OriginDualDragonStageView.New()
	}
end

return OriginDualDragonStageViewPresentor
