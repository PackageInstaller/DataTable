-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukepopViewPresentor.lua

module("logic.extensions.miukechallenge.view.MiukepopViewPresentor", package.seeall)

local MiukepopViewPresentor = class("MiukepopViewPresentor", ViewPresentor)

function MiukepopViewPresentor:ctor()
	MiukepopViewPresentor.super.ctor(self)
end

function MiukepopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiukepopViewPresentor:dependWhatResources()
	return {
		"ui/views/miukechallenge/miukepopview.prefab"
	}
end

function MiukepopViewPresentor:buildViews()
	return {
		MiukepopView.New()
	}
end

return MiukepopViewPresentor
