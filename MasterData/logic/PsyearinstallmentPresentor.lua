-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PsyearinstallmentPresentor.lua

module("logic.extensions.payshop.view.PsyearinstallmentPresentor", package.seeall)

local PsyearinstallmentPresentor = class("PsyearinstallmentPresentor", ViewPresentor)

function PsyearinstallmentPresentor:ctor()
	PsyearinstallmentPresentor.super.ctor(self)
end

function PsyearinstallmentPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PsyearinstallmentPresentor:dependWhatResources()
	return {
		"ui/views/payshop/psyearinstallmentview.prefab"
	}
end

function PsyearinstallmentPresentor:buildViews()
	return {
		PsyearinstallmentView.New()
	}
end

return PsyearinstallmentPresentor
