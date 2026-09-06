-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/formation/FunArenaFormationViewPresentor.lua

module("logic.extensions.funarena.view.formation.FunArenaFormationViewPresentor", package.seeall)

local FunArenaFormationViewPresentor = class("FunArenaFormationViewPresentor", ViewPresentor)

function FunArenaFormationViewPresentor:ctor()
	FunArenaFormationViewPresentor.super.ctor(self)
end

function FunArenaFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function FunArenaFormationViewPresentor:buildViews()
	return {
		FunArenaBuzhenLeftView.New(),
		FunArenaFormationRightView.New(),
		FunArenaFormationView.New(true)
	}
end

return FunArenaFormationViewPresentor
