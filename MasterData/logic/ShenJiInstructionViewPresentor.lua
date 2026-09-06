-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiInstructionViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiInstructionViewPresentor", package.seeall)

local ShenJiInstructionViewPresentor = class("ShenJiInstructionViewPresentor", ViewPresentor)

function ShenJiInstructionViewPresentor:ctor()
	ShenJiInstructionViewPresentor.super.ctor(self)
end

function ShenJiInstructionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiInstructionViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjiinstructionview.prefab"
	}
end

function ShenJiInstructionViewPresentor:buildViews()
	return {
		ShenJiInstructionView.New()
	}
end

function ShenJiInstructionViewPresentor:setGrayMaskGO(grayMaskGO)
	ShenJiInstructionViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return ShenJiInstructionViewPresentor
