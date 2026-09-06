-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingAgainstTwoViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingAgainstTwoViewPresentor", package.seeall)

local ChopKingAgainstTwoViewPresentor = class("ChopKingAgainstTwoViewPresentor", ViewPresentor)

function ChopKingAgainstTwoViewPresentor:ctor()
	ChopKingAgainstTwoViewPresentor.super.ctor(self)
end

function ChopKingAgainstTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingAgainstTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingagainsttwoview.prefab"
	}
end

function ChopKingAgainstTwoViewPresentor:buildViews()
	return {
		ChopKingAgainstTwoView.New()
	}
end

return ChopKingAgainstTwoViewPresentor
