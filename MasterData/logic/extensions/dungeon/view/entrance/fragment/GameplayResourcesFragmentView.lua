-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/fragment/GameplayResourcesFragmentView.lua

module("logic.extensions.dungeon.view.entrance.fragment.GameplayResourcesFragmentView", package.seeall)

local M = class("GameplayResourcesFragmentView", GameplaySubViewBase)

function M:buildUI()
	M.super.buildUI(self)
	self:_initViewItems()
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)
	self:_refreshView()
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_initViewItems()
	local mainGo = self._registry:getMainGO()
	local goItem1 = goutil.findChild(mainGo, "fight/fight_entry_resources_item")
	local goItem2 = goutil.findChild(mainGo, "fight/fight_entry_resources_item2")
	local item1 = Astral.SimpleLuaComponentContainer.Add(goItem1, GameplayResourcesItem)
	local item2 = Astral.SimpleLuaComponentContainer.Add(goItem2, GameplayResourcesItem)

	self._allItems = {
		item1,
		item2
	}
end

function M:_refreshView()
	for k, v in pairs(self._allItems) do
		local data = {}

		function data.callback()
			self:_onItemClickCallback(k)
		end

		local co = GameplayEntranceConfig.ResourceActivity[k]

		data.unlock = self:_getCanOpen(co.SystemEnum)

		local lockDesc

		if not data.unlock then
			local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(co.SystemEnum)

			if systemOpenCO and not string.nilorempty(systemOpenCO:getUnlockText()) then
				lockDesc = systemOpenCO:getUnlockText()
			end
		end

		data.unlockText = lockDesc

		v:updateData(data)
	end

	if MultipleDropController.instance:equipIsOpen() then
		self._allItems[1]:setActivity()
	end

	if MultipleDropController.instance:getAnDinIsOpen() then
		self._allItems[2]:setActivity()
	end
end

function M:_onItemClickCallback(index)
	local co = GameplayEntranceConfig.ResourceActivity[index]

	if self:_checkCanOpen(co.SystemEnum) then
		ViewMgr.instance:open(co.ViewName)
	end
end

return M
