-- chunkname: @modules/logic/room/entity/RoomInventoryBlockEntity.lua

module("modules.logic.room.entity.RoomInventoryBlockEntity", package.seeall)

local RoomInventoryBlockEntity = class("RoomInventoryBlockEntity", RoomBaseBlockEntity)

function RoomInventoryBlockEntity:ctor(ctorParam)
	RoomInventoryBlockEntity.super.ctor(self, ctorParam.entityId)

	self.isWaterReform = ctorParam.isWaterReform
end

function RoomInventoryBlockEntity:getTag()
	return SceneTag.RoomInventoryBlock
end

function RoomInventoryBlockEntity:init(go)
	self._scene = GameSceneMgr.instance:getCurScene()

	RoomInventoryBlockEntity.super.init(self, go)
end

function RoomInventoryBlockEntity:initComponents()
	RoomInventoryBlockEntity.super.initComponents(self)
end

function RoomInventoryBlockEntity:onReviseResParams(tableParam)
	tableParam.layer = UnityLayer.SceneOrthogonalOpaque
	tableParam.batch = false
	tableParam.highlight = false
	tableParam.isInventory = true
end

function RoomInventoryBlockEntity:onEffectRebuild()
	RoomInventoryBlockEntity.super.onEffectRebuild(self)
	self:_refreshLinkGO()
	self._scene.inventorymgr:refreshInventoryBlock()
end

function RoomInventoryBlockEntity:_refreshLinkGO()
	local blockMO = self:getMO()

	if not blockMO then
		return
	end

	local landKey = RoomEnum.EffectKey.BlockLandKey
	local resourceList = blockMO:getResourceList()

	for direction = 1, #resourceList do
		local resourceId = resourceList[direction]

		if RoomResourceEnum.ResourceLinkGOPath[resourceId] and RoomResourceEnum.ResourceLinkGOPath[resourceId][direction] then
			local linkGO = self.effect:getGameObjectByPath(landKey, RoomResourceEnum.ResourceLinkGOPath[resourceId][direction])

			if linkGO then
				gohelper.setActive(linkGO, false)
			end
		end
	end

	local blockType = blockMO:getDefineBlockType()

	if RoomBlockEnum.BlockLinkEffectGOPath[blockType] then
		local linkGO = self.effect:getGameObjectByPath(landKey, RoomBlockEnum.BlockLinkEffectGOPath[blockType])

		if linkGO then
			gohelper.setActive(linkGO, false)
		end
	end

	local nightGOs = self.effect:getGameObjectsByName(landKey, RoomEnum.EntityChildKey.NightLightGOKey)

	if nightGOs then
		for i, tempGO in ipairs(nightGOs) do
			gohelper.setActive(tempGO, false)
		end
	end
end

function RoomInventoryBlockEntity:refreshRotation(tween)
	RoomInventoryBlockEntity.super.refreshRotation(self, tween)
	self._scene.inventorymgr:refreshInventoryBlock()
end

function RoomInventoryBlockEntity:getMO()
	if self.isWaterReform then
		if not self._reformTypeBlockMO then
			local blockCfg
			local blockMO = RoomBlockMO.New()
			local curReformMode = RoomWaterReformModel.instance:getReformMode()

			if curReformMode == RoomEnum.ReformMode.Water then
				local waterType = RoomConfig.instance:getWaterTypeByBlockId(self.id)

				blockCfg = RoomConfig.instance:getWaterReformTypeBlockCfg(waterType)
			else
				local blockColor = RoomConfig.instance:getBlockColorByBlockId(self.id)

				blockCfg = RoomConfig.instance:getBlockColorReformBlockCfg(blockColor)
			end

			blockMO:init(blockCfg)

			blockMO.blockState = RoomBlockEnum.BlockState.WaterReform
			self._reformTypeBlockMO = blockMO
		end

		return self._reformTypeBlockMO
	else
		return RoomInventoryBlockModel.instance:getInventoryBlockMOById(self.id)
	end
end

return RoomInventoryBlockEntity
