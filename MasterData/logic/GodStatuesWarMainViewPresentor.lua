-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarMainViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarMainViewPresentor", package.seeall)

local GodStatuesWarMainViewPresentor = class("GodStatuesWarMainViewPresentor", ViewPresentor)

function GodStatuesWarMainViewPresentor:ctor()
	GodStatuesWarMainViewPresentor.super.ctor(self)
end

function GodStatuesWarMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarMainViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarmainview.prefab"
	}
end

function GodStatuesWarMainViewPresentor:buildViews()
	return {
		GodStatuesWarMainView.New()
	}
end

return GodStatuesWarMainViewPresentor
