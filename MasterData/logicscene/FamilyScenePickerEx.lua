-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/picker/FamilyScenePickerEx.lua

module("logicscene.scene.component.picker.FamilyScenePickerEx", package.seeall)

local FamilyScenePickerEx = class("FamilyScenePickerEx", ScenePickerEx)

function FamilyScenePickerEx:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._unitFactory = SceneMgr.instance:getCurScene().unitFactory
	self._mainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()
end

function FamilyScenePickerEx:onQueryObject(go)
	FamilyScenePickerEx.super.onQueryObject(self, go)
end

function FamilyScenePickerEx:_selectMainPlayer()
	GlobalDispatcher:dispatch(GlobalNotify.FamilySceneSelectMainPlayer)
end

function FamilyScenePickerEx:_selectOtherPlayer(playerId)
	GlobalDispatcher:dispatch(GlobalNotify.FamilySceneSelectOtherPlayer, playerId)
end

function FamilyScenePickerEx:_getSceneMainPlayer()
	return FamilySceneMainPlayer.MainPlayerName
end

function FamilyScenePickerEx:_setWalkEff(x, z)
	local scene = SceneMgr.instance:getCurScene()

	if scene.walkEff then
		scene.walkEff:setVisible(true)
		scene.walkEff:setPosition(x, 0, z)
	end
end

function FamilyScenePickerEx:_runPath(x, z)
	return self._mainPlayer:runPath(x, z, self._onMoveFindWayFinish, self)
end

function FamilyScenePickerEx:onQueryFindWay(x, y)
	return
end

function FamilyScenePickerEx:onQueryFindWayXZ(x, z)
	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	if self._mainPlayer.syncPos then
		self._mainPlayer.syncPos:trySyncPosition()
	end

	TaskController.instance:foreceClearState()
	self:_setWalkEff(x, z)
	self._mainPlayer:handleQueryFindWay()

	local action = self:_runPath(x, z)

	if action then
		action.onStoped = self._onMoveFindWayFinish
		action.onStopedObj = self
	end

	if self._mainPlayer.physics2D then
		self._mainPlayer.physics2D:setKinematic(true)
	end

	if self._mainPlayer.physics3D then
		self._mainPlayer.physics3D:setKinematic(true)
	end
end

return FamilyScenePickerEx
