-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnertaskViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnertaskViewPresentor", package.seeall)

local CrazypartnertaskViewPresentor = class("CrazypartnertaskViewPresentor", ViewPresentor)

function CrazypartnertaskViewPresentor:ctor()
	CrazypartnertaskViewPresentor.super.ctor(self)
end

function CrazypartnertaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnertaskViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnertaskview.prefab"
	}
end

function CrazypartnertaskViewPresentor:buildViews()
	return {
		CrazyPartnerTaskView.New()
	}
end

return CrazypartnertaskViewPresentor
