-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/view/JudgmentDragonClgStageViewPresentor.lua

module("logic.extensions.judgmentdragonclg.view.JudgmentDragonClgStageViewPresentor", package.seeall)

local JudgmentDragonClgStageViewPresentor = class("JudgmentDragonClgStageViewPresentor", ViewPresentor)

function JudgmentDragonClgStageViewPresentor:ctor()
	JudgmentDragonClgStageViewPresentor.super.ctor(self)
end

function JudgmentDragonClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JudgmentDragonClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/judgmentdragonclg/judgmentdragonclgstageview.prefab"
	}
end

function JudgmentDragonClgStageViewPresentor:buildViews()
	return {
		JudgmentDragonClgStageView.New()
	}
end

return JudgmentDragonClgStageViewPresentor
