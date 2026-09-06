-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/bgm/CRSceneBgmMgr.lua

module("logicscene.scene.component.bgm.CRSceneBgmMgr", package.seeall)

local CRSceneBgmMgr = class("CRSceneBgmMgr", SceneComponentBase)

function CRSceneBgmMgr:ctor(scene)
	CRSceneBgmMgr.super.ctor(self, scene)

	self._bgmId = 10100
end

function CRSceneBgmMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	AudioPlayerEx.instance:playMusic(self._bgmId)
end

function CRSceneBgmMgr:onExitSceneFinished()
	if self._bgmId ~= 0 then
		-- block empty
	end
end

function CRSceneBgmMgr:getBgmId()
	return self._bgmId
end

return CRSceneBgmMgr
