-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendBuffViewPresentor.lua

module("logic.extensions.demondescend.view.DemonDescendBuffViewPresentor", package.seeall)

local DemonDescendBuffViewPresentor = class("DemonDescendBuffViewPresentor", ViewPresentor)

function DemonDescendBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DemonDescendBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/demondescend/demondescendbuffview.prefab"
	}
end

function DemonDescendBuffViewPresentor:buildViews()
	return {
		DemonDescendBuffView.New()
	}
end

return DemonDescendBuffViewPresentor
