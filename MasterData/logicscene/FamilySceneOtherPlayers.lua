-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/FamilySceneOtherPlayers.lua

module("logicscene.scene.component.mainplayer.FamilySceneOtherPlayers", package.seeall)

local FamilySceneOtherPlayers = class("FamilySceneOtherPlayers", SceneComponentBase)

function FamilySceneOtherPlayers:ctor(scene)
	FamilySceneOtherPlayers.super.ctor(self, scene)

	self._isReady = nil
end

function FamilySceneOtherPlayers:onEnterSceneFinished()
	GlobalDispatcher:addListener(GlobalNotify.FamilyScenePlayerEnterScene, self._onPlayerEnter, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyScenePlayerLeaveScene, self._onPlayerLeave, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, self._onPlayerVariables, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyScenePlayerMove, self._onPlayerMove, self)

	self._isReady = true

	local players = FamilySceneModel.instance:getPlayerMoDict()

	if players then
		for k, v in pairs(players) do
			if v then
				printInfo("test FamilySceneOtherPlayers:onEnterSceneFinished = ", k, v)
				self:_createPlayerUnit(v)
			end
		end
	end
end

function FamilySceneOtherPlayers:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.FamilyScenePlayerEnterScene, self._onPlayerEnter, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyScenePlayerLeaveScene, self._onPlayerLeave, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, self._onPlayerVariables, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyScenePlayerMove, self._onPlayerMove, self)

	self._isReady = nil
end

function FamilySceneOtherPlayers:_onPlayerEnter(mo)
	printInfo("test FamilySceneOtherPlayers:_onPlayerEnter", self._isReady)

	if self._isReady then
		self:_createPlayerUnit(mo)
	end
end

function FamilySceneOtherPlayers:_onPlayerLeave(userId)
	if self._isReady then
		self._scene.unitFactory:destroyOtherPlayer(userId)
	end
end

function FamilySceneOtherPlayers:_onPlayerVariables(userId)
	local unit = self._scene.unitFactory:getUnit(UnitTag.Player, userId)

	printInfo("FamilySceneOtherPlayers:_onPlayerVariables:", userId, unit)

	if not unit then
		return
	end

	unit:updateUserVariables()
end

function FamilySceneOtherPlayers:_onPlayerMove(userid, x, z, underBridge, isteleport)
	if self._isReady then
		local unit = self._scene.unitFactory:getUnit(UnitTag.Player, userid)

		if unit then
			unit:pushMoveCmdXZ(x, z, underBridge, isteleport)
		end
	end
end

function FamilySceneOtherPlayers:_createPlayerUnit(mo)
	self._scene.unitFactory:createOtherPlayer(mo)
end

return FamilySceneOtherPlayers
