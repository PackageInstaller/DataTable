-- chunkname: @modules/logic/room/entity/RoomBaseBlockEntity.lua

module("modules.logic.room.entity.RoomBaseBlockEntity", package.seeall)

local RoomBaseBlockEntity = class("RoomBaseBlockEntity", RoomBaseEntity)

function RoomBaseBlockEntity:ctor(entityId)
	RoomBaseBlockEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
	self._pathfindingEnabled = false
end

function RoomBaseBlockEntity:init(go)
	self.goTrs = go.transform
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.staticContainerGOTrs = self.staticContainerGO.transform

	RoomBaseBlockEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()

	self:refreshLand()
end

function RoomBaseBlockEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
	self:addComp("changeColorComp", RoomBlockChangeColorComp)
end

function RoomBaseBlockEntity:removeParamsAndPlayAnimator(keyList, animName, delayDestroy)
	if delayDestroy then
		for i = 1, #keyList do
			self.effect:playEffectAnimator(keyList[i], animName)
		end
	end

	self.effect:removeParams(keyList, delayDestroy)
end

function RoomBaseBlockEntity:onStart()
	return
end

function RoomBaseBlockEntity:refreshName()
	local mo = self:getMO()

	self.go.name = RoomResHelper.getBlockName(mo.hexPoint)

	if self.resourceui then
		self.resourceui:refreshName()
	end
end

function RoomBaseBlockEntity:refreshLand()
	local mo = self:getMO()
	local defineId = mo:getDefineId()
	local waterType = mo:getDefineWaterType()
	local blockType = mo:getDefineBlockType()
	local showLand = self:checkBlockLandShow(mo) ~= false
	local isNewLand = defineId ~= self._refreshLandLastDefineId or showLand ~= self._lastShowLand or blockType ~= self._lastBlockType
	local isNewRiver = waterType ~= self._lastWaterType

	self._refreshLandLastDefineId = defineId
	self._lastWaterType = waterType
	self._lastShowLand = showLand
	self._lastBlockType = blockType

	if isNewLand then
		local res, ab

		if showLand then
			res = RoomResHelper.getBlockPath(defineId)
			ab = RoomResHelper.getBlockABPath(defineId)
		end

		self:_refreshParams(RoomEnum.EffectKey.BlockLandKey, res, nil, "0", ab)
	end

	if isNewLand or isNewRiver then
		self:_refreshRiver(mo)
	end

	self:_refreshFullRiver(mo)
	self:_refreshWaterGradient(mo)
	self:_refreshEffect()
	self.changeColorComp:refreshLand()
end

function RoomBaseBlockEntity:checkBlockLandShow(pMO)
	return true
end

function RoomBaseBlockEntity:_refreshWaterGradient(mo)
	if not mo or not mo:hasRiver() then
		return
	end

	local golist = self.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey)

	if golist then
		local notInMapBlock = not mo:isInMapBlock()
		local isWaterGradient = notInMapBlock or mo:isWaterGradient()

		for _, tempGO in ipairs(golist) do
			gohelper.setActive(tempGO, isWaterGradient)
		end
	end
end

function RoomBaseBlockEntity:isHasWaterGradient()
	local result = false
	local mo = self:getMO()

	if mo and mo:hasRiver() then
		local golist = self.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey)

		if golist then
			result = #golist > 0
		end
	end

	return result
end

function RoomBaseBlockEntity:_refreshRiver(pMO)
	local mo = pMO or self:getMO()
	local res, riverFloorRes, resAb, riverFloorResAb
	local rotate = 0

	if mo:hasRiver() then
		if not mo:isFullWater() then
			res, rotate, riverFloorRes, resAb, riverFloorResAb = RoomRiverBlockHelper.getRiverBlockTypeByMO(mo)
		end
	elseif mo.blockId > 0 or self.isWaterReform then
		res, resAb = self:_getRiverEffectRes(mo:getDefineBlockType(), self:checkSideShow())
	else
		resAb = RoomScenePreloader.InitLand
		res = RoomScenePreloader.InitLand
	end

	self:_refreshParams(RoomEnum.EffectKey.BlockRiverFloorKey, riverFloorRes, rotate, nil, riverFloorResAb)
	self:_refreshParams(RoomEnum.EffectKey.BlockRiverKey, res, rotate, nil, resAb)
end

function RoomBaseBlockEntity:_refreshFullRiver(pMO)
	local tempMO = pMO or self:getMO()
	local isFullRiver = tempMO:isFullWater()

	if not isFullRiver and not self._isLastFullRiver then
		return
	end

	self._isLastFullRiver = isFullRiver

	local isHalfLakeWater = tempMO:isHalfLakeWater()

	for i = 1, 6 do
		local res, floorRes, floorBRes, resAb, floorResAb, floorBResAb = RoomBlockHelper.getResourcePath(tempMO, i)
		local rotate = i - 1

		self:_refreshParams(RoomEnum.EffectKey.BlockKeys[i], res, rotate, nil, resAb)
		self:_refreshParams(RoomEnum.EffectKey.BlockFloorKeys[i], floorRes, rotate, nil, floorResAb)
		self:_refreshParams(RoomEnum.EffectKey.BlockFloorBKeys[i], floorBRes, rotate, nil, floorBResAb)

		local halfLakeRes

		if string.nilorempty(res) then
			halfLakeRes, resAb = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[RoomRiverEnum.LakeOutLinkType.HalfLake], tempMO:getDefineWaterType())
		end

		self:_refreshParams(RoomEnum.EffectKey.BlockHalfLakeKeys[i], halfLakeRes, rotate, nil, resAb)
	end
