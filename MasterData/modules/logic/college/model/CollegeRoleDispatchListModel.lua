-- chunkname: @modules/logic/college/model/CollegeRoleDispatchListModel.lua

module("modules.logic.college.model.CollegeRoleDispatchListModel", package.seeall)

local CollegeRoleDispatchListModel = class("CollegeRoleDispatchListModel", CollegeRoleListModel)
local LocationMo, SelectMo

function CollegeRoleDispatchListModel:initList(selectMo, slotIndex, locationMo)
	LocationMo = locationMo or LocationMo
	SelectMo = selectMo or SelectMo
	self._isBatch = false
	self._maxDispatchNum = LocationMo and LocationMo.slotNum
	self._maxDispatchNum = self._maxDispatchNum or 0
	self._slotIndex = slotIndex or self._slotIndex

	local characterBox = CollegeModel.instance:getSceneMo().characterBox
	local characters = {}

	tabletool.addValues(characters, characterBox and characterBox.characters)
	table.sort(characters, self._characterSortFunc)
	self:setList(characters)

	local selectIndex = self:getIndex(SelectMo) or 1

	self:selectCell(selectIndex, true)
end

function CollegeRoleDispatchListModel:refreshList()
	self:onModelUpdate()
end

function CollegeRoleDispatchListModel._characterSortFunc(aRoleMo, bRoleMo)
	if aRoleMo.inLocationStatus ~= bRoleMo.inLocationStatus then
		if aRoleMo.inLocationStatus == LocationMo or bRoleMo.inLocationStatus == LocationMo then
			return aRoleMo.inLocationStatus == LocationMo
		elseif not aRoleMo.inLocationStatus or not bRoleMo.inLocationStatus then
			return bRoleMo.inLocationStatus and bRoleMo.inLocationStatus ~= LocationMo
		end
	elseif aRoleMo.inLocationStatus == LocationMo and bRoleMo.inLocationStatus == LocationMo then
		local aIndex = LocationMo.characterUidIndex[aRoleMo.uid]
		local bIndex = LocationMo.characterUidIndex[bRoleMo.uid]

		if aRoleMo == SelectMo or bRoleMo == SelectMo then
			return aRoleMo == SelectMo
		end

		return aIndex < bIndex
	end

	local isARecommend = CollegeConfig.instance:isAnyEntryTendencyBuilding(aRoleMo.entries, LocationMo.id)
	local isBRecommend = CollegeConfig.instance:isAnyEntryTendencyBuilding(bRoleMo.entries, LocationMo.id)

	if isARecommend ~= isBRecommend then
		return isARecommend
	end

	local aCo = aRoleMo.co
	local bCo = bRoleMo.co

	if aCo then
		if not aCo.rarity then
			local aRarity = 0

			if bCo then
				if not bCo.rarity then
					local bRarity = 0

					if aRarity ~= bRarity then
						return bRarity < aRarity
					end

					local aLevel = aRoleMo.level
					local bLevel = bRoleMo.level

					if aLevel ~= bLevel then
						return bLevel < aLevel
					end

					if aCo then
						if not aCo.id then
							local aId = 0

							if bCo then
								if not bCo.id then
									local bId = 0

									if aId ~= bId then
										return aId < bId
									end

									return aRoleMo.uid < bRoleMo.uid
								end
							end
						end
					end
				end
			end
		end
	end
end

function CollegeRoleDispatchListModel:switchBatch(isBatch)
	if self._isBatch == isBatch then
		return
	end

	self._isBatch = isBatch

	local scrollView = self._scrollViews[1]

	scrollView._param.multiSelect = isBatch

	if self._isBatch then
		self:_onSwitchToBatch()
	else
		self:_onSwitchToSingle()
	end
end

function CollegeRoleDispatchListModel:_onSwitchToBatch()
	local characterUidList = LocationMo.slotCharacterUid

	if not characterUidList then
		return
	end

	local characterBox = CollegeModel.instance:getSceneMo().characterBox
	local characterMoList = {}

	for _, characterUid in ipairs(characterUidList) do
		local characterMo = characterBox:getCharacterMo(characterUid)

		if characterMo then
			table.insert(characterMoList, characterMo)
		end
	end

	self._scrollViews[1]:setSelectList(characterMoList)
end

function CollegeRoleDispatchListModel:_onSwitchToSingle()
	local selectList = self._scrollViews[1]:getSelectList()

	if selectList then
		if not #selectList then
			local selectNum = 0

			if selectNum <= 0 then
				return
			end

			self._scrollViews[1]:setSelect(selectList[selectNum])
		end
	end
end

function CollegeRoleDispatchListModel:getSelectCount()
	local selectList = self._scrollViews[1]:getSelectList()

	return (selectList or nil) and (#selectList or 0)
end

function CollegeRoleDispatchListModel:getMaxDispatchNum()
	return self._maxDispatchNum
end

function CollegeRoleDispatchListModel:isInBatch()
	return self._isBatch
end

function CollegeRoleDispatchListModel:getDispatchUidList()
	local uidList = {}

	if self._scrollViews[1]._param.multiSelect then
		local selectList = self._scrollViews[1]:getSelectList()

		for _, selectMo in ipairs(selectList or {}) do
			table.insert(uidList, selectMo.uid)
		end
	else
		local curSelectMo = self._scrollViews[1]:getFirstSelect()
		local curSelectUid = curSelectMo and curSelectMo.uid
		local slotActorUidList = LocationMo.slotCharacterUid

		for i = 1, LocationMo.slotNum do
			if i == self._slotIndex then
				table.insert(uidList, curSelectUid)
			elseif slotActorUidList[i] and slotActorUidList[i] ~= curSelectUid then
				table.insert(uidList, slotActorUidList[i])
			end
		end
	end

	return uidList
end

function CollegeRoleDispatchListModel:selectCell(index, isSelect)
	local scrollView = self._scrollViews[1]

	if isSelect and scrollView._param.multiSelect then
		local selectList = self._scrollViews[1]:getSelectList()

		if selectList then
			if not #selectList then
				local selectNum = 0

				if selectNum >= self._maxDispatchNum then
					GameFacade.showToast(ToastEnum.CollegeMaxDispatchNum)

					return
				end
			end
		end
	end

	CollegeRoleDispatchListModel.super.selectCell(self, index, isSelect)

	return true
end

function CollegeRoleDispatchListModel:clear()
	LocationMo = nil
	SelectMo = nil

	CollegeRoleDispatchListModel.super.clear(self)
end

CollegeRoleDispatchListModel.instance = CollegeRoleDispatchListModel.New()

return CollegeRoleDispatchListModel
