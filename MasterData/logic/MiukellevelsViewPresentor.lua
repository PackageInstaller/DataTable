-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukellevelsViewPresentor.lua

module("logic.extensions.miukechallenge.view.MiukellevelsViewPresentor", package.seeall)

local MiukellevelsViewPresentor = class("MiukellevelsViewPresentor", ViewPresentor)

function MiukellevelsViewPresentor:ctor()
	MiukellevelsViewPresentor.super.ctor(self)
end

function MiukellevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiukellevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/miukechallenge/miukellevelsview.prefab"
	}
end

function MiukellevelsViewPresentor:buildViews()
	return {
		MiukellevelsView.New()
	}
end

return MiukellevelsViewPresentor
