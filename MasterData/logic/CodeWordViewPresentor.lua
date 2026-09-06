-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/view/CodeWordViewPresentor.lua

module("logic.extensions.codeword.view.CodeWordViewPresentor", package.seeall)

local CodeWordViewPresentor = class("CodeWordViewPresentor", ViewPresentor)

function CodeWordViewPresentor:ctor()
	CodeWordViewPresentor.super.ctor(self)
end

function CodeWordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CodeWordViewPresentor:dependWhatResources()
	return {
		"ui/views/codeword/codewordview.prefab"
	}
end

function CodeWordViewPresentor:buildViews()
	return {
		CodeWordView.New()
	}
end

return CodeWordViewPresentor
