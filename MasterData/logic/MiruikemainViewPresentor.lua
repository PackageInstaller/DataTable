-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikemainViewPresentor.lua

module("logic.extensions.miruikeintroduce.view.MiruikemainViewPresentor", package.seeall)

local MiruikemainViewPresentor = class("MiruikemainViewPresentor", ViewPresentor)

function MiruikemainViewPresentor:ctor()
	MiruikemainViewPresentor.super.ctor(self)
end

function MiruikemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiruikemainViewPresentor:dependWhatResources()
	return {
		"ui/views/miruikeintroduce/miruikemainview.prefab"
	}
end

function MiruikemainViewPresentor:buildViews()
	return {
		MiruikeMainView.New()
	}
end

return MiruikemainViewPresentor
