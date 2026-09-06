-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettip/view/PetTipViewPresentor.lua

module("logic.extensions.pettip.view.PetTipViewPresentor", package.seeall)

local PetTipViewPresentor = class("PetTipViewPresentor", ViewPresentor)

function PetTipViewPresentor:ctor()
	PetTipViewPresentor.super.ctor(self)
end

function PetTipViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function PetTipViewPresentor:dependWhatResources()
	return {
		"ui/views/pettip/pettipssimple.prefab"
	}
end

function PetTipViewPresentor:buildViews()
	local views = {}
	local view = PetTipsSimpleView.New()

	table.insert(views, view)

	return views
end

return PetTipViewPresentor
