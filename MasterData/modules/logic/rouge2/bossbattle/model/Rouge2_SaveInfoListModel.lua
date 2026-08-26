-- chunkname: @modules/logic/rouge2/bossbattle/model/Rouge2_SaveInfoListModel.lua

module("modules.logic.rouge2.bossbattle.model.Rouge2_SaveInfoListModel", package.seeall)

local Rouge2_SaveInfoListModel = class("Rouge2_SaveInfoListModel", ListScrollModel)

function Rouge2_SaveInfoListModel:initList(viewType)
	self._replaceIndex = nil
	self._selectIndex = nil

	self:_buildList(viewType)
end

function Rouge2_SaveInfoListModel:refreshList()
	self:_buildList(self._viewType)
end

function Rouge2_SaveInfoListModel:onSaveInfoDone()
	self:_buildList(Rouge2_OutsideEnum.SaveInfoViewType.EditDone)
end

function Rouge2_SaveInfoListModel:_buildList(viewType)
	self._viewType = viewType or Rouge2_OutsideEnum.SaveInfoViewType.Show

	local moList = {}
	local maxRecordNum = Rouge2_FightRecordController.instance:getMaxRecordNum()

	for i = 1, maxRecordNum do
		local saveInfo = Rouge2_FightRecordController.instance:getSaveInfo(i)
		local saveMo = {
			viewType = self._viewType,
			saveInfo = saveInfo
		}

		table.insert(moList, saveMo)
	end

	self:setList(moList)
end

function Rouge2_SaveInfoListModel:onReadyReplace(index)
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		return
	end

	local saveMo = self:getByIndex(index)

	if not saveMo then
		return
	end

	self._replaceIndex = index

	self:onModelUpdate()
end

function Rouge2_SaveInfoListModel:getReplaceIndex()
	return self._replaceIndex
end

function Rouge2_SaveInfoListModel:getViewType()
	return self._viewType
end

function Rouge2_SaveInfoListModel:markLastSelectIndex(index)
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		return
	end

	self._selectIndex = index
end

function Rouge2_SaveInfoListModel:getLastSelectIndex()
	return self._selectIndex
end

Rouge2_SaveInfoListModel.instance = Rouge2_SaveInfoListModel.New()

return Rouge2_SaveInfoListModel
