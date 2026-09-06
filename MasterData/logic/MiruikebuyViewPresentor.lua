-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikebuyViewPresentor.lua

module("logic.extensions.miruikeintroduce.view.MiruikebuyViewPresentor", package.seeall)

local MiruikebuyViewPresentor = class("MiruikebuyViewPresentor", ViewPresentor)

function MiruikebuyViewPresentor:ctor()
	MiruikebuyViewPresentor.super.ctor(self)
end

function MiruikebuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiruikebuyViewPresentor:dependWhatResources()
	return {
		"ui/views/miruikeintroduce/miruikebuyview.prefab"
	}
end

function MiruikebuyViewPresentor:buildViews()
	return {
		MiruikeBuyView.New()
	}
end

return MiruikebuyViewPresentor
