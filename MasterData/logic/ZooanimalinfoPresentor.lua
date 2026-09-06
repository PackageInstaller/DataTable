-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooanimalinfoPresentor.lua

module("logic.extensions.zoo.view.ZooanimalinfoPresentor", package.seeall)

local ZooanimalinfoPresentor = class("ZooanimalinfoPresentor", ViewPresentor)

function ZooanimalinfoPresentor:ctor()
	ZooanimalinfoPresentor.super.ctor(self)
end

function ZooanimalinfoPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooanimalinfoPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooanimalinfoview.prefab"
	}
end

function ZooanimalinfoPresentor:buildViews()
	return {
		ZooanimalinfoView.New()
	}
end

return ZooanimalinfoPresentor
