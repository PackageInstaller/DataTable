-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/CommonGroupTaskMainViewPresentor.lua

module("logic.extensions.caiqingdraw.view.CommonGroupTaskMainViewPresentor", package.seeall)

local CommonGroupTaskMainViewPresentor = class("CommonGroupTaskMainViewPresentor", ViewPresentor)

function CommonGroupTaskMainViewPresentor:ctor()
	CommonGroupTaskMainViewPresentor.super.ctor(self)
end

function CommonGroupTaskMainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CommonGroupTaskMainViewPresentor:dependWhatResources()
	return {
		"ui/views/common/task/commontaskmainview.prefab"
	}
end

function CommonGroupTaskMainViewPresentor:buildViews()
	return {
		CommonGroupTaskMainView.New()
	}
end

return CommonGroupTaskMainViewPresentor
