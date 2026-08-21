-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/toolnotice/ToolNoticemMo.lua

module("logic.extensions.charactersystem.view.preinstall.toolnotice.ToolNoticemMo", package.seeall)

local M = class("ToolNoticemMo")

function M:ctor()
	self._name = nil
	self._heroID = nil
	self._cellList = {}
	self._cellDataList = {}
end

function M:setItemMo(item)
	if item then
		self._name = item.name or ""
		self._heroID = item.heroId or 0
		self._cellList = item.list or {}
	elseif item == nil then
		printError("预设传入参数错误")
	end
end

function M:getName()
	return self._name
end

function M:getHeroId()
	return self._heroID
end

function M:addCellList(itemUuid)
	local length = #self._cellList

	self._cellList[length + 1] = itemUuid
end

function M:getCellListSize()
	return #self._cellList
end

function M:getCellDataList()
	if self._cellList then
		for k, v in pairs(self._cellList) do
			local data = ItemModel.instance:getItemDataByUuid(v)

			self._cellDataList[k] = data
		end
	end

	return self._cellDataList
end

return M
