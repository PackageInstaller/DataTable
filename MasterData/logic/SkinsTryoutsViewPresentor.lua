-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/SkinsTryoutsViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.SkinsTryoutsViewPresentor", package.seeall)

local SkinsTryoutsViewPresentor = class("SkinsTryoutsViewPresentor", ViewPresentor)

function SkinsTryoutsViewPresentor:ctor()
	SkinsTryoutsViewPresentor.super.ctor(self)
end

function SkinsTryoutsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkinsTryoutsViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/skinstryoutsview.prefab"
	}
end

function SkinsTryoutsViewPresentor:buildViews()
	return {
		SkinsTryoutsView.New()
	}
end

return SkinsTryoutsViewPresentor
