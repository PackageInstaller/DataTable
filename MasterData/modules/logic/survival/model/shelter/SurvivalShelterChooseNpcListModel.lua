-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterChooseNpcListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterChooseNpcListModel", package.seeall)

local SurvivalShelterChooseNpcListModel = class("SurvivalShelterChooseNpcListModel", ListScrollModel)

function SurvivalShelterChooseNpcListModel:isQuickSelect()
	return self._isQuickSelect
end

function SurvivalShelterChooseNpcListModel:changeQuickSelect()
	self._isQuickSelect = not self._isQuickSelect
end

function SurvivalShelterChooseNpcListModel:setSelectPos(pos)
	if self._selectPos == pos then
		return false
	end

	self._selectPos = pos

	return true
end

function SurvivalShelterChooseNpcListModel:setSelectNpcToPos(npcId, pos)
	pos = pos ~= nil and pos or self._selectPos

	if pos == nil then
		return
	end

	if self._pos2NpcId == nil then
		self._pos2NpcId = {}
	end

	self._pos2NpcId[pos] = npcId

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

function SurvivalShelterChooseNpcListModel:getSelectNpcByPos(posIndex)
	if posIndex == nil or self._pos2NpcId == nil then
		return nil
	end

	return self._pos2NpcId[posIndex]
end

function SurvivalShelterChooseNpcListModel:getAllSelectPosNpc()
	local list = {}

	if self._pos2NpcId then
		for _, npcId in pairs(self._pos2NpcId) do
			table.insert(list, npcId)
		end
	end

	return list
end

function SurvivalShelterChooseNpcListModel:npcIdIsSelect(npcId)
	if self._pos2NpcId ~= nil then
		for i, v in pairs(self._pos2NpcId) do
			if npcId == v then
				return i
			end
		end
	end

	return nil
end

function SurvivalShelterChooseNpcListModel:getSelectPos()
	return self._selectPos
end

function SurvivalShelterChooseNpcListModel:getNextCanSelectPosIndex()
	if self._pos2NpcId == nil then
		return nil
	end

	for i = 1, 3 do
		if self._pos2NpcId[i] == nil then
			return i
		end
	end

	return nil
end

function SurvivalShelterChooseNpcListModel:setSelectNpc(npcId)
	self.selectNpcId = self.selectNpcId == npcId and 0 or npcId

	return true
end

function SurvivalShelterChooseNpcListModel:getSelectNpc()
	return self.selectNpcId
end

function SurvivalShelterChooseNpcListModel:clearSelectList()
	if self._npcList ~= nil then
		tabletool.clear(self._npcList)
	else
		self._npcList = {}
	end
end

function SurvivalShelterChooseNpcListModel:setNeedSelectNpcList(npcIds)
	self.selectNpcId = nil
	self._pos2NpcId = nil
	self._isQuickSelect = false
	self._selectPos = nil

	if npcIds == nil then
		return
	end

	self:clearSelectList()

	for i = 1, #npcIds do
		local npcId = npcIds[i]
		local config = SurvivalConfig.instance:getNpcConfig(npcId)

		if config.subType ~= SurvivalEnum.NpcSubType.Story then
			local npcMo = SurvivalShelterNpcMo.New()

			npcMo:init({
				id = npcId
			})
			table.insert(self._npcList, npcMo)
		end
	end
end

function SurvivalShelterChooseNpcListModel:getShowList()
	return self._npcList or {}
end

function SurvivalShelterChooseNpcListModel:filterNpc(filterList, npcMo)
	if not filterList or not next(filterList) then
		return true
	end

	local list = SurvivalConfig.instance:getNpcConfigTag(npcMo.id)
	local dict = {}

	for i, v in ipairs(list) do
		local tagConfig = lua_survival_tag.configDict[v]

		if tagConfig then
			dict[tagConfig.tagType] = true
		end
	end

	for k, v in pairs(filterList) do
		if dict[v.type] then
			return true
		end
	end
end

function SurvivalShelterChooseNpcListModel.sort(a, b)
	local rareA = a.co.rare
	local rareB = b.co.rare

	if rareA ~= rareB then
		return rareB < rareA
	end

	return a.id < b.id
end

function SurvivalShelterChooseNpcListModel:refreshNpcList(filterList)
	local list = {}

	if self._npcList then
		for i = 1, #self._npcList do
			local npcMo = self._npcList[i]

			if self:filterNpc(filterList, npcMo) then
				table.insert(list, npcMo)
			end
		end
	end

	if #list > 1 then
		table.sort(list, self.sort)
	end

	self:setList(list)
end

local maxSelectCount = 3

function SurvivalShelterChooseNpcListModel:quickSelectNpc(npcId)
	local canSelect = true

	for i = 1, maxSelectCount do
		if self._pos2NpcId and self._pos2NpcId[i] == npcId then
			self:setSelectNpcToPos(nil, i)
			self:setSelectNpc(npcId)

			canSelect = false
		end
	end

	if canSelect then
		local index = 1

		for i = 1, maxSelectCount do
			if self._pos2NpcId == nil or self._pos2NpcId[i] == nil then
				index = i

				break
			end
		end

		if self._pos2NpcId == nil or self._pos2NpcId[index] == nil then
			self:setSelectNpcToPos(npcId, index)
			self:setSelectNpc(npcId)
		end
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

SurvivalShelterChooseNpcListModel.instance = SurvivalShelterChooseNpcListModel.New()

return SurvivalShelterChooseNpcListModel
