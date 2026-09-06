-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalbuffViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalbuffViewPresentor", package.seeall)

local MartialcontestfinalbuffViewPresentor = class("MartialcontestfinalbuffViewPresentor", ViewPresentor)

function MartialcontestfinalbuffViewPresentor:ctor()
	MartialcontestfinalbuffViewPresentor.super.ctor(self)
end

function MartialcontestfinalbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalbuffview.prefab"
	}
end

function MartialcontestfinalbuffViewPresentor:buildViews()
	return {
		MartialcontestfinalbuffView.New()
	}
end

function MartialcontestfinalbuffViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.MartialcontestfinalbuffView)
end

return MartialcontestfinalbuffViewPresentor
