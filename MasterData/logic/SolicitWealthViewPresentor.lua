-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/view/SolicitWealthViewPresentor.lua

module("logic.extensions.solicitwealth.view.SolicitWealthViewPresentor", package.seeall)

local SolicitWealthViewPresentor = class("SolicitWealthViewPresentor", ViewPresentor)

function SolicitWealthViewPresentor:ctor()
	SolicitWealthViewPresentor.super.ctor(self)
end

function SolicitWealthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SolicitWealthViewPresentor:dependWhatResources()
	return {
		"ui/views/solicitwealth/solicitwealthview.prefab"
	}
end

function SolicitWealthViewPresentor:buildViews()
	return {
		SolicitWealthView.New()
	}
end

return SolicitWealthViewPresentor
