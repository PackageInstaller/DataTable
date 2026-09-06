-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pandoracopy/view/PandoraBattleViewPresentor.lua

module("logic.extensions.pandoracopy.view.PandoraBattleViewPresentor", package.seeall)

local PandoraBattleViewPresentor = class("PandoraBattleViewPresentor", ViewWithGuidePresentor)

function PandoraBattleViewPresentor:ctor()
	PandoraBattleViewPresentor.super.ctor(self)
end

function PandoraBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PandoraBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/pandoracopy/pandorabattleview.prefab"
	}
end

function PandoraBattleViewPresentor:buildViews()
	return {
		PandoraBattleView.New()
	}
end

return PandoraBattleViewPresentor
