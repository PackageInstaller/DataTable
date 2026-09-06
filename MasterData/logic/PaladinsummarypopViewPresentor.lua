-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/paladin/PaladinsummarypopViewPresentor.lua

module("logic.extensions.operationsummary.view.paladin.PaladinsummarypopViewPresentor", package.seeall)

local PaladinsummarypopViewPresentor = class("PaladinsummarypopViewPresentor", ViewPresentor)

function PaladinsummarypopViewPresentor:ctor()
	PaladinsummarypopViewPresentor.super.ctor(self)
end

function PaladinsummarypopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PaladinsummarypopViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/paladinsummarypopview.prefab"
	}
end

function PaladinsummarypopViewPresentor:buildViews()
	return {
		PaladinsummarypopView.New()
	}
end

return PaladinsummarypopViewPresentor
