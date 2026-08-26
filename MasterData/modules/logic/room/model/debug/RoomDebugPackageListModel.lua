-- chunkname: @modules/logic/room/model/debug/RoomDebugPackageListModel.lua

module("modules.logic.room.model.debug.RoomDebugPackageListModel", package.seeall)

local RoomDebugPackageListModel = class("RoomDebugPackageListModel", ListScrollModel)

function RoomDebugPackageListModel:onInit()
	self:_clearData()
end

function RoomDebugPackageListModel:reInit()
	self:_clearData()
end

function RoomDebugPackageListModel:clear()
	RoomDebugPackageListModel.super.clear(self)
	self:_clearData()
end

function RoomDebugPackageListModel:_clearData()
	self._selectBlockId = nil
	self._filterPackageId = 0
	self._filterMainRes = nil
end

function RoomDebugPackageListModel:setDebugPackageList()
	local moList = {}
	local packageMapConfigs = RoomDebugController.instance:getTempPackageConfig()

	if packageMapConfigs then
		for _, packageMapConfig in ipairs(packageMapConfigs) do
			for _, info in ipairs(packageMapConfig.infos) do
				if self._filterPackageId > 0 and self:isFilterPackageId(info.packageId) and self:isFilterMainRes(info.mainRes) then
					local roomDebugPackageMO = RoomDebugPackageMO.New()

					roomDebugPackageMO:init({
						id = info.blockId,
						packageId = info.packageId,
						packageOrder = info.packageOrder,
						defineId = info.defineId,
						mainRes = info.mainRes
					})
					table.insert(moList, roomDebugPackageMO)
				end
			end
		end
	end

	table.sort(moList, self._sortFunction)
	self:setList(moList)
	self:_refreshSelect()
end

function RoomDebugPackageListModel:getCountByMainRes(mainRes)
	local count = 0
	local packageMapConfigs = RoomDebugController.instance:getTempPackageConfig()

	if packageMapConfigs then
		for _, packageMapConfig in ipairs(packageMapConfigs) do
			for _, info in ipairs(packageMapConfig.infos) do
				if self._filterPackageId > 0 and self:isFilterPackageId(info.packageId) and (mainRes == info.mainRes or (not mainRes or mainRes < 0) and (not info.mainRes or info.mainRes < 0)) then
					count = count + 1
				end
			end
		end
	end

	return count
end

function RoomDebugPackageListModel._sortFunction(x, y)
	if x.packageOrder ~= y.packageOrder then
		return x.packageOrder < y.packageOrder
	end

	return x.id < y.id
end

function RoomDebugPackageListModel:setFilterPackageId(packageId)
	self._filterPackageId = packageId
end

function RoomDebugPackageListModel:isFilterPackageId(packageId)
	return self._filterPackageId == packageId
end

function RoomDebugPackageListModel:getFilterPackageId()
	return self._filterPackageId
end

function RoomDebugPackageListModel:setFilterMainRes(mainRes)
	self._filterMainRes = mainRes
end

function RoomDebugPackageListModel:isFilterMainRes(mainRes)
	return self._filterMainRes == mainRes or not self._filterMainRes and (not mainRes or mainRes == -1)
end

function RoomDebugPackageListModel:getFilterMainRes()
	return self._filterMainRes
end

function RoomDebugPackageListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectBlockId = nil
end

function RoomDebugPackageListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectBlockId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomDebugPackageListModel:setSelect(blockId)
	self._selectBlockId = blockId

	self:_refreshSelect()
end

function RoomDebugPackageListModel:getSelect()
	return self._selectBlockId
end

function RoomDebugPackageListModel:initDebugPackage()
	self:setDebugPackageList()
end

RoomDebugPackageListModel.instance = RoomDebugPackageListModel.New()

return RoomDebugPackageListModel
