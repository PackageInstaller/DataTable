-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameResultViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameResultViewPresentor", package.seeall)

local OriMatGameResultViewPresentor = class("OriMatGameResultViewPresentor", ViewPresentor)

function OriMatGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriMatGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameresultview.prefab"
	}
end

function OriMatGameResultViewPresentor:buildViews()
	return {
		OriMatGameResultView.New()
	}
end

return OriMatGameResultViewPresentor
