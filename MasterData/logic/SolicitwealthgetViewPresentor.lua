-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/view/SolicitwealthgetViewPresentor.lua

module("logic.extensions.solicitwealth.view.SolicitwealthgetViewPresentor", package.seeall)

local SolicitwealthgetViewPresentor = class("SolicitwealthgetViewPresentor", ViewPresentor)

function SolicitwealthgetViewPresentor:ctor()
	SolicitwealthgetViewPresentor.super.ctor(self)
end

function SolicitwealthgetViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function SolicitwealthgetViewPresentor:dependWhatResources()
	return {
		"ui/views/solicitwealth/solicitwealthgetview.prefab"
	}
end

function SolicitwealthgetViewPresentor:buildViews()
	return {
		SolicitwealthgetView.New()
	}
end

return SolicitwealthgetViewPresentor
