-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/view/ShiZuDragonClgStageViewPresentor.lua

module("logic.extensions.shizudragonclg.view.ShiZuDragonClgStageViewPresentor", package.seeall)

local ShiZuDragonClgStageViewPresentor = class("ShiZuDragonClgStageViewPresentor", ViewPresentor)

function ShiZuDragonClgStageViewPresentor:ctor()
	ShiZuDragonClgStageViewPresentor.super.ctor(self)
end

function ShiZuDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShiZuDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/shizudragonclg/shizudragonclgstageview.prefab"
	}
end

function ShiZuDragonClgStageViewPresentor:buildViews()
	return {
		ShiZuDragonClgStageView.New()
	}
end

return ShiZuDragonClgStageViewPresentor
