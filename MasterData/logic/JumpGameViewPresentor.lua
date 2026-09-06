-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpGameViewPresentor.lua

module("logic.extensions.jumpgame.view.JumpGameViewPresentor", package.seeall)

local JumpGameViewPresentor = class("JumpGameViewPresentor", ViewPresentor)

function JumpGameViewPresentor:ctor()
	JumpGameViewPresentor.super.ctor(self)
end

function JumpGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpGameViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpgame/jumpgameview.prefab",
		"ui/views/jumpgame/pillar.prefab",
		"character/10159_gongfuxiongmao/10159_gongfuxiongmao-ui_p.prefab",
		"ui/views/jumpgame/item1.prefab",
		"ui/views/jumpgame/item2.prefab",
		"ui/views/jumpgame/item3.prefab",
		"ui/views/jumpgame/item4.prefab",
		"ui/views/jumpgame/item5.prefab",
		"ui/views/jumpgame/pillarnode.prefab",
		"ui/views/jumpgame/getscore.prefab"
	}
end

function JumpGameViewPresentor:buildViews()
	local views = {}
	local view = JumpGameView.New()

	table.insert(views, view)

	view = JumpRoadView.New()

	table.insert(views, view)

	view = JumpPlayer.New()

	table.insert(views, view)

	view = JumpCloseBgView.New()

	table.insert(views, view)

	return views
end

return JumpGameViewPresentor
