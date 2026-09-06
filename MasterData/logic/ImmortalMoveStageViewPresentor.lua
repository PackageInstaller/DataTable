-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveStageViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveStageViewPresentor", package.seeall)

local ImmortalMoveStageViewPresentor = class("ImmortalMoveStageViewPresentor", ViewPresentor)

function ImmortalMoveStageViewPresentor:ctor()
	ImmortalMoveStageViewPresentor.super.ctor(self)
end

function ImmortalMoveStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveStageViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmovestageview.prefab"
	}
end

function ImmortalMoveStageViewPresentor:buildViews()
	return {
		ImmortalMoveStageView.New()
	}
end

return ImmortalMoveStageViewPresentor
