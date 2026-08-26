-- chunkname: @modules/logic/room/view/debug/RoomDebugBuildingCameraView.lua

module("modules.logic.room.view.debug.RoomDebugBuildingCameraView", package.seeall)

local RoomDebugBuildingCameraView = class("RoomDebugBuildingCameraView", BaseView)
local _TCamreaType = {
	CharacterOnly = 4,
	VehicleOnly = 3,
	BuildingCharacter = 1,
	BuildingOnly = 2
}

function RoomDebugBuildingCameraView:onInitView()
	self._inputangle = gohelper.findChildTextMeshInputField(self.viewGO, "container/edit/item/#input_angle")
	self._inputdistance = gohelper.findChildTextMeshInputField(self.viewGO, "container/edit/item2/#input_distance")
	self._inputoffsetHeight = gohelper.findChildTextMeshInputField(self.viewGO, "container/edit/item3/#input_offsetHeight")
	self._goentityPoint = gohelper.findChild(self.viewGO, "container/edit/#go_entityPoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugBuildingCameraView:addEvents()
	self._inputangle:AddOnEndEdit(self._onAngleEndEdit, self)
	self._inputdistance:AddOnEndEdit(self._onDistanceEndEdit, self)
	self._inputoffsetHeight:AddOnEndEdit(self._onOffestHightEndEdit, self)
	self._btnRoomInteraction:AddClickListener(self._btnsaveOnClick, self)
	self._dropRoomInteraction:AddOnValueChanged(self._onRoomInteractionSelectChanged, self)
	self._dropEnityPoint:AddOnValueChanged(self._onEnityPointSelectChanged, self)
end

function RoomDebugBuildingCameraView:removeEvents()
	self._inputangle:RemoveOnEndEdit()
	self._inputdistance:RemoveOnEndEdit()
	self._inputoffsetHeight:RemoveOnEndEdit()
	self._btnRoomInteraction:RemoveClickListener()
	self._dropRoomInteraction:RemoveOnValueChanged()
	self._dropEnityPoint:RemoveOnValueChanged()
end

function RoomDebugBuildingCameraView:_btnsaveOnClick()
	if not self._selectCfg then
		GameFacade.showToast(ToastEnum.IconId, "选择建筑，后方可输出相机参数。")

		return
	end

	if self._selectCfg.cameraType == _TCamreaType.BuildingCharacter then
		self:_logBuildingCharacterCameraParam()
	else
		local param = self:_getBuildingCameraParam()

		if param then
			logNormal(self:_buildingCameraParamToString(param, self._selectCfg.name))
		end
	end
end

function RoomDebugBuildingCameraView:_editableInitView()
	self._dropRoomInteraction = gohelper.findChildDropdown(self.viewGO, "container/edit/roomInteraction/Dropdown")
	self._btnRoomInteraction = gohelper.findChildButtonWithAudio(self.viewGO, "container/edit/roomInteraction/btnOK")
	self._dropEnityPoint = gohelper.findChildDropdown(self._goentityPoint, "Dropdown")
	self._angle = 0
	self._distance = 0
	self._offsetHeight = 0
end

function RoomDebugBuildingCameraView:onUpdateParam()
	return
end

function RoomDebugBuildingCameraView:onOpen()
	if not SLFramework.FrameworkSettings.IsEditor then
		self:closeThis()

		return
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._onCameraTransformUpdate, self)
	self:_initCharacterInteractionSelect()
	self:_initEnityPointSelect()

	local scene = self:_getRoomScene()
	local cameraState = RoomEnum.CameraState.InteractionCharacterBuilding

	scene.camera:switchCameraState(cameraState, scene.camera._cameraParam, nil, self._onCameraDone, self)
	self:_changeCaremerFollow()
end

function RoomDebugBuildingCameraView:onClose()
	return
end

function RoomDebugBuildingCameraView:onDestroyView()
	return
end

function RoomDebugBuildingCameraView:_onAngleEndEdit(inputStr)
	self._angle = tonumber(inputStr)

	self:_updateCameraParam()
	self:refreshUI()
end

function RoomDebugBuildingCameraView:_onDistanceEndEdit(inputStr)
	self._distance = tonumber(inputStr)

	self:_updateCameraParam()
	self:refreshUI()
end

function RoomDebugBuildingCameraView:_onOffestHightEndEdit(inputStr)
	self._offsetHeight = tonumber(inputStr)

	self:_updateCameraParam()
	self:refreshUI()
end

