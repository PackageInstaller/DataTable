-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendMainViewPresentor.lua

module("logic.extensions.demondescend.view.DemonDescendMainViewPresentor", package.seeall)

local DemonDescendMainViewPresentor = class("DemonDescendMainViewPresentor", ViewPresentor)

function DemonDescendMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DemonDescendMainViewPresentor:dependWhatResources()
	return {
		"ui/views/demondescend/demondescendmainview.prefab"
	}
end

function DemonDescendMainViewPresentor:buildViews()
	return {
		DemonDescendMainView.New()
	}
end

return DemonDescendMainViewPresentor
