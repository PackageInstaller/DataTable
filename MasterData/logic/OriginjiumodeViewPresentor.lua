-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiumodeViewPresentor.lua

module("logic.extensions.originjiu.view.OriginjiumodeViewPresentor", package.seeall)

local OriginjiumodeViewPresentor = class("OriginjiumodeViewPresentor", ViewPresentor)

function OriginjiumodeViewPresentor:ctor()
	OriginjiumodeViewPresentor.super.ctor(self)
end

function OriginjiumodeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginjiumodeViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiumodeview.prefab"
	}
end

function OriginjiumodeViewPresentor:buildViews()
	return {
		OriginjiumodeView.New()
	}
end

return OriginjiumodeViewPresentor
