-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetdetailViewPresentor.lua

module("logic.extensions.payshop.view.PayshoppetdetailViewPresentor", package.seeall)

local PayshoppetdetailViewPresentor = class("PayshoppetdetailViewPresentor", ViewPresentor)

function PayshoppetdetailViewPresentor:ctor()
	PayshoppetdetailViewPresentor.super.ctor(self)
end

function PayshoppetdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshoppetdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshoppetdetailview.prefab"
	}
end

function PayshoppetdetailViewPresentor:buildViews()
	return {
		PayshoppetdetailView.New()
	}
end

return PayshoppetdetailViewPresentor
