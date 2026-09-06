-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionBase.lua

module("logicscene.scene.SceneTransitionBase", package.seeall)

local SceneTransitionBase = class("SceneTransitionBase")

function SceneTransitionBase:ctor()
	return
end

function SceneTransitionBase:prepareTransition(preScene, currScene, isSwitchFestival)
	self._preScene = preScene
	self._currScene = currScene
	self._isSwitchFestival = isSwitchFestival

	GameUtil.clickEnabled(false, self)
end

function SceneTransitionBase:onEnterFinished()
	self._preScene = nil
	self._currScene = nil

	GameUtil.clickEnabled(true, self)
end

function SceneTransitionBase:clear()
	self._preScene = nil
	self._currScene = nil

	GameUtil.clickEnabled(true, self)
end

return SceneTransitionBase
