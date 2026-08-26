-- chunkname: @modules/logic/room/model/map/RoomShowBuildingMO.lua

module("modules.logic.room.model.map.RoomShowBuildingMO", package.seeall)

local RoomShowBuildingMO = pureTable("RoomShowBuildingMO")

function RoomShowBuildingMO:init(info)
	self.id = info.id or info.uid
	self.buildingId = info.buildingId or info.defineId
	self.use = info.use
	self.uids = info.uids or {}
	self.levels = info.levels or {}
	self.config = RoomConfig.instance:getBuildingConfig(self.buildingId)
	self.level = info.level or 0
	self.isNeedToBuy = info.isNeedToBuy or false
	self.isBuyNoCost = info.isBuyNoCost or false

	if self.config.canLevelUp then
		local levelConfig = RoomConfig.instance:getLevelGroupConfig(info.buildingId, self.level)

		if levelConfig then
			self.config = RoomHelper.mergeCfg(self.config, levelConfig)
		end
	end
end

function RoomShowBuildingMO:add(buildingUid, level)
	if not tabletool.indexOf(self.uids, buildingUid) then
		table.insert(self.uids, buildingUid)
		table.insert(self.levels, level or 0)
	end
end

function RoomShowBuildingMO:removeUId(buildingUid)
	local index = tabletool.indexOf(self.uids, buildingUid)

	if index then
		table.remove(self.uids, index)
		table.remove(self.levels, index)
	end
end

function RoomShowBuildingMO:getCount()
	return (self.uids or nil) and (#self.uids or 0)
end

function RoomShowBuildingMO:isDecoration()
	return self.config and self.config.buildingType == RoomBuildingEnum.BuildingType.Decoration
end

function RoomShowBuildingMO:getIcon()
	if self.config then
		if self.config.canLevelUp then
			local level = self.levels[1]
			local levelCfg = RoomConfig.instance:getLevelGroupConfig(self.buildingId, level)

			if levelCfg and not string.nilorempty(levelCfg.icon) then
				return levelCfg.icon
			end
		end

		return self.config.icon
	end
end

return RoomShowBuildingMO
