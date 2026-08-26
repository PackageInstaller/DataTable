-- chunkname: @modules/logic/playercard/view/comp/PlayerCardLayout.lua

module("modules.logic.playercard.view.comp.PlayerCardLayout", package.seeall)

local PlayerCardLayout = class("PlayerCardLayout", LuaCompBase)

function PlayerCardLayout:init(go)
	self.go = go
end

function PlayerCardLayout:addEventListeners()
	return
end

function PlayerCardLayout:removeEventListeners()
	return
end

function PlayerCardLayout:setLayoutList(list)
	self._layoutList = list
end

function PlayerCardLayout:setData(data)
	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			local layoutKey = v:getLayoutKey()

			if not data[layoutKey] then
				v:setLayoutIndex(data[layoutKey])
			end
		end

		table.sort(self._layoutList, SortUtil.keyLower("index"))
		self:refreshLayout()
	end
end

function PlayerCardLayout:refreshLayout()
	if not self._layoutList then
		return
	end

	table.sort(self._layoutList, SortUtil.keyLower("index"))

	local posY = -197

	for i, v in ipairs(self._layoutList) do
		local go = v:getLayoutGO()

		recthelper.setAnchorY(go.transform, posY)

		local height = v:getHeight()

		posY = posY - height - 5
	end
end

function PlayerCardLayout:setEditMode(isEdit)
	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			v:setEditMode(isEdit)
		end
	end
end

function PlayerCardLayout:startUpdate(dragItem)
	if self._inUpdate then
		return
	end

	self.dragItem = dragItem
	self._inUpdate = true

	LateUpdateBeat:Add(self._lateUpdate, self)

	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			v:onStartDrag()
		end
	end
end

function PlayerCardLayout:closeUpdate()
	if not self._inUpdate then
		return
	end

	self.dragItem = nil
	self._inUpdate = false

	LateUpdateBeat:Remove(self._lateUpdate, self)

	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			v:onEndDrag()
		end
	end
end

function PlayerCardLayout:_lateUpdate()
	self:caleLayout()
end

function PlayerCardLayout:caleLayout()
	if not self.dragItem then
		return
	end

	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			if not v.inDrag and self.dragItem:isInArea(v:getCenterScreenPosY()) then
				self.dragItem:exchangeIndex(v)
				self:refreshLayout()

				break
			end
		end
	end
end

function PlayerCardLayout:getLayoutData()
	local data = {}

	if self._layoutList then
		for i, v in ipairs(self._layoutList) do
			table.insert(data, string.format("%s_%s", v:getLayoutKey(), i))
		end
	end

	return table.concat(data, "&")
end

function PlayerCardLayout:onDestroy()
	self:closeUpdate()
end

return PlayerCardLayout
