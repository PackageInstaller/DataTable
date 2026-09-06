-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pandoracopy/view/PandoraMainViewPresentor.lua

module("logic.extensions.pandoracopy.view.PandoraMainViewPresentor", package.seeall)

local PandoraMainViewPresentor = class("PandoraMainViewPresentor", ViewWithGuidePresentor)

function PandoraMainViewPresentor:ctor()
	PandoraMainViewPresentor.super.ctor(self)
end

function PandoraMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PandoraMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pandoracopy/pandoramainview.prefab"
	}
end

function PandoraMainViewPresentor:buildViews()
	return {
		PandoraMainView.New()
	}
end

return PandoraMainViewPresentor
