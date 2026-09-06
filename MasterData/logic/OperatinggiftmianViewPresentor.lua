-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operatingGift/view/OperatinggiftmianViewPresentor.lua

module("logic.extensions.operatingGift.view.OperatinggiftmianViewPresentor", package.seeall)

local OperatinggiftmianViewPresentor = class("OperatinggiftmianViewPresentor", ViewPresentor)

function OperatinggiftmianViewPresentor:ctor()
	OperatinggiftmianViewPresentor.super.ctor(self)
end

function OperatinggiftmianViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OperatinggiftmianViewPresentor:dependWhatResources()
	return {
		"ui/views/operatinggift/operatinggiftmianview.prefab"
	}
end

function OperatinggiftmianViewPresentor:buildViews()
	return {
		OperatinggiftmianView.New()
	}
end

return OperatinggiftmianViewPresentor
