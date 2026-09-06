-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaArrangeViewPresentor.lua

module("logic.extensions.kingarena.view.KingArenaArrangeViewPresentor", package.seeall)

local KingArenaArrangeViewPresentor = class("KingArenaArrangeViewPresentor", ViewPresentor)

function KingArenaArrangeViewPresentor:ctor()
	KingArenaArrangeViewPresentor.super.ctor(self)
end

function KingArenaArrangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingArenaArrangeViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/kingarenaarrangeview.prefab"
	}
end

function KingArenaArrangeViewPresentor:buildViews()
	return {
		KingArenaArrangeView.New()
	}
end

function KingArenaArrangeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaArrangeViewPresentor
