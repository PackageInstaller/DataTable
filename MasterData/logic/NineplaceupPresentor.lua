-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceupPresentor.lua

module("logic.extensions.nineplace.view.NineplaceupPresentor", package.seeall)

local NineplaceupPresentor = class("NineplaceupPresentor", ViewWithGuidePresentor)

function NineplaceupPresentor:ctor()
	NineplaceupPresentor.super.ctor(self)
end

function NineplaceupPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineplaceupPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplaceupview.prefab"
	}
end

function NineplaceupPresentor:buildViews()
	return {
		NineplaceupView.New()
	}
end

return NineplaceupPresentor
