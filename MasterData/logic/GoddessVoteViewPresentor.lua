-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/view/GoddessVoteViewPresentor.lua

module("logic.extensions.goddessvote.view.GoddessVoteViewPresentor", package.seeall)

local GoddessVoteViewPresentor = class("GoddessVoteViewPresentor", ViewPresentor)

function GoddessVoteViewPresentor:ctor()
	GoddessVoteViewPresentor.super.ctor(self)
end

function GoddessVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessvote/goddessvoteview.prefab"
	}
end

function GoddessVoteViewPresentor:buildViews()
	return {
		GoddessVoteView.New()
	}
end

return GoddessVoteViewPresentor
