-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaRankViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaRankViewPresentor", package.seeall)

local FunArenaRankViewPresentor = class("FunArenaRankViewPresentor", ViewPresentor)

function FunArenaRankViewPresentor:ctor()
	FunArenaRankViewPresentor.super.ctor(self)
end

function FunArenaRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaRankViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenarankview.prefab"
	}
end

function FunArenaRankViewPresentor:buildViews()
	return {
		FunArenaRankView.New()
	}
end

return FunArenaRankViewPresentor
