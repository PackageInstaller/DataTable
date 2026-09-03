-- chunkname: @/tmp/or_script/lua_compile/dm/utils/CustomMap.lua

CustomMap = class("CustomMap", objectlua.Object)

CustomMap:has("_layers", {
	is = "r"
})

local TMXStaggerAxis_Y = 1
local TMXStaggerAxis_X = 2
local TMXStaggerIndex_Odd = 1
local TMXStaggerIndex_Even = 2
local TMXTileFlags = {
	kTMXTileHorizontalFlag = 2147483648,
	kTMXFlippedMask = 536870911,
	kTMXTileVerticalFlag = 1073741824,
	kTMXTileDiagonalFlag = 536870912,
	kTMXFlipedAll = 3221225472
}

function CustomMap:initialize()
	super.initialize(self)
end

function CustomMap:getMapByHeadAandLayersData(head, data, isGlobalZOrder, getGZOrder, isAlias)
	if self._map then
		return self._map
	end

	self._width = head.width
	self._height = head.height
	self._tilewidth = head.tilewidth
	self._tileheight = head.tileheight
	self._orientation = head.orientation == "orthogonal" and 1 or 2
	self._staggeraxis = head.staggeraxis == "y" and 1 or 2
	self._staggerIndex = head.staggerindex == "odd" and 1 or 2
	self._isAlias = isAlias
	self._tileset = head.tileset
	self._layerData = data
	self._isGlobalZOrder = isGlobalZOrder
	self._getGZOrder = getGZOrder
	self._map = cc.Layer:create()
	self._layers = {}

	local size = cc.size(0, 0)

	if self._orientation == 1 then
		size.width = head.width * head.tilewidth
		size.height = head.width * head.height
	elseif self._staggerAxis == TMXStaggerAxis_X then
		size.height = self._tileheight * (self._height + 0.5)
		size.width = self._tilewidth * math.floor(self._width / 2) + self._tilewidth * (self._width % 2 == 0 and 0.5 or 1)
	else
		size.width = self._tilewidth * (self._width + 0.5)
		size.height = self._tileheight * math.floor(self._height / 2) + self._tileheight * (self._height % 2 == 0 and 0.5 or 1)
	end

	self.size = size

	self._map:setContentSize(size)
	self:parseLayers()

	self._map.mediator = self
	self._layerData = nil

	return self._map
end

function CustomMap:parseLayers()
	for i, v in pairs(self._layerData) do
		local layer = self:parseLayerByData(v, i)

		self._map:addChild(layer, i, i)

		self._layers[i] = layer
	end
end

function CustomMap:setTiledRotationByGid(tiled, gid)
	tiled:setFlippedX(false)
	tiled:setFlippedY(false)
	tiled:setAnchorPoint(cc.p(0, 0))

	if bit.band(gid, TMXTileFlags.kTMXTileDiagonalFlag) > 0 then
		local size = tiled:getContentSize()

		tiled:setAnchorPoint(cc.p(0.5, 0.5))

		if self._isAlias then
			size.width = size.width - 2
			size.height = size.height - 2
		end

		tiled:setPosition(size.width * 0.5, size.height * 0.5)

		local flag = bit.band(gid, TMXTileFlags.kTMXTileHorizontalFlag + TMXTileFlags.kTMXTileVerticalFlag)

		if flag == TMXTileFlags.kTMXTileHorizontalFlag then
			tiled:setRotation(90)
		elseif flag == TMXTileFlags.kTMXTileVerticalFlag then
			tiled:setRotation(270)
		elseif flag == TMXTileFlags.kTMXTileVerticalFlag + TMXTileFlags.kTMXTileHorizontalFlag then
			tiled:setRotation(90)
			tiled:setFlippedX(true)
		else
			tiled:setRotation(270)
			tiled:setFlippedX(true)
		end
	else
		if bit.band(gid, TMXTileFlags.kTMXTileHorizontalFlag) > 0 then
			tiled:setFlippedX(true)
		end

		if bit.band(gid, TMXTileFlags.kTMXTileVerticalFlag) > 0 then
			tiled:setFlippedY(true)
		end
	end
end

function CustomMap:parseLayerByData(info, layerIndex)
	local layer = cc.Layer:create()

	layer:setContentSize(self.size)

	for i, rowInfo in pairs(info) do
		for j, gid in pairs(rowInfo) do
			local id = bit.band(gid, TMXTileFlags.kTMXFlippedMask)
			local spriteName = self._tileset[id]

			if id > 0 and spriteName then
				local tiled = self:createTiledByName(spriteName)

				tiled:setAnchorPoint(cc.p(0, 0))

				local index = self._width * i + j

				layer:addChild(tiled, index, index)
				tiled:setPosition(self:getPositionAt(cc.p(j - 1, i - 1)))

				if self._isGlobalZOrder then
					if not tiled.realNode then
						-- block empty
					end

					tiled:setGlobalZOrder(self._getGZOrder(i - 1, j - 1, tiled, layerIndex))
				end

				self:setTiledRotationByGid(tiled.realNode or tiled, gid)
			end
		end
	end

	return layer
end

function CustomMap:getPositionAt(pos)
	if self._orientation == 1 then
		return cc.p(pos.x * self._tilewidth, (self._height - pos.y - 1) * self._tileheight)
	elseif self._staggeraxis == TMXStaggerAxis_Y then
		return cc.p(pos.x * self._tilewidth + ((pos.y % 2 == 1 and self._staggerIndex == TMXStaggerIndex_Odd or pos.y % 2 == 0 and self._staggerIndex == TMXStaggerIndex_Even or nil) and self._tilewidth / 2), (self._height - pos.y - 1) * self._tileheight / 2)
	else
		return cc.p(pos.x * self._tilewidth / 2, (self._height - pos.y - 1) * self._tileheight - ((pos.x % 2 == 1 and self._staggerIndex == TMXStaggerIndex_Odd or pos.x % 2 == 0 and self._staggerIndex == TMXStaggerIndex_Even or nil) and self._tileheight / 2))
	end
end

function CustomMap:createTiledByName(spriteName)
	local tiled = cc.Sprite:createWithSpriteFrameName(spriteName)

	assert(tiled, string.format("未找到地图所需资源%s", spriteName))

	if self._isAlias then
		local size = tiled:getContentSize()
		local scaleX = size.width / (size.width - 2)
		local scaleY = size.height / (size.height - 2)
		local scale = scaleX
		local x, y = 0, 0

		if scaleY <= scaleX then
			x = -1
			y = -1 * (size.height * scaleX - size.height) / 2
		else
			x = -1 * (size.width * scaleY - size.width) / 2
			y = -1
			scale = scaleY
		end

		tiled:setScale(scale)
		tiled:setAnchorPoint(cc.p(0, 0))
		tiled:setPosition(x, y)

		local node = cc.Node:create()

		node:addChild(tiled)

		node.realNode = tiled
		tiled = node
	end

	return tiled
end
