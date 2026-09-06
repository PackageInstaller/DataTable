-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMMailViewPresentor.lua

module("logic.extensions.gm.view.GMMailViewPresentor", package.seeall)

local GMMailViewPresentor = class("GMMailViewPresentor", ViewPresentor)

function GMMailViewPresentor:ctor()
	GMMailViewPresentor.super.ctor(self)
end

function GMMailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GMMailViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmmailpanel.prefab"
	}
end

function GMMailViewPresentor:buildViews()
	local views = {}
	local view = GMMailView.New()

	table.insert(views, view)

	return views
end

return GMMailViewPresentor
