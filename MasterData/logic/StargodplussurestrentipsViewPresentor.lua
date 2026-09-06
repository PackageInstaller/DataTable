-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplussurestrentipsViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplussurestrentipsViewPresentor", package.seeall)

local StargodplussurestrentipsViewPresentor = class("StargodplussurestrentipsViewPresentor", ViewPresentor)

function StargodplussurestrentipsViewPresentor:ctor()
	StargodplussurestrentipsViewPresentor.super.ctor(self)
end

function StargodplussurestrentipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StargodplussurestrentipsViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplussurestrentips.prefab"
	}
end

function StargodplussurestrentipsViewPresentor:buildViews()
	return {
		StargodplussurestrentipsView.New()
	}
end

return StargodplussurestrentipsViewPresentor
