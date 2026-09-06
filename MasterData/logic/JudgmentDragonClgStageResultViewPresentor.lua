-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/view/JudgmentDragonClgStageResultViewPresentor.lua

module("logic.extensions.judgmentdragonclg.view.DivineMiMengLiClgStageResultViewPresentor", package.seeall)

local DivineMiMengLiClgStageResultViewPresentor = class("DivineMiMengLiClgStageResultViewPresentor", ViewPresentor)

function DivineMiMengLiClgStageResultViewPresentor:ctor()
	DivineMiMengLiClgStageResultViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiMengLiClgStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/judgmentdragonclg/judgmentdragonclgstageresultview.prefab"
	}
end

function DivineMiMengLiClgStageResultViewPresentor:buildViews()
	return {
		JudgmentDragonClgStageResultView.New()
	}
end

return DivineMiMengLiClgStageResultViewPresentor
