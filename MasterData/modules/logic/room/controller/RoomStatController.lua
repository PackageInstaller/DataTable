-- chunkname: @modules/logic/room/controller/RoomStatController.lua

module("modules.logic.room.controller.RoomStatController", package.seeall)

local RoomStatController = class("RoomStatController", BaseController)

function RoomStatController:blockOp(blockIds, isPlace)
	if not blockIds or #blockIds < 1 then
		return
	end

	local plotbas = {}
	local tRoomConfig = RoomConfig.instance

	for i = 1, #blockIds do
		local packageCfg = tRoomConfig:getPackageConfigByBlockId(blockIds[i])

		if packageCfg then
			table.insert(plotbas, packageCfg.name)
		end
	end

	local var_1_0 = StatEnum.EventName.RoomOperatingPlot
	local var_1_1 = {}

	var_1_1[StatEnum.EventProperties.RoomPivotLevel] = RoomModel.instance:getRoomLevel() or 0
	var_1_1[StatEnum.EventProperties.RoomOperationType] = isPlace and luaLang("datatrack_room_place_block") or luaLang("datatrack_room_back_block")
	var_1_1[StatEnum.EventProperties.RoomPlotbag] = plotbas

	StatController.instance:track(var_1_0, var_1_1)
end

function RoomStatController:oneKeyDispatch(isCritter, oneKeyType)
	local type = isCritter and "critter" or "manu"

	StatController.instance:track(StatEnum.EventName.RoomManuAutoDispatch, {
		[StatEnum.EventProperties.RoomDispatchType] = type,
		[StatEnum.EventProperties.RoomDispatchSubType] = oneKeyType
	})
end

function RoomStatController:switchUpdateRecordTime()
	self._switchRecordTime = Time.realtimeSinceStartup
end

function RoomStatController:roomTransportCameraSwitch(isOnePerson, lastPathMO, newPathMO)
	local spendTime = Time.realtimeSinceStartup - self._switchRecordTime
	local roadInfo = self:getRoadInfo(newPathMO)
	local beforeRoadInfo = self:getRoadInfo(lastPathMO)
	local beforeRoadList = {
		beforeRoadInfo
	}
	local roadList = {
		roadInfo
	}

	StatController.instance:track(StatEnum.EventName.RoomTransportCameraSwitch, {
		[StatEnum.EventProperties.IsOnePerson] = isOnePerson,
		[StatEnum.EventProperties.SpendTime] = spendTime,
		[StatEnum.EventProperties.RoadInfoBefore] = beforeRoadList,
		[StatEnum.EventProperties.RoadInfo] = roadList
	})
	self:switchUpdateRecordTime()
end

function RoomStatController:startOpenTransportSiteView()
	self:switchUpdateRecordTime()

	self._openTransportSiteViewTime = Time.realtimeSinceStartup
end

function RoomStatController:closeTransportSiteView(pathMO)
	if not self._openTransportSiteViewTime or not pathMO then
		return
	end

	local spendTime = Time.realtimeSinceStartup - self._openTransportSiteViewTime
	local roadInfo = self:getRoadInfo(pathMO)
	local roadInfoList = {
		roadInfo
	}

	StatController.instance:track(StatEnum.EventName.RoomTransportCameraLeave, {
		[StatEnum.EventProperties.SpendTime] = spendTime,
		[StatEnum.EventProperties.RoadInfo] = roadInfoList
	})

	self._openTransportSiteViewTime = nil
end

function RoomStatController:roomRoadEditView()
	self._openTransportPathViewTime = Time.realtimeSinceStartup

	StatController.instance:track(StatEnum.EventName.RoomRoadEditView)
end

function RoomStatController:roomRoadEditClose()
	if not self._openTransportPathViewTime then
		return
	end

	local spendTime = Time.realtimeSinceStartup - self._openTransportPathViewTime
	local tipList = {}
	local typesList = RoomTransportHelper.getPathBuildingTypesList()

	for _, types in ipairs(typesList) do
		local fromType = types[1]
		local toType = types[2]
		local transportPathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)
		local isLinkFinish = transportPathMO and transportPathMO:isLinkFinish()

		if not isLinkFinish then
			local siteType = RoomTransportHelper.fromTo2SiteType(fromType, toType)
			local langKey = RoomTransportPathEnum.TipLang[siteType]

			table.insert(tipList, langKey)
		end
	end

	local roadInfoList = {}
	local transportPathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for _, pathMO in ipairs(transportPathMOList) do
		local roadInfo = self:getRoadInfo(pathMO)

		table.insert(roadInfoList, roadInfo)
	end

	StatController.instance:track(StatEnum.EventName.RoomRoadEditClose, {
		[StatEnum.EventProperties.SpendTime] = spendTime,
		[StatEnum.EventProperties.TipList] = tipList,
		[StatEnum.EventProperties.RoadInfo] = roadInfoList
	})

	self._openTransportPathViewTime = nil
end

function RoomStatController:getRoadInfo(pathMO)
	if not pathMO then
		return
	end

	local siteType = RoomTransportHelper.fromTo2SiteType(pathMO.fromType, pathMO.toType)

	return {
		id = pathMO.id,
		length = pathMO:getHexPointCount(),
		vehicle = pathMO.buildingId,
		vehicleSkinId = pathMO.buildingSkinId,
		from = pathMO.fromType,
		to = pathMO.toType,
		is_auto = RoomTransportHelper.getIsQuickLink(siteType)
	}
end

function RoomStatController:roomInteractBuildingInvite(buildingId, heroIds)
	local heroList = {}

	tabletool.addValues(heroList, heroIds)
	StatController.instance:track(StatEnum.EventName.RoomInteractBuildingInvite, {
		[StatEnum.EventProperties.BuildingId] = buildingId,
		[StatEnum.EventProperties.HeroList] = heroList
	})
end

function RoomStatController:critterBookBgSwitch(bookId, boolBg)
	StatController.instance:track(StatEnum.EventName.CritterBookBgSwitch, {
		[StatEnum.EventProperties.CritterBookId] = bookId,
		[StatEnum.EventProperties.CritterBookBg] = boolBg
	})
end

RoomStatController.instance = RoomStatController.New()

return RoomStatController
