-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/OtherExteriorViewPresentor.lua

module("logic.extensions.roleinfo.view.OtherExteriorViewPresentor", package.seeall)

local OtherExteriorViewPresentor = class("OtherExteriorViewPresentor", ViewPresentor)

function OtherExteriorViewPresentor:ctor()
	OtherExteriorViewPresentor.super.ctor(self)
end

function OtherExteriorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OtherExteriorViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/otherexteriorview.prefab"
	}
end

function OtherExteriorViewPresentor:buildViews()
	return {
		OtherExteriorView.New()
	}
end

return OtherExteriorViewPresentor
