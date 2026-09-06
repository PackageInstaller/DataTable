-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/view/MopupMainViewPresentor.lua

module("logic.extensions.mopup.view.MopupMainViewPresentor", package.seeall)

local MopupMainViewPresentor = class("MopupMainViewPresentor", ViewWithGuidePresentor)

function MopupMainViewPresentor:ctor()
	MopupMainViewPresentor.super.ctor(self)
end

function MopupMainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MopupMainViewPresentor:dependWhatResources()
	return {
		"ui/views/sweep/sweepview_new.prefab"
	}
end

function MopupMainViewPresentor:buildViews()
	return {
		MopupMainView.New()
	}
end

function MopupMainViewPresentor:onClickOutside()
	ViewMgr.instance:close(self.viewName)
end

return MopupMainViewPresentor
