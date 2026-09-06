-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMainPresentor.lua

module("logic.extensions.nineplace.view.NinePlaceMainPresentor", package.seeall)

local NinePlaceMainPresentor = class("NinePlaceMainPresentor", ViewWithGuidePresentor)

function NinePlaceMainPresentor:ctor()
	NinePlaceMainPresentor.super.ctor(self)
end

function NinePlaceMainPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NinePlaceMainPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplacemainview.prefab"
	}
end

function NinePlaceMainPresentor:buildViews()
	return {
		NinePlaceMainView.New()
	}
end

return NinePlaceMainPresentor
