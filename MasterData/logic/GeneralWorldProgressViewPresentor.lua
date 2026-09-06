-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/view/GeneralWorldProgressViewPresentor.lua

module("logic.extensions.generalworldprogress.view.GeneralWorldProgressViewPresentor", package.seeall)

local GeneralWorldProgressViewPresentor = class("GeneralWorldProgressViewPresentor", ViewPresentor)

function GeneralWorldProgressViewPresentor:ctor()
	GeneralWorldProgressViewPresentor.super.ctor(self)
end

function GeneralWorldProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GeneralWorldProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/generalworldprogress/generalworldprogressview.prefab"
	}
end

function GeneralWorldProgressViewPresentor:buildViews()
	return {
		GeneralWorldProgressView.New()
	}
end

return GeneralWorldProgressViewPresentor
