-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianInteractMgr.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianInteractMgr", package.seeall)

local YaXianInteractMgr = class("YaXianInteractMgr")

function YaXianInteractMgr:ctor()
	self._list = {}
	self._dict = {}
end

function YaXianInteractMgr:add(interactObj)
	local id = interactObj.id

	self:remove(id)

	self._dict[id] = interactObj

	table.insert(self._list, interactObj)
end

function YaXianInteractMgr:remove(id)
	local interactObj = self._dict[id]

	if interactObj then
		self._dict[id] = nil

		for index, obj in ipairs(self._list) do
			if obj == interactObj then
				table.remove(self._list, index)
				obj:dispose()

				return true
			end
		end
	end

	return false
end

function YaXianInteractMgr:getList()
	return self._list
end

function YaXianInteractMgr:get(id)
	if self._dict then
		return self._dict[id]
	end

	return nil
end

function YaXianInteractMgr:removeAll()
	for _, obj in ipairs(self._list) do
		obj:dispose()
	end

	self._list = {}
	self._dict = {}
end

function YaXianInteractMgr:dispose()
	if self._list then
		for _, obj in ipairs(self._list) do
			obj:dispose()
		end

		self._list = nil
		self._dict = nil
	end
end

return YaXianInteractMgr
