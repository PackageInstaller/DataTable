-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanSelectViewPresentor.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanSelectViewPresentor", package.seeall)

local CollectTangyuanSelectViewPresentor = class("CollectTangyuanSelectViewPresentor", ViewPresentor)

function CollectTangyuanSelectViewPresentor:ctor()
	CollectTangyuanSelectViewPresentor.super.ctor(self)
end

function CollectTangyuanSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CollectTangyuanSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/collecttangyuan/collecttangyuanselectview.prefab"
	}
end

function CollectTangyuanSelectViewPresentor:buildViews()
	return {
		CollectTangyuanSelectView.New()
	}
end

function CollectTangyuanSelectViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(ViewName.CollectTangyuanSelect)
end

return CollectTangyuanSelectViewPresentor
