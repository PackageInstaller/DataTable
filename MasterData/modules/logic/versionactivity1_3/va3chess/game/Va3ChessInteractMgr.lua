-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessInteractMgr.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessInteractMgr", package.seeall)

local Va3ChessInteractMgr = class("Va3ChessInteractMgr")

function Va3ChessInteractMgr:ctor()
	self._list = {}
	self._dict = {}
end

function Va3ChessInteractMgr:add(interactObj)
	local id = interactObj.id

	self:remove(id)

	self._dict[id] = interactObj

	table.insert(self._list, interactObj)
end

function Va3ChessInteractMgr:remove(id)
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

function Va3ChessInteractMgr:getList()
	return self._list
end

function Va3ChessInteractMgr:get(id)
	if self._dict then
		return self._dict[id]
	end

	return nil
end

function Va3ChessInteractMgr:getMainPlayer(includeAssistPlayer)
	local assistPlayer

	for _, obj in ipairs(self._list) do
		if obj.objType == Va3ChessEnum.InteractType.Player then
			return obj
		elseif includeAssistPlayer and obj.objType == Va3ChessEnum.InteractType.AssistPlayer then
			assistPlayer = assistPlayer or obj
		end
	end

	return assistPlayer
end

function Va3ChessInteractMgr:removeAll()
	for _, obj in ipairs(self._list) do
		obj:dispose()
	end

	self._list = {}
	self._dict = {}
end

function Va3ChessInteractMgr.sortRenderOrder(a, b)
	if a.config and b.config then
		if not Va3ChessEnum.Res2SortOrder[a.config.avatar] then
			local aAvatarOrder = 0

			if not Va3ChessEnum.Res2SortOrder[b.config.avatar] then
				local bAvatarOrder = 0

				if aAvatarOrder ~= bAvatarOrder then
					return aAvatarOrder < bAvatarOrder
				end
			end
		end
	end

	return a.id < b.id
end

function Va3ChessInteractMgr.getRenderOrder(obj)
	if obj.config then
		return Va3ChessEnum.Res2SortOrder[obj.config.avatar] or 0
	end

	return 0
end

function Va3ChessInteractMgr:dispose()
	if self._list then
		for _, obj in ipairs(self._list) do
			obj:dispose()
		end

		self._list = nil
		self._dict = nil
	end
end

return Va3ChessInteractMgr
