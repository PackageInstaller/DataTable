-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/statistic/AirWorkStatisticView.lua

module("logic.extensions.airworkshop.flow.defflow.view.statistic.AirWorkStatisticView", package.seeall)

local M = class("AirWorkStatisticView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("6&middle_tips_common_bg_-1205189576")
	self._btnBg = self:getBtn("6&middle_tips_common_bg_-1572128605")

	local panel1 = self:getGo("air_workshop_statistics_tips_-1646385346")
	local panel2 = self:getGo("air_workshop_statistics_tips_-154730658")
	local panel3 = self:getGo("air_workshop_statistics_tips_-753039020")

	self._panels = {
		panel1,
		panel2,
		panel3
	}
	self._toggleGroupGo = self:getGo("8&left_tab_list_-1655680316")
	self._tabGo = self:getGo("8&0&left_tab_list_item_-51389005")

	goutil.setActive(self._tabGo, false)
	goutil.clearChildren(self._toggleGroupGo)

	for i, v in ipairs({
		{
			name = lang("tip_air_workshop_statistic_pass")
		},
		{
			name = lang("tip_air_workshop_statistic_kill")
		},
		{
			name = lang("tip_air_workshop_statistic_die")
		}
	}) do
		local tabGo = goutil.cloneAndSetParent(self._tabGo, self._toggleGroupGo.transform, "tab" .. i)
		local txtTabName = goutil.findChildTextComponent(tabGo, "normal/layout/txtTitle")
		local txtTabName2 = goutil.findChildTextComponent(tabGo, "select/layout/txtTitle")

		txtTabName.text = v.name
		txtTabName2.text = v.name

		goutil.setActive(tabGo, true)
	end

	self._toggleCompList = {}
	self._toggleGroup = self._toggleGroupGo:GetComponent(UIComponentType.SpaceXToggleGroup)
	self._toggleGoList = Astral.GameObjectUtil.GetChildren(self._toggleGroupGo)

	for index = 0, self._toggleGoList.Length - 1 do
		Astral.ButtonAdapter.Get(self._toggleGoList[index])

		local toggleComp = self._toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)

	for i, v in ipairs(self._toggleCompList or {}) do
		v:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(i, isOn)
			end
		end, nil)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()

	for i, v in ipairs(self._toggleCompList or {}) do
		v:RemoveListener()
	end
end

function M:onEnter()
	self:_addEvents(true)

	self._toggleCompList[1].IsOn = true

	local param = self:getFirstParam()
	local showCount = param.showTabCount

	for i = 1, self._toggleGroupGo.transform.childCount do
		local childGo = self._toggleGroupGo.transform:GetChild(i - 1).gameObject

		goutil.setActive(childGo, i <= showCount)
	end

	self._mapId = param.mapId
	self._statisticsMo = AirWorkShopStatisticsModel.instance:getMapData(param.mapId)

	AirWorkShopDefAgent.instance:sendGetAirMapStatisticsRequest(param.mapId)
end

function M:onExitFinished()
	self:_addEvents(false)

	for i, v in ipairs(self._toggleCompList or {}) do
		v.IsOn = false
	end
end

function M:destroyUI()
	return
end

function M:_addEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, self._refresh, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_BATTLE_STATISTICS_REPLY, self._refresh, self)
	end
end

function M:_refresh(e, params)
	printWarn("====_refresh==== mapId= ", params, self._mapId)

	self._statisticsMo = AirWorkShopStatisticsModel.instance:getMapData(self._mapId)

	self:_dealToggleClick(1)
end

function M:_getData(index)
	if not self._statisticsMo then
		return
	end

	local data = {}

	if index == 1 then
		data = self._statisticsMo:getAttackDataLst()
	elseif index == 2 then
		local defData = self._statisticsMo:getDefDataLst()

		for i, v in ipairs(defData) do
			local killMo = {}

			killMo.heroId = v.heroId
			killMo.killList = v.kill

			if #killMo.killList > 0 then
				table.insert(data, killMo)
			end
		end
	else
		local defData = self._statisticsMo:getDefDataLst()

		for i, v in ipairs(defData) do
			local beKillMo = {}

			beKillMo.heroId = v.heroId
			beKillMo.beKillList = v.beKill

			if #beKillMo.beKillList > 0 then
				table.insert(data, beKillMo)
			end
		end
	end

	return data
end

function M:_dealToggleClick(index)
	printWarn("====click toggle index====", index)

	for i, v in ipairs(self._panels) do
		goutil.setActive(v, index == i)
	end

	local data = self:_getData(index)
	local panelView = Astral.LuaComponentContainer.Add(self._panels[index], AirWorkStatisticPanel)

	panelView:onEnter(data, index)
end

function M:_onClickClose()
	self:close()
end

return M
