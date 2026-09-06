-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneOtherPlayers.lua

module("logicscene.scene.component.mainplayer.SceneOtherPlayers", package.seeall)

local SceneOtherPlayers = class("SceneOtherPlayers", SceneComponentBase)

function SceneOtherPlayers:ctor(scene)
	SceneOtherPlayers.super.ctor(self, scene)

	self._isReady = nil
end

function SceneOtherPlayers:onEnterSceneFinished()
	GlobalDispatcher:addListener(GlobalNotify.PlayerEnterScene, self._onPlayerEnter, self)
	GlobalDispatcher:addListener(GlobalNotify.PlayerLeaveScene, self._onPlayerLeave, self)
	GlobalDispatcher:addListener(GlobalNotify.OnPlayerVariables, self._onPlayerVariables, self)
	GlobalDispatcher:addListener(GlobalNotify.PlayerMove, self._onPlayerMove, self)

	self._isReady = true

	local players = CityModel.instance:getPlayerMoDict()

	if players then
		for k, v in pairs(players) do
			if v then
				self:_createPlayerUnit(v)
			end
		end
	end
end

function SceneOtherPlayers:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.PlayerEnterScene, self._onPlayerEnter, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayerLeaveScene, self._onPlayerLeave, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPlayerVariables, self._onPlayerVariables, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayerMove, self._onPlayerMove, self)

	self._isReady = nil
end

function SceneOtherPlayers:_onPlayerEnter(mo)
	if self._isReady then
		self:_createPlayerUnit(mo)
	end
end

function SceneOtherPlayers:_onPlayerLeave(userId)
	if self._isReady then
		self._scene.unitFactory:destroyOtherPlayer(userId)
	end
end

function SceneOtherPlayers:_onPlayerVariables(userId)
	printInfo("_onPlayerVariables:", userId)

	local unit = self._scene.unitFactory:getUnit(UnitTag.Player, userId)

	if not unit then
		return
	end

	unit:updateUserVariables()

	local syncUserVarUserId = unit:getSyncUserVarUserId()

	if checknumber(syncUserVarUserId) > 0 then
		if checknumber(syncUserVarUserId) == checknumber(RoleModel.instance:getUserId()) then
			SceneMainPlayer.instance:updateVariablesView()

			return
		end

		local syncUnit = self._scene.unitFactory:getUnit(UnitTag.Player, tostring(syncUserVarUserId))

		if syncUnit then
			syncUnit:updateUserVariables()
		end
	end
end

function SceneOtherPlayers:_onPlayerMove(userid, x, y, underBridge, isteleport)
	if self._isReady then
		local unit = self._scene.unitFactory:getUnit(UnitTag.Player, userid)

		if unit then
			unit:pushMoveCmd(x, y, underBridge, isteleport)
		end
	end
end

function SceneOtherPlayers:_createPlayerUnit(mo)
	self._scene.unitFactory:createOtherPlayer(mo)
end

return SceneOtherPlayers
