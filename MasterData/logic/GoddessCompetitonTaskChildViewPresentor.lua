-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitonTaskChildViewPresentor.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitonTaskChildViewPresentor", package.seeall)

local GoddessCompetitonTaskChildViewPresentor = class("GoddessCompetitonTaskChildViewPresentor", ViewPresentor)

function GoddessCompetitonTaskChildViewPresentor:ctor()
	GoddessCompetitonTaskChildViewPresentor.super.ctor(self)
end

function GoddessCompetitonTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessCompetitonTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscompetition/goddesscompetitontaskchildview.prefab"
	}
end

function GoddessCompetitonTaskChildViewPresentor:buildViews()
	return {
		GoddessCompetitonTaskChildView.New()
	}
end

function GoddessCompetitonTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoddessCompetitonTaskChildViewPresentor
