-- chunkname: @modules/logic/versionactivity3_1/yeshumei/model/YeShuMeiLineMo.lua

module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiLineMo", package.seeall)

local YeShuMeiLineMo = class("YeShuMeiLineMo")

function YeShuMeiLineMo:ctor(id)
	self.id = id
	self.beginPosX = 0
	self.beginPosY = 0
	self.endPosX = 0
	self.endPosY = 0
	self._beginPointId = 0
	self._endPointId = 0
	self.state = YeShuMeiEnum.StateType.Noraml
	self.connected = false
end

function YeShuMeiLineMo:updatePos(beginPosX, beginPosY, endPosX, endPosY)
	self.beginPosX = beginPosX
	self.beginPosY = beginPosY
	self.endPosX = endPosX
	self.endPosY = endPosY
end

function YeShuMeiLineMo:getBeginPos()
	return self.beginPosX, self.beginPosY
end

function YeShuMeiLineMo:getEndPos()
	return self.endPosX, self.endPosY
end

function YeShuMeiLineMo:updatePoint(beginPointId, endPointId)
	self._beginPointId = beginPointId
	self._endPointId = endPointId
end

function YeShuMeiLineMo:havePoint(PointIdA, PointIdB)
	if self._beginPointId == PointIdA and self._endPointId == PointIdB then
		return true
	end

	if self._beginPointId == PointIdB and self._endPointId == PointIdA then
		return true
	end

	return false
end

function YeShuMeiLineMo:checkHaveErrorId(errorId)
	if self._beginPointId == errorId or self._endPointId == errorId then
		return true
	end

	return false
end

function YeShuMeiLineMo:findHavePoint(PointId)
	local havePoint = false
	local otherPointId

	if self._beginPointId == PointId then
		havePoint = true
		otherPointId = self._endPointId
	end

	if self._endPointId == PointId then
		havePoint = true
		otherPointId = self._beginPointId
	end

	return havePoint, otherPointId
end

function YeShuMeiLineMo:setState(state)
	self.state = state
end

function YeShuMeiLineMo:getState()
	return self.state
end

function YeShuMeiLineMo:getStr()
	return string.format("id = %d, beginPosX = %d, beginPosY = %d, endPosX = %d, endPosY = %d, beginPointId = %d, endPointId = %d", self.id, self.beginPosX, self.beginPosY, self.endPosX, self.endPosY, self._beginPointId, self._endPointId)
end

return YeShuMeiLineMo
