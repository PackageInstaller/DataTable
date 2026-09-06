-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruiketipsViewPresentor.lua

module("logic.extensions.miruikeintroduce.view.MiruiketipsViewPresentor", package.seeall)

local MiruiketipsViewPresentor = class("MiruiketipsViewPresentor", ViewPresentor)

function MiruiketipsViewPresentor:ctor()
	MiruiketipsViewPresentor.super.ctor(self)
end

function MiruiketipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiruiketipsViewPresentor:dependWhatResources()
	return {
		"ui/views/miruikeintroduce/miruiketipsview.prefab"
	}
end

function MiruiketipsViewPresentor:buildViews()
	return {
		MiruikeTipsView.New()
	}
end

return MiruiketipsViewPresentor
