-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackMineViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackMineViewPresentor", package.seeall)

local SpringRedPackMineViewPresentor = class("SpringRedPackMineViewPresentor", ViewPresentor)

function SpringRedPackMineViewPresentor:ctor()
	SpringRedPackMineViewPresentor.super.ctor(self)
end

function SpringRedPackMineViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SpringRedPackMineViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackmineview.prefab"
	}
end

function SpringRedPackMineViewPresentor:buildViews()
	return {
		SpringRedPackMineView.New()
	}
end

return SpringRedPackMineViewPresentor
