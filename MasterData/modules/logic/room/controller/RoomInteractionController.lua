-- chunkname: @modules/logic/room/controller/RoomInteractionController.lua

module("modules.logic.room.controller.RoomInteractionController", package.seeall)

local RoomInteractionController = class("RoomInteractionController", BaseController)

function RoomInteractionController:onInit()
	self:clear()
end

function RoomInteractionController:reInit()
	self:clear()
end

function RoomInteractionController:clear()
	RoomMapInteractionModel.instance:clear()
end

function RoomInteractionController:init()
	RoomMapInteractionModel.instance:initInteraction()
end

function RoomInteractionController:tickRunInteraction()
	local buildingInteractionMOList = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for i = 1, #buildingInteractionMOList do
		local interactionMO = buildingInteractionMOList[i]

		if interactionMO.hasInteraction and self:showTimeByInteractionMO(interactionMO) then
			break
		end
	end
end

function RoomInteractionController:gainAllCharacterFaith()
	local buildingInteractionMOList = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for i = 1, #buildingInteractionMOList do
		local interactionMO = buildingInteractionMOList[i]

		if interactionMO.hasInteraction and self:showTimeByInteractionMO(interactionMO) then
			interactionMO.hasInteraction = false

			break
		end
	end
end

function RoomInteractionController:showTimeByInteractionMO(interactionMO, showTimeFaithOp)
	local buildingUid, cameraId = interactionMO:getInteractionBuilingUidAndCarmeraId()

	if buildingUid and cameraId then
		interactionMO.hasInteraction = false

		local scene = GameSceneMgr.instance:getCurScene()

		scene.fsm:triggerEvent(RoomSceneEvent.CharacterBuildingShowTime, {
			buildingUid = buildingUid,
			buildingId = interactionMO.config.buildingId,
			heroId = interactionMO.config.heroId,
			id = interactionMO.config.id,
			cameraId = cameraId,
			faithOp = showTimeFaithOp
		})

		return true
	end

	return false
end

function RoomInteractionController:refreshCharacterBuilding()
	local buildingInteractionMOList = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for i = 1, #buildingInteractionMOList do
		local interactionMO = buildingInteractionMOList[i]

		interactionMO.hasInteraction = interactionMO.hasInteraction or interactionMO:isCanByRandom()

		if interactionMO.hasInteraction then
			if not RoomConditionHelper.isConditionStr(interactionMO.config and interactionMO.config.conditionStr) then
				interactionMO.hasInteraction = false
			end
		end
	end
end

function RoomInteractionController:tryPlaceCharacterInteraction()
	local buildingInteractionMOList = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for i = 1, #buildingInteractionMOList do
		local interactionMO = buildingInteractionMOList[i]
		local canInter = false

		if interactionMO.hasInteraction then
			if RoomConditionHelper.isConditionStr(interactionMO.config and interactionMO.config.conditionStr) then
				local nodeList = interactionMO:getBuildingNodeList()
				local buildingUids = interactionMO:getBuildingUids()

				for _, buildingUid in ipairs(buildingUids) do
					local isplace = self:_tryPlaceCharacterById(buildingUid, interactionMO.config.heroId, nodeList)

					if isplace then
						canInter = true

						break
					end
				end
			end
		end

		interactionMO.hasInteraction = canInter
	end
end

function RoomInteractionController:_tryPlaceCharacterById(buildingUid, characterId, nodeList)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(characterId)

	if not roomCharacterMO then
		logNormal(string.format("找不到角色:%s", characterId))

		return nil
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if not scene or not scene.buildingmgr then
		return nil
	end

	local buildingEntity = scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity then
		logNormal(string.format("找不到建筑:%s", buildingUid))

		return
	end

	for i, node in ipairs(nodeList) do
		local pos = buildingEntity:transformPoint(node[1], 0, node[3])
		local posv2 = Vector2.New(pos.x, pos.z)
		local bestParam = RoomCharacterHelper.getRecommendHexPoint(roomCharacterMO.heroId, roomCharacterMO.skinId, posv2)

		if bestParam and bestParam.position then
			pos.y = bestParam.position.y

			if Vector3.Distance(pos, bestParam.position) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				RoomCharacterController.instance:moveCharacterTo(roomCharacterMO, bestParam.position, false)

				if roomCharacterMO:isTraining() then
					scene.crittermgr:delaySetFollow(roomCharacterMO.trainCritterUid, 0.1)
				end

				logNormal(string.format("[%s] 放置:(%s,%s,%s)", roomCharacterMO.heroConfig.name, bestParam.position.x, bestParam.position.y, bestParam.position.z))

				return true
			end
		end
	end
end

function RoomInteractionController:openInteractBuildingView(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO and buildingMO:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomInteractBuildingView)

		self._followBuildingUid = buildingUid

		local interactMO = buildingMO:getInteractMO()

		if interactMO and interactMO.config then
			if not interactMO.config.cameraId then
				local cameraId = 0

				ViewMgr.instance:openView(ViewName.RoomInteractBuildingView, {
					buildingUid = buildingUid
				})
				RoomCameraController.instance:tweenCameraByBuildingUid(buildingUid, RoomEnum.CameraState.InteractBuilding, cameraId, self._cameraInteractFinishCallback, self)

				local roomScene = RoomCameraController.instance:getRoomScene()

				if roomScene then
					::label_11_0::

					local buildingEntity = roomScene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

					if buildingEntity then
						buildingEntity.cameraFollowTargetComp:setFollowGOPath(RoomEnum.EntityChildKey.ThirdPersonCameraGOKey)

						local px, py, pz = buildingEntity.cameraFollowTargetComp:getPositionXYZ()

						roomScene.cameraFollow:setFollowTarget(buildingEntity.cameraFollowTargetComp)
						roomScene.cameraFollow:setIsPass(true, py)
					end
				end
			end
		end
	end
end

function RoomInteractionController:_cameraInteractFinishCallback()
	if self._followBuildingUid == nil then
		return
	end

	local roomScene = RoomCameraController.instance:getRoomScene()
	local buildingUid = self._followBuildingUid

	self._followBuildingUid = nil

	if roomScene and roomScene.camera:getCameraState() == RoomEnum.CameraState.InteractBuilding and ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView) then
		roomScene.cameraFollow:setIsPass(false)
		roomScene.fovblock:setLookBuildingUid(RoomEnum.CameraState.InteractBuilding, buildingUid)
	end
end

RoomInteractionController.instance = RoomInteractionController.New()

return RoomInteractionController
