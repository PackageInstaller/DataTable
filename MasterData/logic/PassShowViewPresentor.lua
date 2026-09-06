-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/PassShowViewPresentor.lua

module("logic.extensions.legend.view.PassShowViewPresentor", package.seeall)

local PassShowViewPresentor = class("PassShowViewPresentor", ViewPresentor)

function PassShowViewPresentor:ctor()
	PassShowViewPresentor.super.ctor(self)
end

function PassShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassShowViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/passshowview.prefab"
	}
end

function PassShowViewPresentor:buildViews()
	return {
		PassShowView.New()
	}
end

return PassShowViewPresentor
