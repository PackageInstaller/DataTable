-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgStageViewPresentor.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgStageViewPresentor", package.seeall)

local OriginGodDragonClgStageViewPresentor = class("OriginGodDragonClgStageViewPresentor", ViewPresentor)

function OriginGodDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGodDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/origingoddragonclg/origingoddragonclgstageview.prefab"
	}
end

function OriginGodDragonClgStageViewPresentor:buildViews()
	return {
		OriginGodDragonClgStageView.New()
	}
end

return OriginGodDragonClgStageViewPresentor
