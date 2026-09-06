-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainBtnExpandViewPresentor.lua

module("logic.extensions.mainui.view.MainBtnExpandViewPresentor", package.seeall)

local MainBtnExpandViewPresentor = class("MainBtnExpandViewPresentor", ViewWithGuidePresentor)

function MainBtnExpandViewPresentor:ctor()
	MainBtnExpandViewPresentor.super.ctor(self)
end

function MainBtnExpandViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function MainBtnExpandViewPresentor:dependWhatResources()
	return {
		"ui/views/mainui/mainbtnexpandview.prefab"
	}
end

function MainBtnExpandViewPresentor:buildViews()
	local views = {}
	local mainbtnexpandview = MainBtnExpandView.New()

	table.insert(views, mainbtnexpandview)

	return views
end

function MainBtnExpandViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function MainBtnExpandViewPresentor:setGrayMaskGO(grayMaskGO)
	MainBtnExpandViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return MainBtnExpandViewPresentor
