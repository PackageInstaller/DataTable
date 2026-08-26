-- chunkname: @modules/logic/room/entity/comp/RoomBlockChangeColorComp.lua

module("modules.logic.room.entity.comp.RoomBlockChangeColorComp", package.seeall)

local RoomBlockChangeColorComp = class("RoomBlockChangeColorComp", LuaCompBase)
local Shader = UnityEngine.Shader
local ShaderIDMap = {
	enableChangeColor = Shader.PropertyToID("_EnableChangeColor"),
	hue = Shader.PropertyToID("_Hue"),
	saturation = Shader.PropertyToID("_Saturation"),
	brightness = Shader.PropertyToID("_Brightness")
}

function RoomBlockChangeColorComp:ctor(entity)
	self.entity = entity
	self._blockColor = nil
	self._blockColorKeyMap = {}
end

function RoomBlockChangeColorComp:onEffectReturn(key, res)
	self:_refreshColor(key, RoomWaterReformModel.InitBlockColor)
end

function RoomBlockChangeColorComp:onEffectRebuild()
	self:refreshLand()
end

function RoomBlockChangeColorComp:beforeDestroy()
	self.__willDestroy = true

	TaskDispatcher.cancelTask(self._onRunRefreshLandTask, self)
end

function RoomBlockChangeColorComp:refreshLand()
	if self.__willDestroy then
		return
	end

	if not self._isHasRefreshLandTask then
		self._isHasRefreshLandTask = true

		TaskDispatcher.runDelay(self._onRunRefreshLandTask, self, 0.01)
	end
end

function RoomBlockChangeColorComp:_onRunRefreshLandTask()
	self._isHasRefreshLandTask = false

	if self.__willDestroy then
		return
	end

	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local blockType = mo:getDefineBlockType()

	self:_refreshColor(RoomEnum.EffectKey.BlockRiverKey, self:_getColorIdByBlockType(blockType))
	self:_refreshFullRiver(mo)
end

function RoomBlockChangeColorComp:_refreshFullRiver(tempMO)
	if not tempMO or not tempMO:isFullWater() then
		return
	end

	for i = 1, 6 do
		local linkType, defineBlockType, defineBlockBType
		local resourceId = tempMO:getResourceId(i, true)

		if resourceId == RoomResourceEnum.ResourceId.River then
			linkType, defineBlockType, defineBlockBType = tempMO:getResourceTypeRiver(i, true)
		end

		if linkType then
			if defineBlockType then
				self:_refreshColor(RoomEnum.EffectKey.BlockFloorKeys[i], self:_getColorIdByBlockType(defineBlockType))
			end

			if defineBlockBType then
				self:_refreshColor(RoomEnum.EffectKey.BlockFloorBKeys[i], self:_getColorIdByBlockType(defineBlockBType))
			end
		end
	end
end

function RoomBlockChangeColorComp:_getColorIdByBlockType(blockType)
	if blockType >= 10000 then
		local colorId = math.floor(blockType / 10000)

		if lua_room_block_color_param.configDict[colorId] then
			return colorId
		end
	end

	return RoomWaterReformModel.InitBlockColor
end

function RoomBlockChangeColorComp:_refreshColor(key, colorId)
	if colorId == RoomWaterReformModel.InitBlockColor and not self._blockColorKeyMap[key] or self._blockColorKeyMap[key] == colorId then
		return
	end

	local list = self.entity.effect:getComponentsByPath(key, RoomEnum.ComponentName.MeshRenderer, "mesh")

	if list and #list > 0 then
		local mpb = self:_getMPBById(colorId)

		self:_setMeshReaderColor(list, mpb)

		self._blockColorKeyMap[key] = colorId
	end
end

function RoomBlockChangeColorComp:_setMeshReaderColor(meshRendererList, mpb)
	if meshRendererList then
		for _, meshRenderer in ipairs(meshRendererList) do
			meshRenderer:SetPropertyBlock(mpb)
		end

		if self.entity:getTag() == SceneTag.RoomInventoryBlock then
			self.entity._scene.inventorymgr:refreshInventoryBlock()
		end
	end
end

local _PropertyBlockCacheMap

function RoomBlockChangeColorComp:_getMPBById(id)
	if not _PropertyBlockCacheMap then
		_PropertyBlockCacheMap = {}

		local cfgList = lua_room_block_color_param.configList
		local MaterialPropertyBlock = UnityEngine.MaterialPropertyBlock

		for _, cfg in ipairs(cfgList) do
			local mpb = MaterialPropertyBlock.New()

			mpb:SetFloat(ShaderIDMap.hue, cfg.hue)
			mpb:SetFloat(ShaderIDMap.saturation, cfg.saturation)
			mpb:SetFloat(ShaderIDMap.brightness, cfg.brightness)
			mpb:SetFloat(ShaderIDMap.enableChangeColor, 1)

			_PropertyBlockCacheMap[cfg.id] = mpb
		end

		if #cfgList > 50 then
			logError("颜色数量超过了 50 ......数量过大")
		end
	end

	return _PropertyBlockCacheMap[id]
end

return RoomBlockChangeColorComp
