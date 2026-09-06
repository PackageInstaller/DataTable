-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/PetattrpowerupViewPresentor.lua

module("logic.extensions.mainui.view.PetattrpowerupViewPresentor", package.seeall)

local PetattrpowerupViewPresentor = class("PetattrpowerupViewPresentor", ViewPresentor)

function PetattrpowerupViewPresentor:ctor()
	PetattrpowerupViewPresentor.super.ctor(self)
end

function PetattrpowerupViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PetattrpowerupViewPresentor:dependWhatResources()
	return {
		"ui/views/mainui/petattrpowerupview.prefab"
	}
end

function PetattrpowerupViewPresentor:buildViews()
	return {
		PetattrpowerupView.New()
	}
end

return PetattrpowerupViewPresentor
