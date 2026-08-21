-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/ToggleTabControl.lua

module("logic.common.viewlib.tab.ToggleTabControl", package.seeall)

local M = class("ToggleTabControl")

function M:ctor()
	self._tabs = {}
	self._tabsAnimation = {}
	self._viewPager = false
	self._tabCheckFunc = false
	self._viewTmpParams = {}
end

function M:clear()
	for _, tab in ipairs(self._tabs) do
		tab:RemoveListener()
	end

	table.clear(self._tabs)

	self._viewPager = false

	table.clear(self._viewTmpParams)
end

function M:destroy()
	self:clear()

	self._tabs = false
	self._tabsAnimation = false
	self._viewPager = false
	self._tabCheckFunc = false
	self._viewTmpParams = nil
end

function M:setViewPager(viewPager)
	self._viewPager = viewPager
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

function M:_checkCanTurnOn(index)
	if not self:getIsSystemOpen(index) then
		return false
	end

	if self._tabCheckFunc and not self._tabCheckFunc(index) then
		return false
	end

	return true
end

function M:getTab(tabIndex)
	local tab = self._tabs[tabIndex]

	return tab
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

function M:selectTab(tabIndex, ...)
	local tab = self._tabs[tabIndex]

	if not tab then
		if enableErrorLog then
			printError("Tab is nil", tabIndex)
		end

		return
	end

	if not self:_checkCanTurnOn(tabIndex) then
		local activeIndex = self._viewPager._activeIndex
		local activeTab = self._tabs[activeIndex]

		self:activeTabAnimation(activeIndex, false)

		if activeTab then
			activeTab.IsOn = true
		end

		return
	end

	if tab.IsOn then
		self._viewPager:setPage(tabIndex, ...)
	else
		self._viewTmpParams[tabIndex] = ...
		tab.IsOn = true
	end
end

function M:_onTabStateChange(tab, isOn)
	if isOn then
		local index = table.indexof(self._tabs, tab)

		if not self:_checkCanTurnOn(index) then
			local activeIndex = self._viewPager._activeIndex
			local activeTab = self._tabs[activeIndex]

			self:activeTabAnimation(activeIndex, false)

			if activeTab then
				activeTab.IsOn = true
			end

			return
		elseif self._viewPager._activeIndex ~= index then
			self:activeTabAnimation(index, true)
		end

		self._viewPager:setPage(index, self._viewTmpParams[index])

		self._viewTmpParams[index] = nil
	end
end

function M:getIsSystemOpen(tabIndex)
	if self._systemOpenList and self._systemOpenList[tabIndex] then
		local isOpen = SystemOpenFacade.instance:isOpen(self._systemOpenList[tabIndex], true)

		if not isOpen then
			return false
		end
	end

	return true
end

function M:setSystemOpen(systemOpenList)
	if systemOpenList then
		self._systemOpenList = systemOpenList
	end
end

function M:setTabCheckFunc(checkFunc)
	self._tabCheckFunc = checkFunc
end

return M
