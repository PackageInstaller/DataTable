-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/view/EntrancemailViewPresentor.lua

module("logic.extensions.entrance.view.EntrancemailViewPresentor", package.seeall)

local EntrancemailViewPresentor = class("EntrancemailViewPresentor", ViewWithGuidePresentor)

function EntrancemailViewPresentor:ctor()
	EntrancemailViewPresentor.super.ctor(self)
end

function EntrancemailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EntrancemailViewPresentor:dependWhatResources()
	return {
		"ui/views/entrance/entrancemailview.prefab"
	}
end

function EntrancemailViewPresentor:buildViews()
	return {
		EntrancemailView.New()
	}
end

return EntrancemailViewPresentor
