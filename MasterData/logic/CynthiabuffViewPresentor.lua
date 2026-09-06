-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiabuffViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.CynthiabuffViewPresentor", package.seeall)

local CynthiabuffViewPresentor = class("CynthiabuffViewPresentor", ViewPresentor)

function CynthiabuffViewPresentor:ctor()
	CynthiabuffViewPresentor.super.ctor(self)
end

function CynthiabuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CynthiabuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xinxiya/cynthiabuffview.prefab"
	}
end

function CynthiabuffViewPresentor:buildViews()
	return {
		CynthiabuffView.New()
	}
end

return CynthiabuffViewPresentor
