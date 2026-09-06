-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/view/OriginKingCiYuanDragonClgStageViewPresentor.lua

module("logic.extensions.originkingciyuandragonclg.view.OriginKingCiYuanDragonClgStageViewPresentor", package.seeall)

local OriginKingCiYuanDragonClgStageViewPresentor = class("OriginKingCiYuanDragonClgStageViewPresentor", ViewPresentor)

function OriginKingCiYuanDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingCiYuanDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingciyuandragonclg/originkingciyuandragonclgstageview.prefab"
	}
end

function OriginKingCiYuanDragonClgStageViewPresentor:buildViews()
	return {
		OriginKingCiYuanDragonClgStageView.New()
	}
end

return OriginKingCiYuanDragonClgStageViewPresentor
