-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEchoItemFilterView.lua

module("logic.extensions.backpack.view.BackpackEchoItemFilterView", package.seeall)

local M = class("BackpackEchoItemFilterView", ViewComponent)
local FilterEnum = {
	Career = 2,
	Quality = 1
}
local CommonAll = CommEnum.CommonAll
local TabItemStatus = CommEnum.BackPackFilterItemStatus
local _index2qualityType = {
	CommEnum.QualityFilterType.All,
	CommEnum.QualityFilterType.S,
	CommEnum.QualityFilterType.A,
	CommEnum.QualityFilterType.B,
	CommEnum.QualityFilterType.C,
	CommEnum.QualityFilterType.D
}
local _index2CareerType = {
	CommEnum.CareerFilterType.All,
	CommEnum.CareerFilterType.Sentinel,
	CommEnum.CareerFilterType.Assault,
	CommEnum.CareerFilterType.Sniper,
	CommEnum.CareerFilterType.Super,
	CommEnum.CareerFilterType.Heavy,
	CommEnum.CareerFilterType.Cure
}

function M:ctor()
	M.super.ctor(self)

	self._showType = CommEnum.MainBackpackShowType.EchoShowType
end

function M:buildUI()
	self._btnClose = self:getBtn("17&middle_tips_common_bg_-1205189576")
	self._btnReset = self:getBtn("team_filter_tips_204764303")
	self._btnEnsure = self:getBtn("team_filter_tips_1106889858")

	local qualitySortList = self:getGo("team_filter_tips_-1705430043")
	local childList = Astral.GameObjectUtil.GetChildren(qualitySortList)

	self._qualityFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		view:setTextStr(CommEnum.Quality2Name[_index2qualityType[index + 1]])
		table.insert(self._qualityFilterTabViewList, view)
	end

	local careerSortList = self:getGo("backpack_filter_tips_1_-325611417")
	local childList = Astral.GameObjectUtil.GetChildren(careerSortList)

	self._careerFilterTabViewList = {}

	for index = 0, childList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(childList[index], BackpackFilterTabView)

		view:setTextStr(CommEnum.Career2Name[_index2CareerType[index + 1]])
		table.insert(self._careerFilterTabViewList, view)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	for index, view in ipairs(self._qualityFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.Quality, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.Quality, index)
			end
		}

		view:setParam(param)
	end

	for index, view in ipairs(self._careerFilterTabViewList) do
		local param = {
			normalCallback = function()
				self:_onClickNormalTab(FilterEnum.Career, index)
			end,
			selectCallback = function()
				self:_onClickSelectTab(FilterEnum.Career, index)
			end
		}

		view:setParam(param)
	end

	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
end

function M:onEnter()
	local firstParam = self:getFirstParam()

	self._closeCallback = firstParam.closeCallback
	self._filterCfg = firstParam.filterCfg
	self._filterEvent = firstParam.filterEvent

	self:_initData()
	self:_updateTabViewStatus()
end

function M:onExit()
	if self._closeCallback then
		self._closeCallback()
	end
end

function M:_onClickClose()
	self._filterCfg:setQualityFilterType(self._lastQaFilter)
	self._filterCfg:setCareerFilterType(self._lastCaFilter)
	self:back()
end

function M:_onClickReset()
	self._filterCfg:resetFilterViewData()
	self:_updateTabViewStatus()
end

function M:_onClickEnsure()
	GlobalDispatcher:dispatchEvent(self._filterEvent, self._filterCfg)
	self:back()
end

function M:_initData()
	local cfg = self._filterCfg

	self._lastQaFilter = cfg:getQualityFilterType()
	self._lastCaFilter = cfg:getCareerFilterType()
	self._allEchos = ItemModel.instance:getAllDatasByShowType(cfg:getShowType())

	if cfg:getIsDecomposing() then
		local res = {}

		for _, itemData in pairs(self._allEchos) do
			if itemData:getHeroId() == 0 and not itemData:getIsLock() then
				table.insert(res, itemData)
			end
		end

		self._allEchos = res
	end
end

function M:_updateTabViewStatus()
	self:_calQualityFilterInfo()
	self:_updateQualityTabs()
	self:_calCareerFilterInfo()
	self:_updateCareerTabs()
end

