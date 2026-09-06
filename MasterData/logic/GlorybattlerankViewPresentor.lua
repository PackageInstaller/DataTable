-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlerankViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattlerankViewPresentor", package.seeall)

local GlorybattlerankViewPresentor = class("GlorybattlerankViewPresentor", ViewPresentor)

function GlorybattlerankViewPresentor:ctor()
	GlorybattlerankViewPresentor.super.ctor(self)
end

function GlorybattlerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattlerankViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattlerankview.prefab"
	}
end

function GlorybattlerankViewPresentor:buildViews()
	return {
		GlorybattlerankView.New()
	}
end

return GlorybattlerankViewPresentor
