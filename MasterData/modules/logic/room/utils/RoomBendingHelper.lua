-- chunkname: @modules/logic/room/utils/RoomBendingHelper.lua

module("modules.logic.room.utils.RoomBendingHelper", package.seeall)

local RoomBendingHelper = {}

RoomBendingHelper.bendingAmount = 0
RoomBendingHelper.bendingPosition = Vector3(0, 0, 0)
RoomBendingHelper._bendingPosX = 0
RoomBendingHelper._bendingPosY = 0
RoomBendingHelper._bendingPosZ = 0

function RoomBendingHelper.setBendingAmount(bendingAmount)
	RoomBendingHelper.bendingAmount = bendingAmount
end

function RoomBendingHelper.setBendingPosition(bendingPosition)
	RoomBendingHelper.bendingPosition = bendingPosition
	RoomBendingHelper._bendingPosX = bendingPosition.x
	RoomBendingHelper._bendingPosY = bendingPosition.y
	RoomBendingHelper._bendingPosZ = bendingPosition.z
end

function RoomBendingHelper.worldToBendingSimple(worldPos)
	return RoomBendingHelper.worldToBending(worldPos, true)
end

local cacheCameraPos, cachePosFrame
local cacheCameraX, cacheCameraY, cacheCameraZ = 0, 0, 0

function RoomBendingHelper.getCameraPos()
	if not cacheCameraPos or UnityEngine.Time.frameCount ~= cachePosFrame then
		local cameraTrans = CameraMgr.instance:getMainCameraTrs()

		cacheCameraPos = cameraTrans.position
		cachePosFrame = UnityEngine.Time.frameCount
		cacheCameraX, cacheCameraY, cacheCameraZ = cacheCameraPos.x, cacheCameraPos.y, cacheCameraPos.z
	end

	return cacheCameraPos
end

function RoomBendingHelper.getCameraPosXYZ()
	RoomBendingHelper.getCameraPos()

	return cacheCameraX, cacheCameraY, cacheCameraZ
end

local cacheCameraEuler, cacheEulerFrame

function RoomBendingHelper.getCameraEuler()
	if not cacheCameraEuler or UnityEngine.Time.frameCount ~= cacheEulerFrame then
		local cameraTrans = CameraMgr.instance:getMainCameraTrs()

		cacheCameraEuler = cameraTrans.eulerAngles
		cacheEulerFrame = UnityEngine.Time.frameCount
	end

	return cacheCameraEuler
end

function RoomBendingHelper.worldToBending(worldPos, onlyOutPos)
	return RoomBendingHelper.worldXYZToBending(worldPos.x, worldPos.y, worldPos.z, onlyOutPos)
end

function RoomBendingHelper.worldXYZToBending(worldX, worldY, worldZ, onlyOutPos)
	local beX, beY, beZ, roX, roY, roZ, coRoX, coRoY, cRoZ = RoomBendingHelper.worldXYZToBendingXYZ(worldX, worldY, worldZ, onlyOutPos)

	if onlyOutPos then
		return Vector3(beX, beY, beZ)
	end

	local quaternion = Quaternion.New()

	quaternion:SetEuler(roX, roY, roZ)

	return Vector3(beX, beY, beZ), quaternion, Vector3(coRoX, coRoY, cRoZ)
end

function RoomBendingHelper.worldToBendingXYZ(worldPos, onlyOutPos)
	return RoomBendingHelper.worldXYZToBendingXYZ(worldPos.x, worldPos.y, worldPos.z, onlyOutPos)
end

