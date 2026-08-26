-- chunkname: @modules/logic/room/entity/comp/RoomInitBuildingSkinComp.lua

module("modules.logic.room.entity.comp.RoomInitBuildingSkinComp", package.seeall)

local RoomInitBuildingSkinComp = class("RoomInitBuildingSkinComp", LuaCompBase)
local DEFAULT_SWITCH_TIME = 0.3
local BLOCK_KEY = "RoomInitBuildingSkinComp_refreshBuilding_block"

function RoomInitBuildingSkinComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function RoomInitBuildingSkinComp:init(go)
	self.go = go
	self._skinId = self:_getRoomSkin()
	self._switchTime = CommonConfig.instance:getConstNum(ConstEnum.RoomSkinSwitchTime)

	if not self._switchTime or self._switchTime == 0 then
		self._switchTime = DEFAULT_SWITCH_TIME
	end
end

function RoomInitBuildingSkinComp:addEventListeners()
	RoomSkinController.instance:registerCallback(RoomSkinEvent.SkinListViewShowChange, self._onSkinChange, self)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangePreviewRoomSkin, self._onSkinChange, self)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangeEquipRoomSkin, self._onEquipSkin, self)
end

function RoomInitBuildingSkinComp:removeEventListeners()
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.SkinListViewShowChange, self._onSkinChange, self)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangePreviewRoomSkin, self._onSkinChange, self)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangeEquipRoomSkin, self._onEquipSkin, self)
end

function RoomInitBuildingSkinComp:_onSkinChange()
	if self.__willDestroy then
		return
	end

	local selectPartId = RoomSkinListModel.instance:getSelectPartId()

	if not self.entity or selectPartId ~= self.entity.id then
		return
	end

	local skinId = self:_getRoomSkin()

	if self._skinId ~= skinId then
		TaskDispatcher.cancelTask(self.delayPlayChangeEff, self)

		self._skinId = skinId

		self.entity:tweenAlphaThreshold(0, 1, self._switchTime, self.onHideLastSkinFinish, self)
	end
end

function RoomInitBuildingSkinComp:onHideLastSkinFinish()
	if not self.entity or self.__willDestroy then
		return
	end

	UIBlockMgr.instance:startBlock(BLOCK_KEY)

	self._needPlayChangeEff = true

	self.entity:refreshBuilding(true, 1)
end

function RoomInitBuildingSkinComp:onEffectRebuild()
	UIBlockMgr.instance:endBlock(BLOCK_KEY)

	if self.__willDestroy then
		return
	end

	local effect = self.entity.effect
	local isHasEffectGOByKey = effect:isHasEffectGOByKey(self._effectKey)

	if not isHasEffectGOByKey then
		return
	end

	local isSameRes = effect:isSameResByKey(self._effectKey, self._effectRes)

	if not isSameRes then
		self._effectRes = effect:getEffectRes(self._effectKey)
		self._skinId = self:_getRoomSkin()
	end

	if self._needPlayChangeEff then
		TaskDispatcher.cancelTask(self.delayPlayChangeEff, self)
		TaskDispatcher.runDelay(self.delayPlayChangeEff, self, 0.01)
	end
end

function RoomInitBuildingSkinComp:delayPlayChangeEff()
	if self.__willDestroy then
		return
	end

	self.entity:tweenAlphaThreshold(1, 0, self._switchTime)

	self._needPlayChangeEff = false
end

function RoomInitBuildingSkinComp:_onEquipSkin()
	if self.__willDestroy then
		return
	end

	local selectPartId = RoomSkinListModel.instance:getSelectPartId()

	if not self.entity or selectPartId ~= self.entity.id then
		return
	end

	local isDefaultRoomSkin = RoomSkinModel.instance:isDefaultRoomSkin(selectPartId, self._skinId)

	if isDefaultRoomSkin then
		return
	end

	local changeSkinEffKey = RoomEnum.EffectKey.BuildingEquipSkinEffectKey
	local effect = self.entity.effect
	local isHasChangeSkinEff = effect:isHasEffectGOByKey(changeSkinEffKey)

	if isHasChangeSkinEff then
		local effGo = effect:getEffectGO(changeSkinEffKey)

		gohelper.setActive(effGo, false)
		gohelper.setActive(effGo, true)
	else
		local x, y, z = 0, 0, 0
		local cfgPos = RoomConfig.instance:getRoomSkinEquipEffPos(self._skinId)

		if cfgPos and #cfgPos > 0 then
			x = cfgPos[1] or 0
			y = cfgPos[2] or 0
			z = cfgPos[3] or 0
		end

		local vector3LocalScale
		local cfgScale = RoomConfig.instance:getRoomSkinEquipEffSize(self._skinId)

		effect:addParams({
			[changeSkinEffKey] = {
				res = RoomScenePreloader.ResEquipRoomSkinEffect,
				localPos = Vector3(x, y, z),
				localScale = (cfgScale and cfgScale ~= 0 or nil) and Vector3(cfgScale, cfgScale, cfgScale)
			}
		})
	end

	effect:refreshEffect()
end

function RoomInitBuildingSkinComp:_getRoomSkin()
	if self.__willDestroy then
		return
	end

	return (RoomSkinModel.instance:getShowSkin(self.entity.id))
end

function RoomInitBuildingSkinComp:beforeDestroy()
	UIBlockMgr.instance:endBlock(BLOCK_KEY)

	self.__willDestroy = true

	self:removeEventListeners()
end

function RoomInitBuildingSkinComp:onDestroy()
	TaskDispatcher.cancelTask(self.delayPlayChangeEff, self)

	self.go = nil
	self._effectRes = nil
	self._skinId = nil
	self.entity = nil
	self._needPlayChangeEff = false
end

return RoomInitBuildingSkinComp
