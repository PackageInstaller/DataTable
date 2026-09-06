-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonStageViewPresentor.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonStageViewPresentor", package.seeall)

local OriginAshlessDragonStageViewPresentor = class("OriginAshlessDragonStageViewPresentor", ViewPresentor)

function OriginAshlessDragonStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAshlessDragonStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originashlessdragon/originashlessdragonstageview.prefab"
	}
end

function OriginAshlessDragonStageViewPresentor:buildViews()
	return {
		OriginAshlessDragonStageView.New()
	}
end

return OriginAshlessDragonStageViewPresentor
