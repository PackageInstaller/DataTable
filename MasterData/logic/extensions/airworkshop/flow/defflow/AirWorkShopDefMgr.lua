-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkShopDefMgr.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkShopDefMgr", package.seeall)

local M = class("AirWorkShopDefMgr")

function M:ctor()
	self._activeDefFlow = false
end

function M:tryEnterCreateMode()
	if AirWorkMapModel.instance:hasLevel() then
		ViewMgr.instance:open(ViewName.AirWorkShopManagerView)
	else
		AirWorkShopDefSceneModel.instance:setSaveIndex(1)
		self:createMapAndEnter()
	end
end

function M:createMapAndEnter()
	ViewMgr.instance:open(ViewName.AirWorkShopDefThemeSelectView)
end

function M:enter(levelId, mapMO)
	if self._activeDefFlow then
		self._activeDefFlow.model:setJumpToAnotherScene(true)
		self._activeDefFlow:clearForExit()
	end

	self._activeDefFlow = AirWorkShopDefFlow.New()

	self._activeDefFlow:enter(levelId, mapMO)
end

function M:exit()
	if self._activeDefFlow then
		self._activeDefFlow:exit()

		self._activeDefFlow = false
	end
end

function M:forceExit()
	if self._activeDefFlow then
		self._activeDefFlow:forceExit()

		self._activeDefFlow = false
	end
end

function M:isInDefFlow()
	return self._activeDefFlow and true or false
end

function M:getModel()
	return self._activeDefFlow.model
end

function M:getScenePicker()
	return self._activeDefFlow.scenePickerHandler
end

function M:getBoardMgr()
	return self._activeDefFlow.boardMgr
end

function M:getUnitMgr()
	return self._activeDefFlow.unitMgr
end

function M:getPathArrow()
	return self._activeDefFlow.pathArrow
end

function M:getBoardModel()
	return self._activeDefFlow.boardModel
end

function M:getResourceMgr()
	return self._activeDefFlow.resMgr
end

function M:getUnitOperator()
	return self._activeDefFlow.unitOperator
end

function M:getHighlandChecker()
	return self._activeDefFlow.highlandChecker
end

function M:getCameraShot()
	return self._activeDefFlow.cameraShot
end

M.instance = M.New()

return M
