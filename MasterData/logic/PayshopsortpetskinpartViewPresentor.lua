-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopsortpetskinpartViewPresentor.lua

module("logic.extensions.payshop.view.PayshopsortpetskinpartViewPresentor", package.seeall)

local PayshopsortpetskinpartViewPresentor = class("PayshopsortpetskinpartViewPresentor", ViewPresentor)

function PayshopsortpetskinpartViewPresentor:ctor()
	PayshopsortpetskinpartViewPresentor.super.ctor(self)
end

function PayshopsortpetskinpartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshopsortpetskinpartViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopsortpetskinpart.prefab"
	}
end

function PayshopsortpetskinpartViewPresentor:buildViews()
	return {
		PayshopsortpetskinPart.New()
	}
end

function PayshopsortpetskinpartViewPresentor:setGrayMaskGO(grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

function PayshopsortpetskinpartViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PayshopsortpetskinpartViewPresentor
