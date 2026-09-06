-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/view/PettitletipViewPresentor.lua

module("logic.extensions.pettitle.view.PettitletipViewPresentor", package.seeall)

local PettitletipViewPresentor = class("PettitletipViewPresentor", ViewPresentor)

function PettitletipViewPresentor:ctor()
	PettitletipViewPresentor.super.ctor(self)
end

function PettitletipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PettitletipViewPresentor:dependWhatResources()
	return {
		"ui/views/pettitle/pettitletipview.prefab"
	}
end

function PettitletipViewPresentor:buildViews()
	return {
		PetTitleTipView.New()
	}
end

return PettitletipViewPresentor
