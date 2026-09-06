-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooselectPresentor.lua

module("logic.extensions.zoo.view.ZooselectPresentor", package.seeall)

local ZooselectPresentor = class("ZooselectPresentor", ViewWithGuidePresentor)

function ZooselectPresentor:ctor()
	ZooselectPresentor.super.ctor(self)
end

function ZooselectPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooselectPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooselectview.prefab"
	}
end

function ZooselectPresentor:buildViews()
	return {
		ZooselectView.New()
	}
end

return ZooselectPresentor
