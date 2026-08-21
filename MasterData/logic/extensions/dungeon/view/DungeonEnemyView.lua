-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEnemyView.lua

module("logic.extensions.dungeon.view.DungeonEnemyView", package.seeall)

local M = class("DungeonEnemyView", ViewComponent)
local kMaxCount = 12

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._arrayItem = {}

	for i = 1, kMaxCount do
		local itemGO = self:getGoByPath("allContent/enemyList/enemy_item_" .. i)
		local item = Astral.LuaComponentContainer.Add(itemGO, DungeonEnemyItem)

		table.insert(self._arrayItem, item)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local params = self:getFirstParam()

	self._dungeonMo = params.dungeonMo

	self:_refreshView()
end

function M:onExit()
	return
end

function M:_refreshView()
	local enemyIds = self._dungeonMo:getEnemyIds()

	for i, item in ipairs(self._arrayItem) do
		local monsterCode = enemyIds[i]

		if monsterCode then
			item:setNone(false)
			item:updateByCode(monsterCode)
		else
			item:setNone(true)
		end
	end
end

function M:_onClickBtnClose()
	self:close()
end

return M
