-- chunkname: @modules/logic/versionactivity1_6/dungeon/model/VersionActivity1_6ScheduleViewListModel.lua

module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6ScheduleViewListModel", package.seeall)

local VersionActivity1_6ScheduleViewListModel = class("VersionActivity1_6ScheduleViewListModel", ListScrollModel)

function VersionActivity1_6ScheduleViewListModel:setStaticData(staticData)
	self._staticData = staticData
end

function VersionActivity1_6ScheduleViewListModel:getStaticData()
	return self._staticData
end

VersionActivity1_6ScheduleViewListModel.instance = VersionActivity1_6ScheduleViewListModel.New()

return VersionActivity1_6ScheduleViewListModel
