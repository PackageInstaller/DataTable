-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/StarGodSelectViewPresentor.lua

module("logic.extensions.petequip.view.StarGodSelectViewPresentor", package.seeall)

local StarGodSelectViewPresentor = class("StarGodSelectViewPresentor", ViewPresentor)

function StarGodSelectViewPresentor:ctor()
	StarGodSelectViewPresentor.super.ctor(self)
end

function StarGodSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StarGodSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/stargodselectview.prefab"
	}
end

function StarGodSelectViewPresentor:buildViews()
	return {
		StarGodSelectView.New()
	}
end

return StarGodSelectViewPresentor
