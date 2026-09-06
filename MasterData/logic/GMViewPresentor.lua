-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMViewPresentor.lua

module("logic.extensions.gm.view.GMViewPresentor", package.seeall)

local GMViewPresentor = class("GMViewPresentor", ViewPresentor)

function GMViewPresentor:ctor()
	GMViewPresentor.super.ctor(self)
end

function GMViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function GMViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmview.prefab"
	}
end

function GMViewPresentor:buildViews()
	local views = {}
	local view = GMView.New()
	local view3 = MsgView.New()

	table.insert(views, view)
	table.insert(views, view3)

	return views
end

return GMViewPresentor
