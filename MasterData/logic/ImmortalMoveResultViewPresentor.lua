-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveResultViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveResultViewPresentor", package.seeall)

local ImmortalMoveResultViewPresentor = class("ImmortalMoveResultViewPresentor", ViewPresentor)

function ImmortalMoveResultViewPresentor:ctor()
	ImmortalMoveResultViewPresentor.super.ctor(self)
end

function ImmortalMoveResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveResultViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmoveresultview.prefab"
	}
end

function ImmortalMoveResultViewPresentor:buildViews()
	return {
		ImmortalMoveResultView.New()
	}
end

return ImmortalMoveResultViewPresentor
