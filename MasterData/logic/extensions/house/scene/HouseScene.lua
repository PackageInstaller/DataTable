-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/HouseScene.lua

module("logic.extensions.house.scene.HouseScene", package.seeall)

local M = class("HouseScene", SceneBaseSpacx)

M.SceneCode = 3001

function M:ctor(container)
	M.super.ctor(self, container)

	self._mainPlayer = nil
end

function M:_initComponents()
	self:_addComponent("stage", HouseSceneStage)
	self:_addComponent("camera", HouseSceneCamera)
	self:_addComponent("light", SceneLight)
	self:_addComponent("pickerHandler", HouseScenePickerHandler)
	self:_addComponent("roomMgr", HouseSceneRoomMgr)
	self:_addComponent("unitFactory", UnitFactory)
	self:_addComponent("shelterRecorder", HouseSceneShelterRecorder)
	self:_addComponent("exploreMgr", HouseSceneExploreModeMgr)
end

function M:onExit()
	if self._mainPlayer ~= nil and self._mainPlayer.controller:getElevatorStatus() == SceneEnum.ElevatorHeroStatus.None then
		GlobalDispatcher:dispatchEvent(EventType.SCENE_CACHE_MAIN_PLAYER_POS, self._mainPlayer:getAgentPos())
	end

	M.super.onExit(self)

	self._mainPlayer = nil
end

function M:getSceneType()
	return SceneType.House
end

function M:setMainPlayer(mainPlayer)
	self._mainPlayer = mainPlayer
end

function M:getMainPlayer()
	return self._mainPlayer
end

return M
