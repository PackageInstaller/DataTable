-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/SelectbuffViewPresentor.lua

module("logic.extensions.mangtower.view.SelectbuffViewPresentor", package.seeall)

local SelectbuffViewPresentor = class("SelectbuffViewPresentor", ViewPresentor)

function SelectbuffViewPresentor:ctor()
	SelectbuffViewPresentor.super.ctor(self)
end

function SelectbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SelectbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/mangtower/selectbuffview.prefab"
	}
end

function SelectbuffViewPresentor:buildViews()
	return {
		SelectBuffView.New()
	}
end

return SelectbuffViewPresentor
