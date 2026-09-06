-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/view/JudgmentDragonClgMainViewPresentor.lua

module("logic.extensions.judgmentdragonclg.view.JudgmentDragonClgMainViewPresentor", package.seeall)

local JudgmentDragonClgMainViewPresentor = class("JudgmentDragonClgMainViewPresentor", ViewPresentor)

function JudgmentDragonClgMainViewPresentor:ctor()
	JudgmentDragonClgMainViewPresentor.super.ctor(self)
end

function JudgmentDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JudgmentDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/judgmentdragonclg/judgmentdragonclgmainview.prefab"
	}
end

function JudgmentDragonClgMainViewPresentor:buildViews()
	return {
		JudgmentDragonClgMainView.New()
	}
end

return JudgmentDragonClgMainViewPresentor
