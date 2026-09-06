-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveMainViewPresentor.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveMainViewPresentor", package.seeall)

local ImmortalMoveMainViewPresentor = class("ImmortalMoveMainViewPresentor", ViewPresentor)

function ImmortalMoveMainViewPresentor:ctor()
	ImmortalMoveMainViewPresentor.super.ctor(self)
end

function ImmortalMoveMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImmortalMoveMainViewPresentor:dependWhatResources()
	return {
		"ui/views/immortalmovement/immortalmovemainview.prefab"
	}
end

function ImmortalMoveMainViewPresentor:buildViews()
	return {
		ImmortalMoveMainView.New()
	}
end

return ImmortalMoveMainViewPresentor
