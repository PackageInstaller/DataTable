-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewbreakformationpetbuffselectViewPresentor.lua

module("logic.extensions.newbreakformation.view.NewbreakformationpetbuffselectViewPresentor", package.seeall)

local NewbreakformationpetbuffselectViewPresentor = class("NewbreakformationpetbuffselectViewPresentor", ViewPresentor)

function NewbreakformationpetbuffselectViewPresentor:ctor()
	NewbreakformationpetbuffselectViewPresentor.super.ctor(self)
end

function NewbreakformationpetbuffselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewbreakformationpetbuffselectViewPresentor:dependWhatResources()
	return {
		"ui/views/newbreakformation/newbreakformationpetbuffselectview.prefab"
	}
end

function NewbreakformationpetbuffselectViewPresentor:buildViews()
	return {
		NewbreakformationpetbuffselectView.New()
	}
end

return NewbreakformationpetbuffselectViewPresentor
