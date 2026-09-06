-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloMainViewPresentor.lua

module("logic.extensions.divinehalogame.view.DivineHaloMainViewPresentor", package.seeall)

local DivineHaloMainViewPresentor = class("DivineHaloMainViewPresentor", ViewPresentor)

function DivineHaloMainViewPresentor:ctor()
	DivineHaloMainViewPresentor.super.ctor(self)
end

function DivineHaloMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineHaloMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinehalogame/divinehalomainview.prefab"
	}
end

function DivineHaloMainViewPresentor:buildViews()
	return {
		DivineHaloMainView.New()
	}
end

return DivineHaloMainViewPresentor
