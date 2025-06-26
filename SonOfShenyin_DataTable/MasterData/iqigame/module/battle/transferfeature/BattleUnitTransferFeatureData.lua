-- chunkname: @IQIGame\\Module\\Battle\\TransferFeature\\BattleUnitTransferFeatureData.lua

local SourceDataItem = {
	sourceData = 0,
	sourceType = 0,
	transferResID = 0
}

function SourceDataItem.New(transferResID, sourceType, sourceData)
	local obj = Clone(SourceDataItem)

	obj:__Init(transferResID, sourceType, sourceData)

	return obj
end

function SourceDataItem:__Init(transferResID, sourceType, sourceData)
	self.transferResID = transferResID
	self.sourceType = sourceType
	self.sourceData = sourceData
end

function SourceDataItem:Equal(item)
	if item.sourceType ~= self.sourceType then
		return false
	end

	if item.sourceType == BattleConstant.RendererFeatureSourceType.Manual then
		return item.sourceData.args == self.sourceData.args
	elseif item.sourceType == BattleConstant.RendererFeatureSourceType.Buff then
		return item.sourceData.buffCid == self.sourceData.buffCid
	elseif item.sourceType == BattleConstant.RendererFeatureSourceType.FightStatus then
		return item.sourceData.status == self.sourceData.status
	end

	return false
end

local SourcesData = {
	overlayTransferDic = {}
}

function SourcesData.New()
	local obj = Clone(SourcesData)

	obj:__Init()

	return obj
end

function SourcesData:__Init()
	self.singleTransferList = {}
	self.overlayTransferDic = {}
end

function SourcesData:AddTransfer(transferData)
	local transferConfigData = CfgTransferResourceTable[transferData.transferResID]

	if transferConfigData.SoleFlag then
		self:__AddSingleTransfer(transferData)
	else
		self:__AddOverlayTransfer(transferData)
	end
end

function SourcesData:RemoveTransfer(transferData)
	local transferConfigData = CfgTransferResourceTable[transferData.transferResID]

	if transferConfigData.SoleFlag then
		self:__RemoveSingleTransfer(transferData)
	else
		self:__RemoveOverlayTransfer(transferData)
	end
end

function SourcesData:RemoveTransferByType(sourceType)
	ForArrayTable(self.singleTransferList, function(_index, _transferData)
		if _transferData.sourceType ~= sourceType then
			return
		end

		table.remove(self.singleTransferList, _index)
	end, true)
	ForPairs(self.overlayTransferDic, function(_transferResID, _transferDataArray)
		ForArrayTable(_transferDataArray, function(_index, _transferData)
			if _transferData.sourceType ~= sourceType then
				return
			end

			table.remove(_transferDataArray, _index)
		end, true)
	end)
end

function SourcesData:__AddSingleTransfer(transferData)
	table.insert(self.singleTransferList, transferData)
end

function SourcesData:__RemoveSingleTransfer(transferData)
	local index = 0

	ForArray(self.singleTransferList, function(_index, _transferData)
		if not _transferData:Equal(transferData) then
			return
		end

		index = _index

		return true
	end)

	if index == 0 then
		return
	end

	table.remove(self.singleTransferList, index)
end

function SourcesData:__AddOverlayTransfer(transferData)
	if self.overlayTransferDic[transferData.transferResID] == nil then
		self.overlayTransferDic[transferData.transferResID] = {}
	end

	table.insert(self.overlayTransferDic[transferData.transferResID], transferData)
end

function SourcesData:__RemoveOverlayTransfer(transferData)
	local transferList = self.overlayTransferDic[transferData.transferResID]
	local index = 0

	ForArray(transferList, function(_index, _transferData)
		if not _transferData:Equal(transferData) then
			return
		end

		index = _index

		return true
	end)

	if index == 0 then
		return
	end

	table.remove(self.overlayTransferDic[transferData.transferResID], index)
end

