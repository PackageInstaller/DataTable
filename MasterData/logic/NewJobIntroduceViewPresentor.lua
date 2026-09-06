-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/NewJobIntroduceViewPresentor.lua

module("logic.extensions.operationsummary.view.NewJobIntroduceViewPresentor", package.seeall)

local NewJobIntroduceViewPresentor = class("NewJobIntroduceViewPresentor", ViewPresentor)

function NewJobIntroduceViewPresentor:ctor()
	NewJobIntroduceViewPresentor.super.ctor(self)
end

function NewJobIntroduceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewJobIntroduceViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/newjobintroduceview.prefab"
	}
end

function NewJobIntroduceViewPresentor:buildViews()
	return {
		NewJobIntroduceView.New()
	}
end

return NewJobIntroduceViewPresentor
