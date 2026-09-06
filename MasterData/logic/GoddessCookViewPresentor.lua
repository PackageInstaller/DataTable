-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessCookViewPresentor.lua

module("logic.extensions.goddessdelicacy.view.GoddessCookViewPresentor", package.seeall)

local GoddessCookViewPresentor = class("GoddessCookViewPresentor", ViewPresentor)

function GoddessCookViewPresentor:ctor()
	GoddessCookViewPresentor.super.ctor(self)
end

function GoddessCookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCookViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessdelicacy/goddesscookview.prefab"
	}
end

function GoddessCookViewPresentor:buildViews()
	return {
		GoddessCookView.New()
	}
end

return GoddessCookViewPresentor
