-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/bgm/FamilySceneBgmMgr.lua

module("logicscene.scene.component.bgm.FamilySceneBgmMgr", package.seeall)

local FamilySceneBgmMgr = class("FamilySceneBgmMgr", SceneComponentBase)

function FamilySceneBgmMgr:ctor(scene)
	CRSceneBgmMgr.super.ctor(self, scene)

	self._bgmIds = {
		10101,
		10102
	}
	self._bgmId = 0
	self._cnt = 0
end

function FamilySceneBgmMgr:onEnterSceneFinished(sceneId, bornX, bornZ)
	local numBgms = #self._bgmIds

	if numBgms > 1 then
		self._cnt = self._cnt + 1

		local idx = (self._bgmId + self._cnt) % numBgms + 1

		self._bgmId = self._bgmIds[idx]

		printInfo("test 家族播放场景音乐，audio id:" .. self._bgmId .. ", random idx:" .. idx)
	else
		self._bgmId = self._bgmIds[1]
	end

	AudioPlayerEx.instance:playMusic(self._bgmId)
end

function FamilySceneBgmMgr:onExitSceneFinished()
	if self._bgmId ~= 0 then
		-- block empty
	end
end

function FamilySceneBgmMgr:getBgmId()
	return self._bgmId
end

return FamilySceneBgmMgr
