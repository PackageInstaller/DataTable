-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessInteractMgr.lua

module("modules.logic.activity.controller.chessmap.ActivityChessInteractMgr", package.seeall)

local ActivityChessInteractMgr = class("ActivityChessInteractMgr")

function ActivityChessInteractMgr:ctor()
	self._list = {}
	self._dict = {}
end

function ActivityChessInteractMgr:add(interactObj)
	local id = interactObj.id

	self:remove(id)

	self._dict[id] = interactObj

	table.insert(self._list, interactObj)
end

function ActivityChessInteractMgr:remove(id)
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

function ActivityChessInteractMgr:getList()
	return self._list
end

function ActivityChessInteractMgr:get(id)
	if self._dict then
		return self._dict[id]
	end

	return nil
end

function ActivityChessInteractMgr:removeAll()
	for _, obj in ipairs(self._list) do
		obj:dispose()
	end

	self._list = {}
	self._dict = {}
end

function ActivityChessInteractMgr.sortRenderOrder(a, b)
	if a.config and b.config then
		if not ActivityChessEnum.Res2SortOrder[a.config.avatar] then
			local aAvatarOrder = 0

			if not ActivityChessEnum.Res2SortOrder[b.config.avatar] then
				local bAvatarOrder = 0

				if aAvatarOrder ~= bAvatarOrder then
					return aAvatarOrder < bAvatarOrder
				end
			end
		end
	end

	return a.id < b.id
end

function ActivityChessInteractMgr.getRenderOrder(obj)
	if obj.config then
		return ActivityChessEnum.Res2SortOrder[obj.config.avatar] or 0
	end

	return 0
end

function ActivityChessInteractMgr:dispose()
	if self._list then
		for _, obj in ipairs(self._list) do
			obj:dispose()
		end

		self._list = nil
		self._dict = nil
	end
end

return ActivityChessInteractMgr