function RoomBendingHelper.worldXYZToBendingXYZ(worldX, worldY, worldZ, onlyOutXYZ)
	local eulerAngles = RoomBendingHelper.getCameraEuler()
	local eulerAngleY = eulerAngles.y
	local bendX, bendY, bendZ = RoomBendingHelper._bendingPosX, RoomBendingHelper._bendingPosY, RoomBendingHelper._bendingPosZ
	local diffX, diffY, diffZ = worldX - bendX, worldY - bendY, worldZ - bendZ
	local toDiffX = diffX * math.cos(Mathf.Deg2Rad * eulerAngleY) - diffZ * math.sin(Mathf.Deg2Rad * eulerAngleY)
	local toDiffZ = diffZ * math.cos(Mathf.Deg2Rad * eulerAngleY) + diffX * math.sin(Mathf.Deg2Rad * eulerAngleY)
	local offsetX = toDiffX * toDiffX * RoomBendingHelper.bendingAmount * 0.08
	local offsetZ = toDiffZ * toDiffZ * RoomBendingHelper.bendingAmount * 0.08
	local offset = offsetX + offsetZ

	if onlyOutXYZ then
		return worldX, worldY - offset, worldZ
	end

	local rotateX = toDiffX == 0 and 0 or Mathf.Rad2Deg * math.atan(offsetX / toDiffX)
	local rotateY = eulerAngleY
	local rotateZ = toDiffZ == 0 and 0 or Mathf.Rad2Deg * math.atan(offsetZ / toDiffZ)

	rotateX = -rotateX

	local cameraX, cameraY, cameraZ = RoomBendingHelper.getCameraPosXYZ()
	local dcameraX, dcameraY, dcameraZ = worldX - cameraX, worldY - cameraY, worldZ - cameraZ
	local diffCameraX = dcameraX * math.cos(Mathf.Deg2Rad * eulerAngleY) - dcameraZ * math.sin(Mathf.Deg2Rad * eulerAngleY)
	local diffCameraZ = dcameraZ * math.cos(Mathf.Deg2Rad * eulerAngleY) + dcameraX * math.sin(Mathf.Deg2Rad * eulerAngleY)
	local angle = diffCameraZ == 0 and 0 or Mathf.Rad2Deg * math.atan(diffCameraX / diffCameraZ)
	local containerRoX, containerRoY, containerRoZ = eulerAngles.x * 0.7, angle * 0.5, 0

	return worldX, worldY - offset, worldZ, rotateX, rotateY, rotateZ, containerRoX, containerRoY, containerRoZ
end

function RoomBendingHelper.bendingToWorld(bendingPos)
	local bendingPosition = RoomBendingHelper.bendingPosition
	local diffPos = bendingPos - bendingPosition
	local offsetZ = diffPos.z * diffPos.z * RoomBendingHelper.bendingAmount * 0.08
	local offsetX = diffPos.x * diffPos.x * RoomBendingHelper.bendingAmount * 0.08

	return Vector3(bendingPos.x, bendingPos.y + offsetZ + offsetX, bendingPos.z)
end

function RoomBendingHelper.screenToWorld(pos)
	local ray = RoomBendingHelper.screenPosToRay(pos)
	local curve = -RoomBendingHelper.bendingAmount * 0.08
	local bendingPosition = RoomBendingHelper.bendingPosition
	local origin = ray.origin

	origin.y = origin.y - 0.1

	local dir = ray.direction

	if dir.y >= 0 then
		return nil
	end

	local diff = origin - bendingPosition
	local eulerAngles = RoomBendingHelper.getCameraEuler()
	local rad = eulerAngles.y * Mathf.Deg2Rad
	local sin_rad = math.sin(rad)
	local cos_rad = math.cos(rad)
	local diff = Vector3(diff.x * cos_rad - diff.z * sin_rad, diff.y, diff.z * cos_rad + diff.x * sin_rad)
	local rotatedDir = Vector3(dir.x * cos_rad - dir.z * sin_rad, dir.y, dir.z * cos_rad + dir.x * sin_rad)
	local dirDistance = rotatedDir.x * rotatedDir.x + rotatedDir.z * rotatedDir.z
	local dirYDCurve = 2 * diff.x * rotatedDir.x + 2 * diff.z * rotatedDir.z - rotatedDir.y / curve
	local originYDCurve = diff.x * diff.x + diff.z * diff.z - diff.y / curve
	local step = 0

	if dirDistance == 0 then
		step = -originYDCurve / dirYDCurve
	else
		local delta = dirYDCurve * dirYDCurve - 4 * dirDistance * originYDCurve

		if delta < 0 then
			return nil
		end

		local sqrtDelta = math.abs(math.sqrt(delta))
		local step1 = (-dirYDCurve + sqrtDelta) / (2 * dirDistance)
		local step2 = (-dirYDCurve - sqrtDelta) / (2 * dirDistance)

		step = math.abs(step1) < math.abs(step2) and step1 or step2
	end

	if step <= 0 then
		return nil
	end

	return (Vector2(origin.x + step * dir.x, origin.z + step * dir.z))
end

