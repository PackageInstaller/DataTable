-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/manual/ManualDetailView.lua

module("logic.extensions.controlaction.view.manual.ManualDetailView", package.seeall)

local M = class("ManualDetailView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._itemViewList = false
end

function M:buildUI()
	self._btnReturn = self:getBtn("regulatory_manual_panel_642725275")
	self._txtTitle = self:getText("regulatory_manual_panel_-1943417518")
	self._imgIcon = self:getImage("regulatory_manual_panel_1524960972")
	self._secretGo = self:getGo("regulatory_manual_panel_-134416475")
	self._normalGo = self:getGo("regulatory_manual_panel_130610924")
	self._panelMainGo = self:getGo("regulatory_manual_panel_-2122824068")
	self._panelDetailGo = self:getGo("regulatory_manual_panel_404169966")
	self._progressSubPanelGo = self:getGo("regulatory_manual_panel_-103370840")
	self._resourceSubPanelGo = self:getGo("regulatory_manual_panel_685725892")
	self._tabPanels = {
		self._progressSubPanelGo,
		self._resourceSubPanelGo
	}
	self._resFileView = Astral.LuaComponentContainer.Add(self._resourceSubPanelGo, ManualResFile)
	self._tabGroupGo = self:getGo("regulatory_manual_panel_1872330818")
	self._toggleCompList = {}
	self._toggleGroup = self._tabGroupGo:GetComponent(UIComponentType.SpaceXToggleGroup)
	self._toggleGoList = Astral.GameObjectUtil.GetChildren(self._tabGroupGo)

	for index = 1, self._toggleGoList.Length - 1 do
		Astral.ButtonAdapter.Get(self._toggleGoList[index])

		local toggleComp = self._toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index, isOn)
			end
		end, nil)
	end

	self._progressDoneGo = self:getGo("regulatory_manual_panel_-45831668")
	self._progressContentGo = self:getGo("regulatory_manual_panel_-869572507")
	self._txtProgressDesc = self:getText("regulatory_manual_panel_1048523946")
	self._txtProgress = self:getText("regulatory_manual_panel_-1852740423")
	self._btnControl = self:getBtn("regulatory_manual_panel_-1724183826")
	self._btnControlCanvas = self._btnControl.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._redPointGo = goutil.findChild(self._tabGroupGo, "tab1/red_point")
	self._taskRootGo = self:getGo("regulatory_manual_panel_1651220184")
	self._taskItemGo = self:getGo("regulatory_manual_panel_434189761")

	goutil.addChildToParent(self._taskItemGo, self._taskRootGo.transform.parent.gameObject)
	goutil.setActive(self._taskItemGo, false)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnControl:AddClickListener(self._onClickControl, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MANUAL_ITEMCLICK, self._refresh, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MANUAL_DATA_UPDATE, self._updateState, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnControl:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MANUAL_ITEMCLICK, self._refresh, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MANUAL_DATA_UPDATE, self._updateState, self)
end

function M:onEnter()
	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	goutil.setActive(self._secretGo, isIn)
	goutil.setActive(self._normalGo, not isIn)
end

function M:onExitFinished()
	for i, v in ipairs(self._toggleCompList or {}) do
		v.IsOn = false
	end

	IconLoader.clearSprite(self._imgIcon)

	self._itemViewList = false
end

function M:destroyUI()
	for i, v in ipairs(self._toggleCompList or {}) do
		v:RemoveListener()
	end
end

function M:_dealToggleClick(index)
	for i, v in ipairs(self._tabPanels) do
		goutil.setActive(v, index == i)
	end
end

function M:_setData()
	goutil.setActive(self._redPointGo, ControlActionModel.instance:showManualRedPoint(self._mo.co.code))

	self._txtTitle.text = string.format(lang("tip_controlaction_manual_title"), self._mo.co.name)

	IconLoader.setSprite(self._imgIcon, IconType.ControlActionManual, self._mo.co.icon)

	if not self._mo.data then
		return
	end

	local finishCount = 0

	for i, v in ipairs(self._mo.data:getTasMokList()) do
		if v:canGetReward() then
			finishCount = finishCount + 1
		end
	end

	local groupCo = ControlActionConfig.instance:getMonitorDungeonGroupCfg(self._mo.data:getId())

	self._txtProgressDesc.text = string.format(lang("tip_controlaction_manual_condition"), groupCo.unlockTaskNum)
	self._txtProgress.text = string.format("%s/%s", finishCount, groupCo.unlockTaskNum)

	goutil.setActive(self._progressContentGo, groupCo.isOpenned == 1)
	goutil.setActive(self._btnControl.gameObject, not self._mo.data:isHold())
	goutil.setActive(self._progressDoneGo, self._mo.data:isHold())

	self._btnControlCanvas.alpha = finishCount >= groupCo.unlockTaskNum and 1 or 0.2

	self:_clearChildren(self._taskRootGo)

	self._taskMoList = self._mo.data:getTasMokList()

	if not self._itemViewList then
		self._itemViewList = {}
	end

	printWarn("====#self._coList====", #self._taskMoList)

	for i, v in ipairs(self._taskMoList) do
		local obj = goutil.clone(self._taskItemGo, "taskItem" .. i)

		goutil.setActive(obj, true)
		goutil.addChildToParent(obj, self._taskRootGo)

		local itemView = Astral.LuaComponentContainer.Add(obj, ManualDetailItem)

		itemView:refresh(v, i)
		table.insert(self._itemViewList, itemView)
	end

	self._resFileView:refresh(self._mo)
end

function M:_clearChildren(container)
	local trs = container.transform
	local count = trs.childCount

	for i = count, 2, -1 do
		local child = trs:GetChild(i - 1)

		UnityEngine.GameObject.Destroy(child.gameObject)
	end
end

function M:_enterView(isTrue)
	goutil.setActive(self._panelMainGo, not isTrue)
	goutil.setActive(self._panelDetailGo, isTrue)
end

function M:_refresh(e, mo)
	self:_enterView(true)

	self._mo = mo

	self:_setData()
end

function M:_updateState(e)
	self:_setData()
end

function M:_onClickReturn()
	self:_enterView(false)
end

function M:_onClickControl()
	if self._mo.data:canHold() then
		printWarn("====_onClickControl====")
		ControlActionAgent.instance:sendHoldProtomerRequest(self._mo.data:getId())
	else
		FloatWordMgr.instance:show(lang("tip_controlaction_manual_cannot_control"))
	end
end

return M
