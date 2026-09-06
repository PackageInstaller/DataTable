-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarNestViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarNestViewPresentor", package.seeall)

local GodStatuesWarNestViewPresentor = class("GodStatuesWarNestViewPresentor", ViewPresentor)

function GodStatuesWarNestViewPresentor:ctor()
	GodStatuesWarNestViewPresentor.super.ctor(self)
end

function GodStatuesWarNestViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarNestViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarnestview.prefab"
	}
end

function GodStatuesWarNestViewPresentor:buildViews()
	return {
		GodStatuesWarNestView.New()
	}
end

return GodStatuesWarNestViewPresentor
