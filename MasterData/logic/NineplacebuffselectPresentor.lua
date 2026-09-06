-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacebuffselectPresentor.lua

module("logic.extensions.nineplace.view.NineplacebuffselectPresentor", package.seeall)

local NineplacebuffselectPresentor = class("NineplacebuffselectPresentor", ViewWithGuidePresentor)

function NineplacebuffselectPresentor:ctor()
	NineplacebuffselectPresentor.super.ctor(self)
end

function NineplacebuffselectPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NineplacebuffselectPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplacebuffselectview.prefab"
	}
end

function NineplacebuffselectPresentor:buildViews()
	return {
		NineplacebuffselectView.New()
	}
end

return NineplacebuffselectPresentor
