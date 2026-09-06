-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pandoracopy/view/PandoraRankViewPresentor.lua

module("logic.extensions.pandoracopy.view.PandoraRankViewPresentor", package.seeall)

local PandoraRankViewPresentor = class("PandoraRankViewPresentor", ViewWithGuidePresentor)

function PandoraRankViewPresentor:ctor()
	PandoraRankViewPresentor.super.ctor(self)
end

function PandoraRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PandoraRankViewPresentor:dependWhatResources()
	return {
		"ui/views/pandoracopy/pandorarankview.prefab"
	}
end

function PandoraRankViewPresentor:buildViews()
	return {
		PandoraRankView.New()
	}
end

return PandoraRankViewPresentor