function M:_calQualityFilterInfo()
	local qaList = {}
	local qaFlag = {}
	local career = self._filterCfg:getCareerFilterType()

	for _, itemData in ipairs(self._allEchos) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(career, itemData:getCareer()) then
			local qa = itemData:getQuality()

			if not qaFlag[qa] then
				qaFlag[qa] = true

				table.insert(qaList, qa)
			end
		end
	end

	self._qualityFilterMap = MultipleEnumUtil.commEnum2Multiple(qaList)
end

function M:_updateQualityTabs()
	local value = self._filterCfg:getQualityFilterType()

	for index, tabView in ipairs(self._qualityFilterTabViewList) do
		local status = self:_calQaTabStatus(index, value)

		tabView:setTabStatus(status)
	end
end

function M:_calCareerFilterInfo()
	local careerList = {}
	local careerFlag = {}
	local quality = self._filterCfg:getQualityFilterType()

	for _, itemData in ipairs(self._allEchos) do
		if MultipleEnumUtil.multipleEnumContainOnZeroAll(quality, itemData:getQuality()) then
			local career = itemData:getCareer()

			if not careerFlag[career] then
				careerFlag[career] = true

				table.insert(careerList, career)
			end
		end
	end

	self._careerFilterMap = MultipleEnumUtil.commEnum2Multiple(careerList)
end

function M:_updateCareerTabs()
	local value = self._filterCfg:getCareerFilterType()

	for index, tabView in ipairs(self._careerFilterTabViewList) do
		local status = self:_calCaTabStatus(index, value)

		tabView:setTabStatus(status)
	end
end

function M:_onClickNormalTab(filterEnum, index)
	if filterEnum == FilterEnum.Quality then
		local selectKey = _index2qualityType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = self._filterCfg:getQualityFilterType()

			if lastFilter == CommonAll then
				newFilter = self._qualityFilterMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._qualityFilterMap[selectKey])

				if newFilter == self._qualityFilterMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		self._filterCfg:setQualityFilterType(newFilter)
	else
		local selectKey = _index2CareerType[index]
		local newFilter = CommonAll

		if selectKey ~= CommonAll then
			local lastFilter = self._filterCfg:getCareerFilterType()

			if lastFilter == CommonAll then
				newFilter = self._careerFilterMap[selectKey]
			else
				newFilter = MultipleEnumUtil.multipleEnumAdd(lastFilter, self._careerFilterMap[selectKey])

				if newFilter == self._careerFilterMap[CommonAll] then
					newFilter = CommonAll
				end
			end
		end

		self._filterCfg:setCareerFilterType(newFilter)
	end

	self:_updateTabViewStatus()
end

function M:_onClickSelectTab(filterEnum, index)
	if filterEnum == FilterEnum.Quality then
		local selectKey = _index2qualityType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getQualityFilterType()
		local value = self._qualityFilterMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setQualityFilterType(value)
	else
		local selectKey = _index2CareerType[index]

		if selectKey == CommonAll then
			return
		end

		local lastFilter = self._filterCfg:getCareerFilterType()
		local value = self._careerFilterMap[selectKey]

		value = MultipleEnumUtil.multipleEnumSub(lastFilter, value)

		self._filterCfg:setCareerFilterType(value)
	end

	self:_updateTabViewStatus()
end

function M:_calQaTabStatus(index, filterType)
	local indexKey = _index2qualityType[index]
	local tabType = self._qualityFilterMap[indexKey]
	local status = TabItemStatus.Disable

	if tabType then
		if filterType == CommonAll then
			status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
		else
			status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(filterType, tabType) and TabItemStatus.Select or TabItemStatus.Normal
		end
	end

	return status
end

function M:_calCaTabStatus(index, filterType)
	local indexKey = _index2CareerType[index]
	local tabType = self._careerFilterMap[indexKey]
	local status = TabItemStatus.Disable

	if tabType then
		if filterType == CommonAll then
			status = indexKey == CommonAll and TabItemStatus.Select or TabItemStatus.Normal
		else
			status = indexKey == CommonAll and TabItemStatus.Normal or MultipleEnumUtil.multipleEnumContain(filterType, tabType) and TabItemStatus.Select or TabItemStatus.Normal
		end
	end

	return status
end

return M
