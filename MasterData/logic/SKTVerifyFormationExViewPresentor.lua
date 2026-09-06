-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/dream/SKTVerifyFormationExViewPresentor.lua

module("logic.extensions.saintknighttask.view.dream.SKTVerifyFormationExViewPresentor", package.seeall)

local SKTVerifyFormationExViewPresentor = class("SKTVerifyFormationExViewPresentor", ViewPresentor)

function SKTVerifyFormationExViewPresentor:ctor()
	SKTVerifyFormationExViewPresentor.super.ctor(self)
end

function SKTVerifyFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTVerifyFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktverifyformationexview.prefab"
	}
end

function SKTVerifyFormationExViewPresentor:buildViews()
	return {
		SKTVerifyFormationExView.New()
	}
end

function SKTVerifyFormationExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTVerifyFormationExViewPresentor
