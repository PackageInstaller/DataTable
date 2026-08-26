-- chunkname: @modules/logic/summon/model/SummonPoolHistoryTypeListModel.lua

module("modules.logic.summon.model.SummonPoolHistoryTypeListModel", package.seeall)

local SummonPoolHistoryTypeListModel = class("SummonPoolHistoryTypeListModel", ListScrollModel)

function SummonPoolHistoryTypeListModel:initPoolType()
	local moList = {}
	local list = SummonPoolHistoryModel.instance:getHistoryValidPools()
	local creatCount = 0

	for i, cfg in ipairs(list) do
		local mo = self:getById(cfg.id)

		if mo == nil then
			mo = SummonPoolHistoryTypeMO.New()
			creatCount = creatCount + 1

			mo:init(cfg.id, cfg)
		end

		table.insert(moList, mo)
	end

	if creatCount > 0 or self:getCount() ~= #moList then
		self:setList(moList)
		self:onModelUpdate()
	end

	if not self:getById(self._poolTypeId) then
		self._poolTypeId = self:getFirstId()

		self:_refreshSelect()
	end
end

function SummonPoolHistoryTypeListModel:getFirstId()
	local mo = self:getByIndex(1)

	return mo and mo.id
end

function SummonPoolHistoryTypeListModel:_refreshSelect()
	local selectMO = self:getById(self._poolTypeId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function SummonPoolHistoryTypeListModel:setSelectId(poolTypeId)
	self._poolTypeId = poolTypeId

	self:_refreshSelect()
end

function SummonPoolHistoryTypeListModel:getSelectId()
	return self._poolTypeId
end

SummonPoolHistoryTypeListModel.instance = SummonPoolHistoryTypeListModel.New()

return SummonPoolHistoryTypeListModel
