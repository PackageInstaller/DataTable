-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/improveinfo/view/ImproveInfoViewPresentor.lua

module("logic.extensions.improveinfo.view.ImproveInfoViewPresentor", package.seeall)

local ImproveInfoViewPresentor = class("ImproveInfoViewPresentor", ViewPresentor)

function ImproveInfoViewPresentor:ctor()
	ImproveInfoViewPresentor.super.ctor(self)
end

function ImproveInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ImproveInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/improveinfo/improveinfoview.prefab"
	}
end

function ImproveInfoViewPresentor:buildViews()
	return {
		ImproveInfoView.New()
	}
end

return ImproveInfoViewPresentor
