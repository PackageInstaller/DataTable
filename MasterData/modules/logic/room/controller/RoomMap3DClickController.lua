-- chunkname: @modules/logic/room/controller/RoomMap3DClickController.lua

module("modules.logic.room.controller.RoomMap3DClickController", package.seeall)

local RoomMap3DClickController = class("RoomMap3DClickController", BaseController)

function RoomMap3DClickController:onInit()
	return
end

function RoomMap3DClickController:reInit()
	return
end

function RoomMap3DClickController:clear()
	return
end

function RoomMap3DClickController:onTransportSiteClick(siteType)
	local ftype, ttype = RoomTransportHelper.getSiteFromToByType(siteType)

	if ftype and ttype then
		RoomTransportController.instance:openTransportSiteView(siteType)
	end
end

function RoomMap3DClickController:onCritterEntityClick(roomCritterMO)
	if not roomCritterMO then
		return
	end

	local critterMO = CritterModel.instance:getCritterMOByUid(roomCritterMO.id)

	if not critterMO then
		return
	end

	if critterMO:isCultivating() then
		if critterMO.trainInfo:isHasEventTrigger() then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, critterMO.id)
		else
			local scene = RoomCameraController.instance:getRoomScene()

			if scene then
				local critterEntity = scene.crittermgr:getCritterEntity(critterMO.id, SceneTag.RoomCharacter)

				if critterEntity then
					critterEntity.critterspine:touch(true)
				end

				local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(roomCritterMO.heroId)

				if roomCharacterMO then
					roomCharacterMO:setLockTime(10)
				end

				local characterEntity = scene.charactermgr:getCharacterEntity(roomCritterMO.heroId, SceneTag.RoomCharacter)

				if characterEntity then
					characterEntity.characterspine:play(RoomCharacterEnum.CharacterAnimStateName.Idle)
				end
			end
		end
	elseif critterMO.workInfo.workBuildingUid and critterMO.workInfo.workBuildingUid ~= 0 then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(critterMO.workInfo.workBuildingUid)

		self:onBuildingEntityClick(buildingMO)
	end
end

function RoomMap3DClickController:onBuildingEntityClick(buildingMO)
	if not buildingMO or not buildingMO.config then
		return
	end

	local clickFunc = self:_getBuildingTypeClickFunc(buildingMO.config.buildingType)

	if clickFunc then
		clickFunc(self, buildingMO)
	else
		logWarn("建筑[%s] buildingType:%s 没点击处理function", buildingMO.config.name or buildingMO.buildingId, buildingMO.config.buildingTyp or "nil")
	end
end

function RoomMap3DClickController:_getBuildingTypeClickFunc(buildingType)
	self._buildingTypeClickFuncDict = self._buildingTypeClickFuncDict or {
		[RoomBuildingEnum.BuildingType.Collect] = self._onManufactureBuildingClick,
		[RoomBuildingEnum.BuildingType.Process] = self._onManufactureBuildingClick,
		[RoomBuildingEnum.BuildingType.Manufacture] = self._onManufactureBuildingClick,
		[RoomBuildingEnum.BuildingType.Trade] = self._onTradeBuildingClick,
		[RoomBuildingEnum.BuildingType.Rest] = self._onRestBuildingClick,
		[RoomBuildingEnum.BuildingType.Interact] = self._onInteractBuildingClick
	}

	return self._buildingTypeClickFuncDict[buildingType]
end

function RoomMap3DClickController:_onManufactureBuildingClick(buildingMO)
	local canOpenView = RoomController.instance:isObMode()
	local buildingId = buildingMO.buildingId

	canOpenView = canOpenView and ManufactureConfig.instance:isManufactureBuilding(buildingId)
	canOpenView = canOpenView and not RoomBuildingController.instance:isBuildingListShow()
	canOpenView = canOpenView and not RoomCharacterController.instance:isCharacterListShow()

	if not canOpenView then
		return
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(buildingMO)
end

function RoomMap3DClickController:_onTradeBuildingClick(buildingMO)
	ManufactureController.instance:openRoomTradeView(buildingMO.buildingUid)
end

function RoomMap3DClickController:_onRestBuildingClick(buildingMO)
	local canOpenView = RoomController.instance:isObMode()
	local buildingId = buildingMO.buildingId
	local buildingType = RoomConfig.instance:getBuildingType(buildingId)

	canOpenView = canOpenView and buildingType == RoomBuildingEnum.BuildingType.Rest
	canOpenView = canOpenView and not RoomBuildingController.instance:isBuildingListShow()
	canOpenView = canOpenView and not RoomCharacterController.instance:isCharacterListShow()

	if not canOpenView then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	ManufactureController.instance:openCritterBuildingView(buildingMO.buildingUid)
end

function RoomMap3DClickController:_onInteractBuildingClick(buildingMO)
	RoomInteractionController.instance:openInteractBuildingView(buildingMO.buildingUid)
end

RoomMap3DClickController.instance = RoomMap3DClickController.New()

return RoomMap3DClickController
