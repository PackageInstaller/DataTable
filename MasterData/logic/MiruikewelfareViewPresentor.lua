-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikewelfareViewPresentor.lua

module("logic.extensions.miruikeintroduce.view.MiruikewelfareViewPresentor", package.seeall)

local MiruikewelfareViewPresentor = class("MiruikewelfareViewPresentor", ViewPresentor)

function MiruikewelfareViewPresentor:ctor()
	MiruikewelfareViewPresentor.super.ctor(self)
end

function MiruikewelfareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiruikewelfareViewPresentor:dependWhatResources()
	return {
		"ui/views/miruikeintroduce/miruikewelfareview.prefab"
	}
end

function MiruikewelfareViewPresentor:buildViews()
	return {
		MiruikeWelfareView.New()
	}
end

return MiruikewelfareViewPresentor
