-- chunkname: @modules/logic/scene/room/work/RoomSceneCharacterInteractionWork.lua

module("modules.logic.scene.room.work.RoomSceneCharacterInteractionWork", package.seeall)

local RoomSceneCharacterInteractionWork = class("RoomSceneCharacterInteractionWork", BaseWork)

function RoomSceneCharacterInteractionWork:ctor(scene, isChangeMode)
	self._scene = scene
	self._isChangeMode = isChangeMode
end

function RoomSceneCharacterInteractionWork:onStart()
	self:_randomPlaceCharacter()

	if RoomController.instance:isObMode() and not self._isChangeMode then
		self:_getCharacterInteractionInfo()
	else
		self:onDone(true)
		self:startBuilingInteraction()
	end
end

function RoomSceneCharacterInteractionWork:startBuilingInteraction()
	if RoomController.instance:isObMode() then
		RoomInteractionController.instance:refreshCharacterBuilding()
		RoomInteractionController.instance:tryPlaceCharacterInteraction()
	end
end

function RoomSceneCharacterInteractionWork:_getCharacterInteractionInfo()
	RoomRpc.instance:sendGetCharacterInteractionInfoRequest(self._onGetInfo, self)
end

function RoomSceneCharacterInteractionWork:_onGetInfo()
	local interactionCount = RoomModel.instance:getInteractionCount()
	local configList = self:_getConfigList()

	self:_trySetInteracts(configList, interactionCount)
	self:onDone(true)
	self:startBuilingInteraction()
end

function RoomSceneCharacterInteractionWork:_randomPlaceCharacter()
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		RoomCharacterController.instance:checkCharacterMax()

		if self._isChangeMode then
			RoomCharacterController.instance:tryCorrectAllCharacter(false)
		else
			RoomCharacterController.instance:tryCorrectAllCharacter(true)
		end
	end
end

function RoomSceneCharacterInteractionWork.cfgSortFunc(a, b)
	if a.behaviour == b.behaviour and a.heroId == b.heroId and a.behaviour == RoomCharacterEnum.InteractionType.Dialog and a.faithDialog ~= b.faithDialog then
		if a.faithDialog == 0 then
			return false
		elseif b.faithDialog == 0 then
			return true
		else
			return a.faithDialog < b.faithDialog
		end
	end

	if a.id ~= b.id then
		return a.id < b.id
	end
end

function RoomSceneCharacterInteractionWork:_getConfigList()
	local configList = {}
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		tabletool.addValues(configList, RoomConfig.instance:getCharacterInteractionConfigListByHeroId(roomCharacterMO.heroId))
	end

	table.sort(configList, RoomSceneCharacterInteractionWork.cfgSortFunc)

	return configList
end

function RoomSceneCharacterInteractionWork:_trySetInteracts(configList, interactionCount)
	local interactionCountLimit = CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterInteractionLimitCount)

	for i, config in ipairs(configList) do
		if config.behaviour ~= RoomCharacterEnum.InteractionType.Animal and RoomCharacterHelper.checkInteractionValid(config) and (interactionCount < interactionCountLimit or config.excludeDaily or RoomModel.instance:getInteractionState(config.id) == RoomCharacterEnum.InteractionState.Start) then
			local success = self:_trySetInteract(config)

			if success and not config.excludeDaily and RoomModel.instance:getInteractionState(config.id) ~= RoomCharacterEnum.InteractionState.Start then
				interactionCount = interactionCount + 1
			end
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function RoomSceneCharacterInteractionWork:_trySetInteract(config)
	if RoomModel.instance:getInteractionState(config.id) == RoomCharacterEnum.InteractionState.Complete then
		return false
	end

	if not RoomCharacterHelper.interactionIsDialogWithSelect(config.id) and RoomModel.instance:getInteractionState(config.id) == RoomCharacterEnum.InteractionState.Start then
		return false
	end

	if not RoomConditionHelper.isConditionStr(config.conditionStr) then
		return false
	end

	if config.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		return self:_trySetDialogInteract(config)
	elseif config.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- block empty
	end
end

function RoomSceneCharacterInteractionWork:_trySetDialogInteract(config)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.heroId)

	if roomCharacterMO:getCurrentInteractionId() or roomCharacterMO:isTrainSourceState() then
		return false
	end

	if config.relateHeroId ~= 0 then
		local relateRoomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.relateHeroId)

		if relateRoomCharacterMO:getCurrentInteractionId() then
			return false
		end

		local hasCharacterHexPointDict = {}
		local roomCharacterMOList = RoomCharacterModel.instance:getList()

		for i, roomCharacterMO in ipairs(roomCharacterMOList) do
			if roomCharacterMO.heroId ~= config.heroId and roomCharacterMO.heroId ~= config.relateHeroId then
				local hexPoint = roomCharacterMO:getMoveTargetPoint().hexPoint

				hasCharacterHexPointDict[hexPoint.x] = hasCharacterHexPointDict[hexPoint.x] or {}
				hasCharacterHexPointDict[hexPoint.x][hexPoint.y] = true
			end
		end

		local success = false
		local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

		blockMOList = GameUtil.randomTable(tabletool.copy(blockMOList))

		for i, blockMO in ipairs(blockMOList) do
			local hexPoint = blockMO.hexPoint

			if not hasCharacterHexPointDict[hexPoint.x] or not hasCharacterHexPointDict[hexPoint.x][hexPoint.y] then
				success = self:_trySetTwoCharacterInOneBlock(roomCharacterMO, relateRoomCharacterMO, hexPoint)

				if success then
					break
				end
			end
		end

		if not success then
			return false
		end

		relateRoomCharacterMO:setCurrentInteractionId(config.id)
	end

	roomCharacterMO:setCurrentInteractionId(config.id)

	return true
end

function RoomSceneCharacterInteractionWork:_trySetTwoCharacterInOneBlock(roomCharacterMO, relateRoomCharacterMO, hexPoint)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if not blockMO then
		return false
	end

	local heroId = roomCharacterMO.heroId
	local skinId = roomCharacterMO.skinId
	local relateHeroId = relateRoomCharacterMO.heroId
	local relateSkinId = relateRoomCharacterMO.skinId

	for direction = 0, 6 do
		local resourcePoint = ResourcePoint(hexPoint, direction)
		local position = RoomCharacterHelper.getCharacterPosition3D(resourcePoint, false)
		local canConfirm = RoomCharacterHelper.canConfirmPlace(heroId, position, skinId, false)

		if canConfirm then
			for relateDirection = 0, 6 do
				if relateDirection ~= direction then
					local relateResourcePoint = ResourcePoint(hexPoint, relateDirection)
					local relatePosition = RoomCharacterHelper.getCharacterPosition3D(relateResourcePoint, false)
					local relateCanConfirm = RoomCharacterHelper.canConfirmPlace(relateHeroId, relatePosition, relateSkinId, false)

					if relateCanConfirm then
						RoomCharacterController.instance:moveCharacterTo(roomCharacterMO, position, false)
						RoomCharacterController.instance:moveCharacterTo(relateRoomCharacterMO, relatePosition, false)

						return true
					end
				end
			end
		end
	end

	return false
end

function RoomSceneCharacterInteractionWork:clearWork()
	self._scene = nil
end

return RoomSceneCharacterInteractionWork
