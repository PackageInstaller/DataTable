-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapBaseItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseItem", package.seeall)

local RougeMapBaseItem = class("RougeMapBaseItem", UserDataDispose)

function RougeMapBaseItem:init()
	self:__onInit()

	self.id = nil
	self.scenePos = nil
end

function RougeMapBaseItem:setId(id)
	self.id = id
end

function RougeMapBaseItem:getScenePos()
	return self.scenePos
end

function RougeMapBaseItem:getMapPos()
	return 0, 0, 0
end

function RougeMapBaseItem:getActorPos()
	return 0, 0, 0
end

function RougeMapBaseItem:getUiPos(uiRectTr)
	local scenePos = self:getScenePos()

	return recthelper.worldPosToAnchorPos2(scenePos, uiRectTr)
end

function RougeMapBaseItem:getClickArea()
	return Vector4(100, 100, 0, 0)
end

function RougeMapBaseItem:checkInClickArea(clickPosX, clickPosY, uiRectTr)
	if not self:isActive() then
		return
	end

	local posX, posY = self:getUiPos(uiRectTr)
	local area = self:getClickArea()
	local halfWidth = area.x / 2
	local halfHeight = area.y / 2

	posX = posX + area.z
	posY = posY + area.w

	if clickPosX >= posX - halfWidth and clickPosX <= posX + halfWidth and clickPosY >= posY - halfHeight and clickPosY <= posY + halfHeight then
		return true
	end
end

function RougeMapBaseItem:onClick()
	return
end

function RougeMapBaseItem:isActive()
	return true
end

function RougeMapBaseItem:destroy()
	self:__onDispose()
end

return RougeMapBaseItem
