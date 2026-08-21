-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackPropFilterPanelView.lua

module("logic.extensions.backpack.view.BackpackPropFilterPanelView", package.seeall)

local M = class("BackpackPropFilterPanelView")
local cfg = {
	[CommEnum.MainBackpackShowType.PropShowType] = {
		index2type = {
			CommEnum.PropFilterType.AllFilterType,
			CommEnum.PropFilterType.BaseFilterType,
			CommEnum.PropFilterType.CultivateFilterType,
			CommEnum.PropFilterType.TacitFilterType
		},
		nameList = CommEnum.PropType2Name
	},
	[CommEnum.MainBackpackShowType.D6ShowType] = {}
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self._mainGo:SetActive(false)
	self:_buildUI()
end

function M:_buildUI()
	self._toggleCompList = {}

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._mainGo)

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index + 1, isOn)
			end
		end, nil)
	end
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	for _, toggleComp in pairs(self._toggleCompList or {}) do
		toggleComp:RemoveListener()
	end

	self._toggleCompList = nil
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:getVisible()
	return self._mainGo.activeSelf
end

function M:_dealToggleClick(index)
	local showType = self._showType
	local filterCfg = self._filterCfg
	local _index2type = cfg[showType].index2type

	filterCfg:setFilterType(_index2type[index])
	GlobalDispatcher:dispatchEvent(self._eventType, filterCfg)
	self:setVisible(false)
end

function M:setToggleIndex()
	local showType = self._showType
	local filterCfg = self._filterCfg
	local _index2type = cfg[showType].index2type
	local index = table.indexof(_index2type, filterCfg:getFilterType())

	filterCfg:setFilterType(_index2type[index])

	self._toggleCompList[index].IsOn = true

	self:setVisible(true)
end

function M:setShowType(showType, filterCfg)
	if not showType or not filterCfg then
		printError("BackpackPropFilterPanelView 缺乏必要数据！")

		return
	end

	self._showType = showType
	self._filterCfg = filterCfg

	local _index2type = cfg[showType].index2type
	local _nameList = cfg[showType].nameList
	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._mainGo)

	for index = 0, toggleGoList.Length - 1 do
		local textTextComp = goutil.findChildTextComponent(toggleGoList[index], "Text")

		textTextComp.text = _nameList[_index2type[index + 1]]
	end

	local index = table.indexof(_index2type, filterCfg:getFilterType())

	self._toggleCompList[index].IsOn = true

	for index = 1, #self._toggleCompList do
		self._toggleCompList[index].gameObject:SetActive(index <= #_index2type)
	end
end

function M:setFilterEventType(eventType)
	self._eventType = eventType
end

return M
