-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/OtherCardInfoStackPresentor.lua

module("logic.extensions.roleinfo.view.stack.OtherCardInfoStackPresentor", package.seeall)

local OtherCardInfoStackPresentor = class("OtherCardInfoStackPresentor", ViewPresentor)

function OtherCardInfoStackPresentor:ctor()
	OtherCardInfoStackPresentor.super.ctor(self)
end

function OtherCardInfoStackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OtherCardInfoStackPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/othercardinfostackview.prefab"
	}
end

function OtherCardInfoStackPresentor:buildViews()
	return {
		OtherCardInfoView.New()
	}
end

return OtherCardInfoStackPresentor
