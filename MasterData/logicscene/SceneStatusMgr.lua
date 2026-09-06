-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/tiling/SceneStatusMgr.lua

module("logicscene.scene.tiling.SceneStatusMgr", package.seeall)

local SceneStatusMgr = class("SceneStatusMgr")

function SceneStatusMgr:ctor()
	self._status = nil
end

function SceneStatusMgr:saveStatus()
	local curScene = SceneMgr.instance:getCurScene()

	if curScene then
		local status = SceneStatus.New()

		status:saveStatus(curScene)

		self._status = self._status or {}

		table.insert(self._status, status)
	end
end

function SceneStatusMgr:popStatus(defaultView)
	local status = self:topStatus()

	if status then
		table.remove(self._status, #self._status)

		local playerBirdgeState, playerUsersVars

		if SceneMainPlayer.instance then
			local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
		end

		SceneMgr.instance:enter(status.originSceneType, status.originSceneId, status.posX, status.posY, status.playerBirdgeState, playerUsersVars, defaultView)
	end
end

function SceneStatusMgr:topStatus()
	if self._status and #self._status > 0 then
		return self._status[#self._status]
	end
end

function SceneStatusMgr:clearStatus()
	self._status = nil
end

SceneStatusMgr.instance = SceneStatusMgr.New()

return SceneStatusMgr
