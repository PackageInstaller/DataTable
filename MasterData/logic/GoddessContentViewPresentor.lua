-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessContentViewPresentor.lua

module("logic.extensions.goddessdelicacy.view.GoddessContentViewPresentor", package.seeall)

local GoddessContentViewPresentor = class("GoddessContentViewPresentor", ViewPresentor)

function GoddessContentViewPresentor:ctor()
	GoddessContentViewPresentor.super.ctor(self)
end

function GoddessContentViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessContentViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessdelicacy/goddesscontentview.prefab"
	}
end

function GoddessContentViewPresentor:buildViews()
	return {
		GoddessContentView.New()
	}
end

return GoddessContentViewPresentor
