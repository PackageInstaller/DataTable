-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKChampionshipViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKChampionshipViewPresentor", package.seeall)

local TCKChampionshipViewPresentor = class("TCKChampionshipViewPresentor", ViewPresentor)

function TCKChampionshipViewPresentor:ctor()
	TCKChampionshipViewPresentor.super.ctor(self)
end

function TCKChampionshipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKChampionshipViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckchampionshipview.prefab"
	}
end

function TCKChampionshipViewPresentor:buildViews()
	return {
		TCKChampionshipView.New()
	}
end

function TCKChampionshipViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKChampionshipViewPresentor
