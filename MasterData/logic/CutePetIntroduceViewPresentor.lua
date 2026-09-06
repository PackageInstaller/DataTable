-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/introduce/CutePetIntroduceViewPresentor.lua

module("logic.extensions.cutepet.view.introduce.CutePetIntroduceViewPresentor", package.seeall)

local CutePetIntroduceViewPresentor = class("CutePetIntroduceViewPresentor", ViewPresentor)

function CutePetIntroduceViewPresentor:ctor()
	CutePetIntroduceViewPresentor.super.ctor(self)
end

function CutePetIntroduceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetIntroduceViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/introduce/cutepetintroduceview.prefab"
	}
end

function CutePetIntroduceViewPresentor:buildViews()
	return {
		CutePetIntroduceView.New()
	}
end

return CutePetIntroduceViewPresentor
