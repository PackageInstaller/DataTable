-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameResultViewPresentor.lua

module("logic.extensions.landlords.view.FalGameResultViewPresentor", package.seeall)

local FalGameResultViewPresentor = class("FalGameResultViewPresentor", ViewPresentor)

function FalGameResultViewPresentor:ctor()
	FalGameResultViewPresentor.super.ctor(self)
end

function FalGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falgameresultview.prefab"
	}
end

function FalGameResultViewPresentor:buildViews()
	return {
		FalGameResultView.New()
	}
end

return FalGameResultViewPresentor
