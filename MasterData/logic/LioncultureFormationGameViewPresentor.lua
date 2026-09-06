-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureFormationGameViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureFormationGameViewPresentor", package.seeall)

local LioncultureFormationGameViewPresentor = class("LioncultureFormationGameViewPresentor", ViewPresentor)

function LioncultureFormationGameViewPresentor:ctor()
	LioncultureFormationGameViewPresentor.super.ctor(self)
end

function LioncultureFormationGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureFormationGameViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureformationgameview.prefab"
	}
end

function LioncultureFormationGameViewPresentor:buildViews()
	return {
		LioncultureFormationGameView.New()
	}
end

function LioncultureFormationGameViewPresentor:getTempResources()
	return {
		LioncultureModel.instance:getPlayerSpineRes()
	}
end

return LioncultureFormationGameViewPresentor