function RoomDebugBuildingCameraView:refreshUI()
	self._inputangle:SetText(tostring(self._angle))
	self._inputdistance:SetText(tostring(self._distance))
	self._inputoffsetHeight:SetText(tostring(self._offsetHeight))
end

function RoomDebugBuildingCameraView:_initCharacterInteractionSelect()
	self._interactionCfgList = {}

	local interStr = {}

	table.insert(interStr, "建筑选择")

	local typeName = {
		[RoomCharacterEnum.InteractionType.Building] = true
	}

	for _, cfg in ipairs(lua_room_character_interaction.configList) do
		if typeName[cfg.behaviour] then
			local buildingMO = self:_getMOByBuildingId(cfg.buildingId)
			local heroCo = HeroConfig.instance:getHeroCO(cfg.heroId)

			if buildingMO and heroCo then
				local nameStr = string.format("%s-%s-%s", buildingMO.config.name, heroCo.name, cfg.id)

				table.insert(interStr, nameStr)
				table.insert(self._interactionCfgList, {
					cameraType = _TCamreaType.BuildingCharacter,
					name = nameStr,
					interactionCfg = cfg,
					buildingUid = buildingMO.buildingUid
				})
			end
		end
	end

	local list = RoomMapBuildingModel.instance:getList()
	local buildingIdDic = {}

	for _, buildingMO in ipairs(list) do
		local bCfg = buildingMO.config

		if bCfg and not buildingIdDic[buildingMO.buildingId] and bCfg.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
			buildingIdDic[buildingMO.buildingId] = true

			local isfollow = bCfg.buildingType == RoomBuildingEnum.BuildingType.Interact
			local nameStr = string.format("%s-%s", bCfg.name, buildingMO.buildingId)

			table.insert(interStr, nameStr)
			table.insert(self._interactionCfgList, {
				cameraType = _TCamreaType.BuildingOnly,
				isFollow = isfollow,
				name = nameStr,
				buildingUid = buildingMO.buildingUid,
				buildingType = bCfg.buildingType
			})
		end
	end

	local vehicleIdDict = {}
	local vehicleList = RoomMapVehicleModel.instance:getList()

	for _, vehicleMO in ipairs(vehicleList) do
		local vCfg = vehicleMO.config

		if vCfg and not vehicleIdDict[vehicleMO.vehicleId] then
			vehicleIdDict[vehicleMO.vehicleId] = vehicleMO.vehicleId

			local nameStr = string.format("%s-%s", vCfg.name, vehicleMO.vehicleId)

			table.insert(interStr, nameStr)
			table.insert(self._interactionCfgList, {
				isFollow = true,
				cameraType = _TCamreaType.VehicleOnly,
				name = nameStr,
				id = vehicleMO.id,
				vehicleUid = vehicleMO.id,
				vehicleId = vehicleMO.vehicleId
			})
		end
	end

	local characterMOList = RoomCharacterModel.instance:getList()

	for _, mo in ipairs(characterMOList) do
		local nameStr = string.format("%s-%s-镜头跟随", mo.heroConfig.name, mo.heroId)

		table.insert(interStr, nameStr)
		table.insert(self._interactionCfgList, {
			isFollow = true,
			cameraType = _TCamreaType.CharacterOnly,
			name = nameStr,
			id = mo.id,
			heroId = mo.heroId
		})
	end

	self._dropRoomInteraction:ClearOptions()
	self._dropRoomInteraction:AddOptions(interStr)
end

function RoomDebugBuildingCameraView:_initEnityPointSelect()
	self._entityPointDataList = {
		{
			name = RoomEnum.EntityChildKey.ThirdPersonCameraGOKey
		},
		{
			isFirstPerson = true,
			name = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
		}
	}

	local nameStrList = {}

	for i, data in ipairs(self._entityPointDataList) do
		table.insert(nameStrList, data.name)
	end

	self._entityPointData = self._entityPointDataList[1]

	self._dropEnityPoint:ClearOptions()
	self._dropEnityPoint:AddOptions(nameStrList)
end

