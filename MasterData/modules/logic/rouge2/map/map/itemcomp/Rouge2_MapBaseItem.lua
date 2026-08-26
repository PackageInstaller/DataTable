-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapBaseItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapBaseItem", package.seeall)

local Rouge2_MapBaseItem = class("Rouge2_MapBaseItem", UserDataDispose)

function Rouge2_MapBaseItem:init()
	self:__onInit()

	self.id = nil
	self.scenePos = nil
end

function Rouge2_MapBaseItem:setId(id)
	self.id = id
end

function Rouge2_MapBaseItem:getId()
	return self.id
end

function Rouge2_MapBaseItem:getScenePos()
	return self.scenePos
end

function Rouge2_MapBaseItem:getMapPos()
	return 0, 0, 0
end

function Rouge2_MapBaseItem:getActorPos()
	return 0, 0, 0
end

function Rouge2_MapBaseItem:getUiPos(uiRectTr)
	local scenePos = self:getScenePos()

	return recthelper.worldPosToAnchorPos2(scenePos, uiRectTr)
end

function Rouge2_MapBaseItem:getClickArea()
	return Vector4(100, 100, 0, 0)
end

function Rouge2_MapBaseItem:checkInClickArea(clickPosX, clickPosY, uiRectTr)
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

function Rouge2_MapBaseItem:onClick()
	return
end

function Rouge2_MapBaseItem:isActive()
	return true
end

function Rouge2_MapBaseItem:destroy()
	self:__onDispose()
end

return Rouge2_MapBaseItem
