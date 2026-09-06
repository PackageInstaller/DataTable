-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/FullwincomponentPresentor.lua

module("logic.extensions.common.view.FullwincomponentPresentor", package.seeall)

local FullwincomponentPresentor = class("FullwincomponentPresentor", ViewPresentor)

function FullwincomponentPresentor:ctor()
	FullwincomponentPresentor.super.ctor(self)
end

function FullwincomponentPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FullwincomponentPresentor:dependWhatResources()
	return {
		"ui/views/common/fullwincomponent.prefab"
	}
end

function FullwincomponentPresentor:buildViews()
	return {
		FullwincomponentView.New()
	}
end

return FullwincomponentPresentor
