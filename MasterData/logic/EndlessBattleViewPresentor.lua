-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessBattleViewPresentor.lua

module("logic.extensions.endlessbattle.view.EndlessBattleViewPresentor", package.seeall)

local EndlessBattleViewPresentor = class("EndlessBattleViewPresentor", ViewWithGuidePresentor)

function EndlessBattleViewPresentor:ctor()
	EndlessBattleViewPresentor.super.ctor(self)
end

function EndlessBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessbattle/endlessbattleview.prefab"
	}
end

function EndlessBattleViewPresentor:buildViews()
	return {
		EndlessBattleView.New()
	}
end

return EndlessBattleViewPresentor
