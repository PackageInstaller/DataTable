-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopdiscgiftViewPresentor.lua

module("logic.extensions.payshop.view.PayshopdiscgiftViewPresentor", package.seeall)

local PayshopdiscgiftViewPresentor = class("PayshopdiscgiftViewPresentor", ViewPresentor)

function PayshopdiscgiftViewPresentor:ctor()
	PayshopdiscgiftViewPresentor.super.ctor(self)
end

function PayshopdiscgiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayshopdiscgiftViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopdiscgiftview.prefab"
	}
end

function PayshopdiscgiftViewPresentor:buildViews()
	return {
		PayshopdiscgiftView.New()
	}
end

function PayshopdiscgiftViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return PayshopdiscgiftViewPresentor