end

function RoomBaseBlockEntity:_refreshParams(keyName, res, rotate, deleteChildPath, ab)
	if string.nilorempty(res) then
		if self.effect:isHasKey(keyName) then
			self._riverBlockRemoveParams = self._riverBlockRemoveParams or {}

			table.insert(self._riverBlockRemoveParams, keyName)
		end
	elseif not self.effect:isSameResByKey(keyName, res) then
		self._riverBlockAddParams = self._riverBlockAddParams or {}

		local blockParams = {
			res = res,
			layer = UnityLayer.SceneOpaque,
			pathfinding = self._pathfindingEnabled
		}

		if rotate then
			blockParams.localRotation = Vector3(0, 60 * rotate, 0)
		end

		if deleteChildPath then
			blockParams.deleteChildPath = deleteChildPath
		end

		if not string.nilorempty(ab) then
			blockParams.ab = ab
		end

		self:onReviseResParams(blockParams)

		self._riverBlockAddParams[keyName] = blockParams
	end
end

function RoomBaseBlockEntity:_refreshEffect()
	if self._riverBlockRemoveParams then
		self.effect:removeParams(self._riverBlockRemoveParams)

		self._riverBlockRemoveParams = nil
	end

	if self._riverBlockAddParams then
		self.effect:addParams(self._riverBlockAddParams)

		self._riverBlockAddParams = nil
	end

	self.effect:refreshEffect()
end

function RoomBaseBlockEntity:onReviseResParams(tableParam)
	return
end

function RoomBaseBlockEntity:onEffectRebuild()
	return
end

function RoomBaseBlockEntity:refreshRotation(tween)
	local mo = self:getMO()
	local blockRotate = mo:getRotate()

	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)
	end

	if false then
		self._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(self.containerGOTrs, 0, blockRotate * 60, 0, 0.1, nil, self, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(self.containerGOTrs, 0, blockRotate * 60, 0)
	end
end

function RoomBaseBlockEntity:refreshBlock()
	self:refreshLand()
	self.effect:refreshEffect()
end

function RoomBaseBlockEntity:refreshTempOccupy()
	return
end

function RoomBaseBlockEntity:setLocalPos(x, y, z)
	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomBaseBlockEntity:beforeDestroy()
	self:_returnAnimator()

	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)
	end

	for _, comp in ipairs(self._compList) do
		if comp.beforeDestroy then
			comp:beforeDestroy()
		end
	end
end

function RoomBaseBlockEntity:setBatchEnabled(isEnabled)
	local batchRendererEntityList = self.go:GetComponentsInChildren(typeof(UrpCustom.BatchRendererEntity), true)

	if batchRendererEntityList then
		local list = {}

		RoomHelper.cArrayToLuaTable(batchRendererEntityList, list)

		for i = 1, #list do
			local batchRendererEntity = list[i]

			batchRendererEntity.enabled = isEnabled
		end
	end
end

function RoomBaseBlockEntity:playAnim(animRes, animName)
	self._animator = self._animator or gohelper.onceAddComponent(self.go, typeof(UnityEngine.Animator))
	self._animatorPlayer = self._animatorPlayer or gohelper.onceAddComponent(self.go, typeof(SLFramework.AnimatorPlayer))
	self._animator.runtimeAnimatorController = self._scene.preloader:getResource(animRes)

	self._animatorPlayer:Play(animName, self._returnAnimator, self)
end

function RoomBaseBlockEntity:_returnAnimator()
	if self._animatorPlayer then
		gohelper.removeComponent(self.go, typeof(SLFramework.AnimatorPlayer))

		self._animatorPlayer = nil
	end

	if self._animator then
		gohelper.removeComponent(self.go, typeof(UnityEngine.Animator))

		self._animator = nil
	end
end

function RoomBaseBlockEntity:checkSideShow()
	local mo = self:getMO()

	if not mo then
		return false
	end

	local show = false

	if mo.blockState == RoomBlockEnum.BlockState.Map then
		show = true

		local hexPoint = mo.hexPoint
		local neighbors = hexPoint:getNeighbors()

		for i = 1, 6 do
			local neighbor = HexPoint.directions[i]
			local neighborMO = RoomMapBlockModel.instance:getBlockMO(neighbor.x + hexPoint.x, neighbor.y + hexPoint.y)

			if not neighborMO or neighborMO.blockState ~= RoomBlockEnum.BlockState.Map then
				show = false

				break
			end
		end
	end

	return show
end

function RoomBaseBlockEntity:_getRiverEffectRes(defineBlockType, isReplace)
	return RoomResHelper.getBlockLandPath(defineBlockType, isReplace)
end

function RoomBaseBlockEntity:getMO()
	return
end

function RoomBaseBlockEntity:getMainEffectKey()
	return RoomEnum.EffectKey.BlockLandKey
end

return RoomBaseBlockEntity
