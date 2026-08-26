-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/entity/TeamChessEmptyUnit.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEmptyUnit", package.seeall)

local TeamChessEmptyUnit = class("TeamChessEmptyUnit", TeamChessSoldierUnit)

function TeamChessEmptyUnit:init(go)
	self.go = go
	self.trans = go.transform
end

function TeamChessEmptyUnit:setPath(path)
	self._path = path

	self:loadAsset(path)
end

function TeamChessEmptyUnit:setScreenPoint(point)
	self._screenPoint = point
end

function TeamChessEmptyUnit:setUnitParentPosition(pos)
	self._unitParentPosition = pos
end

function TeamChessEmptyUnit:_onResLoaded()
	TeamChessEmptyUnit.super._onResLoaded(self)

	if gohelper.isNil(self._backGo) then
		return
	end

	self:setAllMeshRenderOrderInLayer(20)
	self:updateByScreenPos()
	self:setActive(true)
end

function TeamChessEmptyUnit:updateByScreenPos()
	if self._screenPoint == nil or self._unitParentPosition == nil then
		return
	end

	local posX, posY, posZ = recthelper.screenPosToWorldPos3(self._screenPoint, nil, self._unitParentPosition)

	self:updatePos(posX, posY, posZ)
end

function TeamChessEmptyUnit:setOutlineActive(active)
	if gohelper.isNil(self._backOutLineGo) then
		return
	end

	if self._normalActive then
		self:setNormalActive(not active, false)
	end

	gohelper.setActive(self._backOutLineGo.gameObject, active)
	TeamChessEmptyUnit.super.setOutlineActive(self, active)
end

function TeamChessEmptyUnit:setGrayActive(active)
	if gohelper.isNil(self._backGrayGo) then
		return
	end

	if self._normalActive then
		self:setNormalActive(not active, false)
	end

	gohelper.setActive(self._backGrayGo.gameObject, active)
end

function TeamChessEmptyUnit:setNormalActive(active, needRecord)
	if gohelper.isNil(self._backGo) then
		return
	end

	needRecord = needRecord == nil and true or needRecord

	if needRecord then
		self._active = active
	end

	gohelper.setActive(self._backGo.gameObject, active)
end

function TeamChessEmptyUnit:onDestroy()
	self._screenPoint = nil

	TeamChessEmptyUnit.super.onDestroy(self)
end

return TeamChessEmptyUnit
