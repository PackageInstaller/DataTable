-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipIntensifyTabControl.lua

module("logic.extensions.charactersystem.view.equip.component.EquipIntensifyTabControl", package.seeall)

local M = class("EquipIntensifyTabControl")

function M:ctor()
	self._tabs = {}
	self._tabsAnimation = {}
	self._fun = false
	self._handle = false
	self._tabCheckFunc = false
	self._lastIndex = 1
end

function M:clear()
	for _, tab in ipairs(self._tabs) do
		tab:RemoveListener()
	end

	table.clear(self._tabs)
end

function M:destroy()
	self:clear()

	self._tabs = false
	self._tabsAnimation = false
	self._fun = false
	self._handle = false
	self._tabCheckFunc = false
end

function M:addToggleTab(tab)
	tab:AddListener(self._onTabStateChange, self)
	table.insert(self._tabs, tab)
end

function M:hideToggleTab(index, isShow)
	if self._tabs and self._tabs[index] then
		goutil.setActive(self._tabs[index].gameObject, isShow)
	end
end

function M:getTab(tabIndex)
	local tab = self._tabs[tabIndex]

	return tab
end

function M:setFun(fun, handle, checkFunc)
	self._fun = fun
	self._handle = handle
	self._tabCheckFunc = checkFunc
end

function M:getTabAnimation(tabIndex)
	if not self._tabsAnimation[tabIndex] then
		local tab = self:getTab(tabIndex)

		if tab then
			local animation = goutil.findChildComponent(tab.gameObject, "select", ComponentType.Animation)

			self._tabsAnimation[tabIndex] = animation
		end
	end

	return self._tabsAnimation[tabIndex]
end

function M:activeTabAnimation(tabIndex, active)
	local animation = self:getTabAnimation(tabIndex)

	if animation then
		animation.enabled = active
	end
end

function M:selectTab(tabIndex, notFunCall)
	local tab = self._tabs[tabIndex]

	if not tab then
		if enableErrorLog then
			printError("Tab is nil", tabIndex)
		end

		return
	end

	if not self:_checkCanTurnOn(tabIndex) then
		local activeIndex = self._lastIndex
		local activeTab = self._tabs[activeIndex]

		self:activeTabAnimation(activeIndex, false)

		if activeTab then
			activeTab.IsOn = true
		end

		return
	end

	if tab.IsOn then
		self._lastIndex = tabIndex
		self._notFunCall = false
	else
		self._notFunCall = notFunCall
		tab.IsOn = true
	end
end

function M:_onTabStateChange(tab, isOn)
	if isOn then
		local index = table.indexof(self._tabs, tab)

		if not self:_checkCanTurnOn(index) then
			local activeIndex = self._lastIndex or 1
			local activeTab = self._tabs[activeIndex]

			self:activeTabAnimation(activeIndex, false)

			if activeTab then
				activeTab.IsOn = true
			end

			return
		end

		self:activeTabAnimation(index, true)

		self._lastIndex = index

		if self._fun and not self._notFunCall then
			self._fun(self._handle, index)
		end

		self._notFunCall = false
	end
end

function M:_checkCanTurnOn(index)
	if index == 2 and self._tabCheckFunc and not self._tabCheckFunc(self._handle, true) then
		return false
	end

	return true
end

return M
