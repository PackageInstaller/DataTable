-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingBattleViewPresentor.lua

module("logic.extensions.moonking.view.MoonKingBattleViewPresentor", package.seeall)

local MoonKingBattleViewPresentor = class("MoonKingBattleViewPresentor", ViewWithGuidePresentor)

function MoonKingBattleViewPresentor:ctor()
	MoonKingBattleViewPresentor.super.ctor(self)
end

function MoonKingBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoonKingBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/moonkingbattleview.prefab"
	}
end

function MoonKingBattleViewPresentor:buildViews()
	return {
		MoonKingBattleView.New()
	}
end

return MoonKingBattleViewPresentor
