-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialchapterViewPresentor.lua

module("logic.extensions.mirrortrial.view.MirrortrialchapterViewPresentor", package.seeall)

local MirrortrialchapterViewPresentor = class("MirrortrialchapterViewPresentor", ViewPresentor)

function MirrortrialchapterViewPresentor:ctor()
	MirrortrialchapterViewPresentor.super.ctor(self)
end

function MirrortrialchapterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MirrortrialchapterViewPresentor:dependWhatResources()
	return {
		"ui/views/mirrortrial/mirrortrialchapterview.prefab"
	}
end

function MirrortrialchapterViewPresentor:buildViews()
	return {
		MirrortrialchapterView.New()
	}
end

function MirrortrialchapterViewPresentor:getTempResources()
	return MirrorTrialModel.instance:getCurChapterRes()
end

function MirrortrialchapterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MirrortrialchapterViewPresentor
