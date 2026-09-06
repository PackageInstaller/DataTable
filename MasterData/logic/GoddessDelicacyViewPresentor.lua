-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessDelicacyViewPresentor.lua

module("logic.extensions.goddessdelicacy.view.GoddessDelicacyViewPresentor", package.seeall)

local GoddessDelicacyViewPresentor = class("GoddessDelicacyViewPresentor", ViewPresentor)

function GoddessDelicacyViewPresentor:ctor()
	GoddessDelicacyViewPresentor.super.ctor(self)
end

function GoddessDelicacyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessDelicacyViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessdelicacy/goddessdelicacyview.prefab"
	}
end

function GoddessDelicacyViewPresentor:buildViews()
	return {
		GoddessDelicacyView.New()
	}
end

return GoddessDelicacyViewPresentor
