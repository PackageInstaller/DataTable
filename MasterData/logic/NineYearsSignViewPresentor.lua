-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/NineYearsSignViewPresentor.lua

module("logic.extensions.accumulategift.view.NineYearsSignViewPresentor", package.seeall)

local NineYearsSignViewPresentor = class("NineYearsSignViewPresentor", ViewPresentor)

function NineYearsSignViewPresentor:ctor()
	NineYearsSignViewPresentor.super.ctor(self)
end

function NineYearsSignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineYearsSignViewPresentor:dependWhatResources()
	return {
		"ui/views/accumulategift/nineyearssignview.prefab"
	}
end

function NineYearsSignViewPresentor:buildViews()
	return {
		NineYearsSignView.New()
	}
end

return NineYearsSignViewPresentor