function RoomBendingHelper.screenPosToHex(pos)
	local worldPos = RoomBendingHelper.screenToWorld(pos)

	if worldPos then
		return HexMath.positionToRoundHex(worldPos, RoomBlockEnum.BlockSize)
	end
end

function RoomBendingHelper.getRaycastEntity(pos, tempOrRevert)
	local ray = RoomBendingHelper.screenPosToRay(pos)
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()
	local result, hitInfo = UnityEngine.Physics.Raycast(ray.origin, ray.direction, nil, 10, LayerMask.GetMask("SceneOpaque"))

	if not result then
		return nil
	end

	local transform = hitInfo.transform
	local scene = GameSceneMgr.instance:getCurScene()

	for i, buildingMO in ipairs(buildingMOList) do
		if buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map or tempOrRevert and (buildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp or buildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert) then
			local entity = scene.buildingmgr:getBuildingEntity(buildingMO.id, SceneTag.RoomBuilding)

			if entity and transform:IsChildOf(entity.goTrs) then
				return RoomEnum.TouchTab.RoomBuilding, buildingMO.id
			end
		end
	end

	local initBuildingGO = scene.buildingmgr:getInitBuildingGO()

	if initBuildingGO and transform:IsChildOf(initBuildingGO.transform) then
		return RoomEnum.TouchTab.RoomInitBuilding, 0
	end

	for partId, partConfig in ipairs(lua_production_part.configList) do
		local partGO = scene.buildingmgr:getPartContainerGO(partId)

		if partGO and transform:IsChildOf(partGO.transform) then
			return RoomEnum.TouchTab.RoomPartBuilding, partId
		end
	end

	local characterMOList = RoomCharacterModel.instance:getList()

	for i, characterMO in ipairs(characterMOList) do
		if characterMO.characterState == RoomCharacterEnum.CharacterState.Map or tempOrRevert and (characterMO.characterState == RoomCharacterEnum.CharacterState.Temp or characterMO.characterState == RoomCharacterEnum.CharacterState.Revert) then
			local entity = scene.charactermgr:getCharacterEntity(characterMO.id, SceneTag.RoomCharacter)

			if entity and transform:IsChildOf(entity.goTrs) then
				return RoomEnum.TouchTab.RoomCharacter, characterMO.id
			end
		end
	end

	local critterMOList = RoomCritterModel.instance:getAllCritterList()

	for i, critterMO in ipairs(critterMOList) do
		local entity = scene.crittermgr:getCritterEntity(critterMO.id, SceneTag.RoomCharacter)

		entity = entity or scene.buildingcrittermgr:getCritterEntity(critterMO.id, SceneTag.RoomCharacter)

		if entity and transform:IsChildOf(entity.goTrs) then
			return RoomEnum.TouchTab.RoomCritter, critterMO.id
		end
	end

	local buildingTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i = 1, #buildingTypeList do
		local siteType = buildingTypeList[i]
		local entity = scene.sitemgr:getSiteEntity(siteType)

		if entity and transform:IsChildOf(entity.goTrs) then
			return RoomEnum.TouchTab.RoomTransportSite, siteType
		end

		local vehicleUid = RoomMapVehicleModel.instance:getVehicleIdBySiteType(siteType)
		local vehicleEntity = scene.vehiclemgr:getVehicleEntity(vehicleUid)

		if vehicleEntity and transform:IsChildOf(vehicleEntity.goTrs) then
			return RoomEnum.TouchTab.RoomTransportSite, siteType
		end
	end

	return nil
end

function RoomBendingHelper.screenPosToRay(pos)
	local scene = GameSceneMgr.instance:getCurScene()
	local camera = scene.camera.camera

	return (camera:ScreenPointToRay(pos))
end

function RoomBendingHelper.worldPosToAnchorPos(worldPos, planeRectTr, uiCamera, camera3d)
	uiCamera = uiCamera or CameraMgr.instance:getUICamera()
	camera3d = camera3d or CameraMgr.instance:getMainCamera()

	local screenPoint = camera3d:WorldToScreenPoint(worldPos)

	if screenPoint.z < 0 then
		return nil
	else
		local rectPos = Vector2.New(0, 0)
		local result, rectPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(planeRectTr, screenPoint, uiCamera, rectPos)

		if result then
			return rectPos
		else
			return nil
		end
	end
end

return RoomBendingHelper
