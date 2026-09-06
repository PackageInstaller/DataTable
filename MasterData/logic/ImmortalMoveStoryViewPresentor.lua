-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveStoryViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveStoryViewPresentor", package.seeall)

local ImmortalMoveStoryViewPresentor = class("ImmortalMoveStoryViewPresentor", ViewPresentor)

function ImmortalMoveStoryViewPresentor:ctor()
	ImmortalMoveStoryViewPresentor.super.ctor(self)
end

function ImmortalMoveStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmovestoryview.prefab"
	}
end

function ImmortalMoveStoryViewPresentor:buildViews()
	return {
		ImmortalMoveStoryView.New()
	}
end

return ImmortalMoveStoryViewPresentor
