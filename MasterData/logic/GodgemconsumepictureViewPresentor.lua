-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumepictureViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumepictureViewPresentor", package.seeall)

local GodgemconsumepictureViewPresentor = class("GodgemconsumepictureViewPresentor", ViewPresentor)

function GodgemconsumepictureViewPresentor:ctor()
	GodgemconsumepictureViewPresentor.super.ctor(self)
end

function GodgemconsumepictureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumepictureViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumepictureview.prefab"
	}
end

function GodgemconsumepictureViewPresentor:buildViews()
	return {
		GodgemconsumepictureView.New()
	}
end

function GodgemconsumepictureViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return GodgemconsumepictureViewPresentor