function RoomDebugBuildingCameraView:_logBuildingCharacterCameraParam()
	local buildingEntity, characterEntity = self:_getSelectEntity()

	if not buildingEntity then
		GameFacade.showToast(ToastEnum.IconId, "选择建筑，后方可输出相机参数。")

		return
	end

	local interactionCfg = self._selectCfg.interactionCfg

	if not characterEntity then
		local heroCo = HeroConfig.instance:getHeroCO(interactionCfg.heroId)

		GameFacade.showToast(ToastEnum.IconId, string.format("当前场景没放置【%s】", heroCo and heroCo.name))

		return
	end

	local param = self:_getBuildingCameraParam()

	if not param then
		return
	end

	local str = self:_buildingCameraParamToString(param, self._selectCfg.name)
	local cx, cy, cz = transformhelper.getPos(characterEntity.go.transform)
	local cPos = buildingEntity.containerGOTrs:InverseTransformPoint(cx, cy, cz)

	str = string.format("%s nodesXYZ:%.3f#%s#%0.3f\n", str, cPos.x, 0.11, cPos.z)

	logNormal(str)

	if not string.nilorempty(interactionCfg.buildingAnimState) then
		buildingEntity:playAnimator(interactionCfg.buildingAnimState)
	end

	if characterEntity and not string.nilorempty(interactionCfg.heroAnimState) then
		local arr = string.split(interactionCfg.heroAnimState, "#")

		characterEntity.characterspine:play((arr and #arr > 1 or nil) and (arr[1] or interactionCfg.heroAnimState), false, true)
	end
end

function RoomDebugBuildingCameraView:_buildingCameraParamToString(param, descStr)
	local str = "相机参数：\n"

	if not string.nilorempty(descStr) then
		str = string.format("【%s】%s", descStr, str)
	end

	str = string.format("%s angle:%s#%s\n", str, param.angle, param.angle)
	str = string.format("%s distance:%s#%s\n", str, param.distance, param.distance)
	str = string.format("%s rotate:%.1f\n", str, RoomRotateHelper.getMod(param.rotate, 360))
	str = string.format("%s focusXYZ:%.3f#%s#%.3f\n", str, param.focusX, param.offsetHeight, param.focusZ)

	if not string.nilorempty(param.hangPoint) then
		str = string.format("%s hangPoint:%s\n", str, param.hangPoint)
	end

	return str
end

function RoomDebugBuildingCameraView:_getBuildingCameraParam()
	local buildingEntity = self:_getSelectEntity()

	if not buildingEntity then
		GameFacade.showToast(ToastEnum.IconId, "选择建筑后，方能得到建筑相机参数。")

		return
	end

	local scene = self:_getRoomScene()
	local camera = scene.camera
	local buildingMO = buildingEntity:getMO()
	local buildingRatate = buildingMO.rotate and tonumber(buildingMO.rotate) or 0
	local focusPos = buildingEntity.containerGOTrs:InverseTransformPoint(camera._cameraParam.focusX, 0, camera._cameraParam.focusY)
	local rotate = camera._realCameraParam.rotate * Mathf.Rad2Deg - buildingRatate * 60
	local params = {
		angle = self._angle,
		distance = self._distance,
		offsetHeight = self._offsetHeight,
		rotate = RoomRotateHelper.getMod(rotate, 360),
		focusX = focusPos.x,
		focusZ = focusPos.z
	}

	if self._selectCfg and self._selectCfg.isFollow and self._entityPointData then
		params.hangPoint = self._entityPointData.name
	end

	return params
end

function RoomDebugBuildingCameraView:_applayBuildingCameraParam(param)
	if not param then
		return
	end

	local scene = self:_getRoomScene()
	local buildingEntity = self:_getSelectEntity()

	if not buildingEntity then
		GameFacade.showToast(ToastEnum.IconId, "选择建筑后，设置当前相机参数。")

		return
	end

	if not param.focusX then
		local fx = 0

		if not param.offsetHeight then
			local fy = 0

			if not param.focusZ then
				local fz = 0

				if not param.rotate then
					local rotate = 0

					self._angle = param.angle
					self._distance = param.distance
					self._offsetHeight = param.offsetHeight

					self:_updateCameraParam()

					local foucsPos = buildingEntity:transformPoint(fx, fy, fz)
					local targetRotate = tonumber(rotate) + buildingEntity:getMO().rotate * 60

					targetRotate = RoomRotateHelper.getMod(targetRotate, 360) * Mathf.Deg2Rad

					local cameraState = RoomEnum.CameraState.InteractionCharacterBuilding
					local cameraParam = {
						focusX = foucsPos.x,
						focusY = foucsPos.z,
						zoom = scene.camera:getZoomInitValue(cameraState),
						rotate = targetRotate
					}

					scene.camera:switchCameraState(cameraState, cameraParam, nil, self._applayCameraFinish, self)
				end
			end
		end
	end
end

function RoomDebugBuildingCameraView:_getSelectEntity()
	local scene = self:_getRoomScene()

	if self._selectCfg and scene then
		local cameraType = self._selectCfg.cameraType

		if cameraType == _TCamreaType.BuildingOnly then
			return scene.buildingmgr:getBuildingEntity(self._selectCfg.buildingUid, SceneTag.RoomBuilding)
		elseif cameraType == _TCamreaType.BuildingCharacter then
			local buildingEntity = scene.buildingmgr:getBuildingEntity(self._selectCfg.buildingUid, SceneTag.RoomBuilding)
			local characterEntity = scene.charactermgr:getCharacterEntity(self._selectCfg.interactionCfg.heroId, SceneTag.RoomCharacter)

			return buildingEntity, characterEntity
		elseif cameraType == _TCamreaType.VehicleOnly then
			return scene.vehiclemgr:getVehicleEntity(self._selectCfg.id)
		elseif cameraType == _TCamreaType.CharacterOnly then
			return scene.charactermgr:getCharacterEntity(self._selectCfg.id, SceneTag.RoomCharacter)
		end
	end
end

function RoomDebugBuildingCameraView:_getRoomScene()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return GameSceneMgr.instance:getCurScene()
	end
end

function RoomDebugBuildingCameraView:_applayCameraFinish()
	GameFacade.showToast(ToastEnum.IconId, "设置建筑相机镜头成功")
end

function RoomDebugBuildingCameraView:_getMOByBuildingId(buildingId)
	local list = RoomMapBuildingModel.instance:getList()

	for i, buildingMO in ipairs(list) do
		if buildingMO.buildingId == buildingId then
			return buildingMO
		end
	end
end

function RoomDebugBuildingCameraView:_onRoomInteractionSelectChanged(index)
	if not self._interactionCfgList then
		return
	end

	if index == 0 then
		self._selectCfg = nil
	else
		self._selectCfg = self._interactionCfgList[index]
	end

	self:_changeCaremerFollow()
end

function RoomDebugBuildingCameraView:_onEnityPointSelectChanged(index)
	self._entityPointData = self._entityPointDataList[index + 1]

	self:_changeCaremerFollow()
end

function RoomDebugBuildingCameraView:_changeCaremerFollow()
	local scene = self:_getRoomScene()
	local cameraFollowTargetComp

	self._isCameraFollow = false

	if scene then
		local isFirstPerson = not not (self._entityPointData and self._entityPointData.isFirstPerson)

		if self._selectCfg and self._selectCfg.isFollow then
			local entity = self:_getSelectEntity()

			cameraFollowTargetComp = entity and entity.cameraFollowTargetComp

			if cameraFollowTargetComp then
				self._isCameraFollow = true

				cameraFollowTargetComp:setFollowGOPath(self._entityPointData and self._entityPointData.name)
			end
		end

		scene.cameraFollow:setFollowTarget(cameraFollowTargetComp, isFirstPerson)
	end

	gohelper.setActive(self._goentityPoint, cameraFollowTargetComp ~= nil)
end

function RoomDebugBuildingCameraView:_selectBuilding()
	return
end

function RoomDebugBuildingCameraView:_onCameraDone()
	self:_getCameraParam()
	self:refreshUI()
	self:_updateCameraParam()
end

function RoomDebugBuildingCameraView:_updateCameraParam()
	local scene = self:_getRoomScene()
	local camera = scene.camera

	for stateName, cameraState in pairs(RoomEnum.CameraState) do
		camera._angleMin[cameraState] = self._angle
		camera._angleMax[cameraState] = self._angle
		camera._distanceMin[cameraState] = self._distance
		camera._distanceMax[cameraState] = self._distance
		camera._offsetHeightMap[cameraState] = self._offsetHeight
	end

	self._isWaitUpdate = true

	camera:zoomTo(camera._cameraParam.zoom)
end

function RoomDebugBuildingCameraView:_getCameraParam()
	local scene = self:_getRoomScene()
	local camera = scene.camera

	if camera._realCameraParam then
		self._angle = Mathf.Rad2Deg * (camera._realCameraParam.angle or 0)
		self._distance = camera._realCameraParam.distance or 0
	end

	if camera._cameraState then
		self._offsetHeight = camera._offsetHeightMap[camera._cameraState] or 0
	end
end

function RoomDebugBuildingCameraView:_onCameraTransformUpdate()
	if self._isWaitUpdate then
		self._isWaitUpdate = false
	end

	if self._cameraNotDone or self._isCameraFollow then
		return
	end

	self:_getCameraParam()
	self:refreshUI()
end

return RoomDebugBuildingCameraView
