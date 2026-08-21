-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopModelComponent.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopModelComponent", package.seeall)

local M = class("AirWorkShopModelComponent", IAirWorkShopFlowComp)

function M:onInit()
	self._cameraRotation = 0
	self._isJumpToAnotherScene = false
end

function M:onStart()
	return
end

function M:onClear()
	AirWorkShopDefSceneModel.instance:onExitScene()

	self._cameraRotation = 0
	self._levelId = false
	self._isJumpToAnotherScene = false
end

function M:init(levelId, mapMO)
	self._levelId = levelId

	printWarn("viking", levelId, mapMO)

	if self._levelId and not mapMO then
		local airLevelMO = AirWorkMapModel.instance:getLevelMOById(levelId)

		mapMO = airLevelMO:getMapMO()
	end

	self._modifiedMapMO = mapMO:deepCopy()
	self._sceneId = self._modifiedMapMO:getSceneId()
	self._sceneCO = AirWorkShopConfig.instance:getSceneCO(self._sceneId)

	local levelCode = self._sceneCO.levelId

	self._levelCO = BattleConfig.instance:getBattleLevelCO(levelCode)

	AirWorkShopDefSceneModel.instance:onEnterScene()
end

function M:getLevelId()
	return self._levelId
end

function M:setLevelId(levelId)
	self._levelId = levelId
end

function M:getSceneId()
	return self._sceneId
end

function M:recordCameraRotation(rotation)
	self._cameraRotation = rotation
end

function M:getCameraRotation()
	return self._cameraRotation
end

function M:getModiedMapMO()
	return self._modifiedMapMO
end

function M:getLevelCode()
	return self._sceneCO.levelId
end

function M:getBattleSceneCode()
	return self._levelCO.sceneId
end

function M:getLevelCO()
	return self._sceneCO
end

function M:isInAttackArea(unionIndex)
	return self._modifiedMapMO:isBornPos(unionIndex)
end

function M:isJumpToAnotherScene()
	return self._isJumpToAnotherScene
end

function M:setJumpToAnotherScene(state)
	self._isJumpToAnotherScene = state
end

return M
