-- chunkname: @modules/logic/rouge/model/RougeDLCSelectListModel.lua

module("modules.logic.rouge.model.RougeDLCSelectListModel", package.seeall)

local RougeDLCSelectListModel = class("RougeDLCSelectListModel", MixScrollModel)
local defaultSelectIndex = 1

function RougeDLCSelectListModel:onInit()
	self:_initList()
end

function RougeDLCSelectListModel:_initList()
	local season = RougeOutsideModel.instance:season()
	local dlcList = {}

	self._recordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	for _, dlc in ipairs(lua_rouge_season.configList) do
		if dlc.season == season then
			table.insert(dlcList, dlc)
		end
	end

	self:setList(dlcList)
	self:selectCell(defaultSelectIndex, true)
end

function RougeDLCSelectListModel:updateVersions()
	self:onModelUpdate()
end

function RougeDLCSelectListModel:getCurSelectVersions()
	return self._recordInfo and self._recordInfo:getVersionIds()
end

function RougeDLCSelectListModel:isAddDLC(versionId)
	return self._recordInfo and self._recordInfo:isSelectDLC(versionId)
end

local normalItemHeight = 220
local lastItemHeight = 310

function RougeDLCSelectListModel:getInfoList()
	local mixCellInfos = {}
	local listCount = self:getCount()

	for i = 1, listCount do
		local isLast = listCount <= i

		if isLast then
			if not lastItemHeight then
				local itemHeight = normalItemHeight
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(1, itemHeight, nil)

				table.insert(mixCellInfos, mixCellInfo)
			end
		end
	end

	return mixCellInfos
end

function RougeDLCSelectListModel:selectCell(index)
	local mo = self:getByIndex(index)

	if not mo then
		return
	end

	self._selectIndex = index

	RougeDLCController.instance:dispatchEvent(RougeEvent.OnSelectDLC, mo.id)
end

function RougeDLCSelectListModel:getCurSelectIndex()
	return self._selectIndex or 0
end

RougeDLCSelectListModel.instance = RougeDLCSelectListModel.New()

return RougeDLCSelectListModel
