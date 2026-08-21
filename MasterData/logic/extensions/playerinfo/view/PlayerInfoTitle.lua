-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoTitle.lua

module("logic.extensions.playerinfo.view.PlayerInfoTitle", package.seeall)

local M = class("PlayerInfoTitle")

function M:ctor(gameObject)
	self.mainGO = gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)

	self:_buildUI()
end

function M:_buildUI()
	self._tabLstRoot = self.mainGO
	self._tabLst = {}

	table.insert(self._tabLst, self:_buildTab(goutil.findChild(self.mainGO, "tab1")))
	table.insert(self._tabLst, self:_buildTab(goutil.findChild(self.mainGO, "tab2")))
	table.insert(self._tabLst, self:_buildTab(goutil.findChild(self.mainGO, "tab3")))
	table.insert(self._tabLst, self:_buildTab(goutil.findChild(self.mainGO, "tab4")))
	table.insert(self._tabLst, self:_buildTab(goutil.findChild(self.mainGO, "tab5")))
end

function M:destroyUI()
	self._tabLstRoot = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self.mainGO = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:_buildTab(tabGo)
	local tabInfo = {}

	tabInfo.toggleTab = tabGo:GetComponent(UIComponentType.SpaceXToggle)
	tabInfo.txt1 = goutil.findChildTextComponent(tabGo, "normal/Text")
	tabInfo.txt2 = goutil.findChildTextComponent(tabGo, "select/Text")
	tabInfo.txt3 = goutil.findChildTextComponent(tabGo, "normal/Text (1)")
	tabInfo.lock = goutil.findChild(tabGo, "normal/lock")

	return tabInfo
end

function M:getTabsCount()
	return #self._tabLst
end

function M:getTabComps(index)
	local comps = self._tabLst[index]

	if not comps then
		printError(string.format("不存在index = [%s]的tab", index))
	end

	return comps
end

function M:getToggleTab(index)
	local comps = self:getTabComps(index)

	if comps then
		return comps.toggleTab
	end

	return nil
end

function M:setTabShow(index, show)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.toggleTab.gameObject, show)
	end
end

function M:setTabName(index, str)
	local comps = self:getTabComps(index)

	if comps then
		comps.txt1.text = str
		comps.txt2.text = str
	end
end

function M:setTabLock(index, islock)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.lock, islock)

		if islock then
			comps.txt1.color = Astral.ColorUtil.ParseColor("#65666A")
			comps.txt3.color = Astral.ColorUtil.ParseColor("#65666A")
		end
	end
end

return M
