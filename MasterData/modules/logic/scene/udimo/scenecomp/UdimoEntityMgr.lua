-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoEntityMgr.lua

module("modules.logic.scene.udimo.scenecomp.UdimoEntityMgr", package.seeall)

local UdimoEntityMgr = class("UdimoEntityMgr", BaseSceneUnitMgr)

function UdimoEntityMgr:onInit()
	local scene = self:getCurScene()

	self._containerGO = scene.go:getUdimoRoot()
end

function UdimoEntityMgr:onSceneStart(sceneId, levelId)
	return
end

function UdimoEntityMgr:init(sceneId, levelId)
	self:setUdimoNodeActive(true)
	self:refreshAllUdimoEntities()
	self:addEventListeners()
end

function UdimoEntityMgr:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnPickUpUdimo, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnPickUpUdimoOver, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:registerCallback(UdimoEvent.UdimoWaitInteractOverTime, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:registerCallback(UdimoEvent.BeginInetract, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:registerCallback(UdimoEvent.InteractFinished, self._triggerChangeUdimoStateEvent, self)
end

function UdimoEntityMgr:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnChangeUidmoShow, self._onChangeUdimoShow, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnPickUpUdimo, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnPickUpUdimoOver, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.UdimoWaitInteractOverTime, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.BeginInetract, self._triggerChangeUdimoStateEvent, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.InteractFinished, self._triggerChangeUdimoStateEvent, self)
end

function UdimoEntityMgr:_onChangeUdimoShow()
	self:refreshAllUdimoEntities()
end

function UdimoEntityMgr:_triggerChangeUdimoStateEvent(udimoId, eventParam)
	local udimoEntity = self:getUdimoEntity(udimoId)

	if not udimoEntity or not eventParam then
		return
	end

	local eventId = eventParam.eventId
	local param = eventParam.param

	udimoEntity:triggerChangeStateEvent(eventId, param)
end

function UdimoEntityMgr:refreshAllUdimoEntities()
	local removeEntityList = {}
	local udimoEntityDict = self:getUdimoEntityDict()

	for _, udimoEntity in pairs(udimoEntityDict) do
		local udimoId = udimoEntity:getId()
		local isUse = UdimoModel.instance:isUseUdimo(udimoId)

		if not isUse then
			removeEntityList[#removeEntityList + 1] = udimoEntity
		end
	end

	for _, udimoEntity in ipairs(removeEntityList) do
		self:removeUdimoEntity(udimoEntity)
	end

	local useUidmoIdList = UdimoModel.instance:getUseUdimoIdList()

	for _, udimoId in ipairs(useUidmoIdList) do
		self:addUdimoEntity(udimoId)
	end
end

function UdimoEntityMgr:addUdimoEntity(udimoId)
	local udimoMO = UdimoModel.instance:getUdimoMO(udimoId)
	local udimoEntity = self:getUdimoEntity(udimoId)

	if not udimoMO or udimoEntity then
		return
	end

	local udimoGO = gohelper.create3d(self._containerGO, udimoId)

	udimoEntity = MonoHelper.addLuaComOnceToGo(udimoGO, UdimoEntity, udimoId)

	self:addUnit(udimoEntity)

	return udimoEntity
end

function UdimoEntityMgr:removeUdimoEntity(entity)
	self:removeUnit(entity:getTag(), entity.id)
end

function UdimoEntityMgr:updateUdimoCurStateParam(udimoId, checkStateName, updateParam)
	local udimoEntity = self:getUdimoEntity(udimoId)

	udimoEntity:updateCurStateParam(checkStateName, updateParam)
end

function UdimoEntityMgr:setUdimoNodeActive(isActive)
	gohelper.setActive(self._containerGO, isActive)
end

function UdimoEntityMgr:getUdimoEntity(udimoId)
	local tagEntityDict = self:getUdimoEntityDict()

	return tagEntityDict and tagEntityDict[udimoId]
end

function UdimoEntityMgr:getUdimoEntityDict()
	return self._tagUnitDict[SceneTag.Untagged] or {}
end

function UdimoEntityMgr:getTypeUdimoList(udimoType)
	local result = {}

	if udimoType then
		local tagEntityDict = self:getUdimoEntityDict()

		for udimoId, entity in pairs(tagEntityDict) do
			local type = UdimoConfig.instance:getUdimoType(udimoId)

			if type == udimoType then
				result[#result + 1] = entity
			end
		end
	end

	return result
end

function UdimoEntityMgr:onSceneClose()
	self:removeEventListeners()
	UdimoEntityMgr.super.onSceneClose(self)
end

return UdimoEntityMgr
