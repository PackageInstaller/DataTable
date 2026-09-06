-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooRenameViewPresentor.lua

module("logic.extensions.zoo.view.ZooRenameViewPresentor", package.seeall)

local ZooRenameViewPresentor = class("ZooRenameViewPresentor", ViewPresentor)

function ZooRenameViewPresentor:ctor()
	ZooRenameViewPresentor.super.ctor(self)
end

function ZooRenameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooRenameViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoorenameview.prefab"
	}
end

function ZooRenameViewPresentor:buildViews()
	return {
		ZooRenameView.New()
	}
end

return ZooRenameViewPresentor