function SourcesData:GetViewData()
	local viewData = {
		singleTransferResID = 0,
		overlayTransferDic = {}
	}

	ForArray(self.singleTransferList, function(_index, _itemData)
		if viewData.singleTransferResID == 0 then
			viewData.singleTransferResID = _itemData.transferResID

			return
		end

		local newTransferResourceData = CfgTransferResourceTable[_itemData.transferResID]
		local curTransferResourceData = CfgTransferResourceTable[viewData.singleTransferResID]

		if newTransferResourceData.Weight < curTransferResourceData.Weight then
			return
		end

		viewData.singleTransferResID = _itemData.transferResID
	end)
	ForPairs(self.overlayTransferDic, function(_transferResID, _transferDataList)
		viewData.overlayTransferDic[_transferResID] = #_transferDataList
	end)

	return viewData
end

local BattleUnitTransferFeatureData = {
	battleUnitID = 0
}

function BattleUnitTransferFeatureData.New(battleUnitID)
	local obj = Clone(BattleUnitTransferFeatureData)

	obj:__Init(battleUnitID)

	return obj
end

function BattleUnitTransferFeatureData:__Init(battleUnitID)
	self.battleUnitID = battleUnitID
	self.sourcesData = SourcesData.New()
	self.viewsData = {
		singleTransferResID = 0,
		overlayTransferDic = {}
	}
end

function BattleUnitTransferFeatureData:Apply(callback)
	local newViewData = self.sourcesData:GetViewData()

	if newViewData.singleTransferResID ~= self.viewsData.singleTransferResID then
		if newViewData.singleTransferResID == 0 then
			callback(false, self.viewsData.singleTransferResID)
		else
			callback(true, newViewData.singleTransferResID)
		end
	end

	ForPairs(newViewData.overlayTransferDic, function(_transferResID, _count)
		local old = self.viewsData.overlayTransferDic[_transferResID]
		local difference = old == nil and _count or _count - old
		local isAdd = difference > 0

		difference = math.abs(difference)

		for i = 1, difference do
			callback(isAdd, _transferResID)
		end

		self.viewsData.overlayTransferDic[_transferResID] = nil
	end)
	ForPairs(self.viewsData.overlayTransferDic, function(_transferResID, _count)
		for i = 1, _count do
			callback(false, _transferResID)
		end
	end)

	self.viewsData = newViewData
end

function BattleUnitTransferFeatureData:AddBuffSourceData(buffData)
	local transferResID = self.__GetTransferResIDByBuff(buffData.cid)

	if transferResID == 0 then
		return
	end

	local userdata = {
		buffCid = buffData.cid
	}
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.Buff, userdata)

	self.sourcesData:AddTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:RemoveBuffSourceData(buffCid)
	local transferResID = self.__GetTransferResIDByBuff(buffCid)

	if transferResID == 0 then
		return
	end

	local userdata = {
		buffCid = buffCid
	}
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.Buff, userdata)

	self.sourcesData:RemoveTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:AddFightStatusSourcesData(status)
	local transferResID = self.__GetTransferResIDByFightStatus(status)

	if transferResID == 0 then
		return
	end

	local userdata = {
		status = status
	}
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.FightStatus, userdata)

	self.sourcesData:AddTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:RemoveFightStatusSourcesData(status)
	local transferResID = self.__GetTransferResIDByFightStatus(status)

	if transferResID == 0 then
		return
	end

	local userdata = {
		status = status
	}
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.FightStatus, userdata)

	self.sourcesData:RemoveTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:AddManualSourceData(transferResID, userdata)
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.Manual, userdata)

	self.sourcesData:AddTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:RemoveManualSourceData(transferResID, userdata)
	local sourcesData = SourceDataItem.New(transferResID, BattleConstant.RendererFeatureSourceType.Manual, userdata)

	self.sourcesData:RemoveTransfer(sourcesData)
end

function BattleUnitTransferFeatureData:RemoveSourceDataByType(sourceType)
	self.sourcesData:RemoveTransferByType(sourceType)
end

function BattleUnitTransferFeatureData.__GetTransferResIDByBuff(buffCid)
	local buffCfg = CfgBuffTable[buffCid]

	if buffCfg == nil then
		return 0
	end

	local id = buffCfg.TransferId[1]

	return id == nil and 0 or id
end

function BattleUnitTransferFeatureData.__GetTransferResIDByFightStatus(status)
	if status == Constant.BattleFightStatus.DIZZY then
		-- block empty
	elseif status == Constant.BattleFightStatus.STEALTH then
		-- block empty
	end

	return 0
end

return BattleUnitTransferFeatureData
