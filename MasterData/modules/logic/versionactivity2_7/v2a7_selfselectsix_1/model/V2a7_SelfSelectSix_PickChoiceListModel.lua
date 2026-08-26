-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/model/V2a7_SelfSelectSix_PickChoiceListModel.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.model.V2a7_SelfSelectSix_PickChoiceListModel", package.seeall)

local V2a7_SelfSelectSix_PickChoiceListModel = class("V2a7_SelfSelectSix_PickChoiceListModel", MixScrollModel)

function V2a7_SelfSelectSix_PickChoiceListModel:onInit()
	self._selectIdList = {}
	self._selectIdMap = {}
	self._pickChoiceMap = {}
	self.maxSelectCount = nil
	self._lastUnLock = nil
	self._lastUnlockEpisodeId = nil
	self._allPass = false
	self._arrcount = 0
end

function V2a7_SelfSelectSix_PickChoiceListModel:reInit()
	self:onInit()
end

function V2a7_SelfSelectSix_PickChoiceListModel:initData(effectArr, maxSelectCount)
	self:onInit()
	self:initList(effectArr)

	self.maxSelectCount = maxSelectCount or 1
end

function V2a7_SelfSelectSix_PickChoiceListModel:initList(effectArr)
	if not effectArr then
		return
	end

	local moList = {}

	self._arrcount = #effectArr

	local allPass = true

	for index, value in ipairs(effectArr) do
		local mo = {}
		local temp = string.split(value, ":")
		local heroIdList = {}

		if temp[2] and #temp[2] > 0 then
			heroIdList = string.splitToNumber(temp[2], ",")
			self._pickChoiceMap[tonumber(temp[1])] = heroIdList
		end

		mo.episodeId = tonumber(temp[1])
		mo.heroIdList = heroIdList

		local isUnlock = DungeonModel.instance:hasPassLevel(mo.episodeId)

		mo.isUnlock = isUnlock

		if isUnlock then
			self._lastUnLock = index
		else
			allPass = false
		end

		if not isUnlock and not self._lastUnlockEpisodeId then
			self._lastUnlockEpisodeId = mo.episodeId
		end

		if index == #effectArr and allPass then
			self._lastUnlockEpisodeId = mo.episodeId
		end

		table.insert(moList, {
			isTitle = true,
			episodeId = mo.episodeId,
			isUnlock = isUnlock
		})
		table.insert(moList, mo)

		self._allPass = allPass
	end

	self:setList(moList)
end

function V2a7_SelfSelectSix_PickChoiceListModel:getLastUnlockIndex()
	return self._lastUnLock
end

function V2a7_SelfSelectSix_PickChoiceListModel:getLastUnlockEpisodeId()
	return self._lastUnlockEpisodeId, self._allPass
end

function V2a7_SelfSelectSix_PickChoiceListModel:getArrCount()
	return self._arrcount
end

function V2a7_SelfSelectSix_PickChoiceListModel:setSelectId(heroId)
	if not self._selectIdList then
		return
	end

	if self._selectIdMap[heroId] then
		self._selectIdMap[heroId] = nil

		tabletool.removeValue(self._selectIdList, heroId)
	else
		self._selectIdMap[heroId] = true

		table.insert(self._selectIdList, heroId)
	end
end

function V2a7_SelfSelectSix_PickChoiceListModel:clearAllSelect()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function V2a7_SelfSelectSix_PickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function V2a7_SelfSelectSix_PickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function V2a7_SelfSelectSix_PickChoiceListModel:getMaxSelectCount()
	return self.maxSelectCount
end

function V2a7_SelfSelectSix_PickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

function V2a7_SelfSelectSix_PickChoiceListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local isTitle = mo.isTitle
		local type = isTitle and 0 or 1
		local lineWidth = isTitle and 66 or 200
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineWidth, nil)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

V2a7_SelfSelectSix_PickChoiceListModel.instance = V2a7_SelfSelectSix_PickChoiceListModel.New()

return V2a7_SelfSelectSix_PickChoiceListModel
