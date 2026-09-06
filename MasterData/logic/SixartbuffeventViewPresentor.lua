-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartbuffeventViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartbuffeventViewPresentor", package.seeall)

local SixartbuffeventViewPresentor = class("SixartbuffeventViewPresentor", ViewPresentor)

function SixartbuffeventViewPresentor:ctor()
	SixartbuffeventViewPresentor.super.ctor(self)
end

function SixartbuffeventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SixartbuffeventViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartbuffeventview.prefab"
	}
end

function SixartbuffeventViewPresentor:buildViews()
	return {
		SixartbuffeventView.New()
	}
end

function SixartbuffeventViewPresentor:setGrayMaskGO(grayMaskGO)
	SixartbuffeventViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return SixartbuffeventViewPresentor
