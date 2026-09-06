-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/MoyanbattleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.moyan.MoyanbattleViewPresentor", package.seeall)

local MoyanbattleViewPresentor = class("MoyanbattleViewPresentor", ViewPresentor)

function MoyanbattleViewPresentor:ctor()
	MoyanbattleViewPresentor.super.ctor(self)
end

function MoyanbattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoyanbattleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/moyan/moyanbattleview.prefab"
	}
end

function MoyanbattleViewPresentor:buildViews()
	return {
		MoyanbattleView.New()
	}
end

return MoyanbattleViewPresentor
