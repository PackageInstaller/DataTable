-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeenterViewPresentor.lua

module("logic.extensions.miruikeintroduce.view.MiruikeenterViewPresentor", package.seeall)

local MiruikeenterViewPresentor = class("MiruikeenterViewPresentor", ViewPresentor)

function MiruikeenterViewPresentor:ctor()
	MiruikeenterViewPresentor.super.ctor(self)
end

function MiruikeenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiruikeenterViewPresentor:dependWhatResources()
	return {
		"ui/views/miruikeintroduce/miruikeenterview.prefab"
	}
end

function MiruikeenterViewPresentor:buildViews()
	return {
		MiruikeEnterView.New()
	}
end

return MiruikeenterViewPresentor
