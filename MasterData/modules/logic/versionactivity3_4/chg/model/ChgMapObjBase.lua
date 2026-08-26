-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapObjBase.lua

module("modules.logic.versionactivity3_4.chg.model.ChgMapObjBase", package.seeall)

local ChgMapObjBase = class("ChgMapObjBase")

ChgMapObjBase.kDir = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}

function ChgMapObjBase.s_ctor(mapMO, PuzzleMazeObjInfo)
	local res

	if isDebugBuild then
		assert(PuzzleMazeObjInfo.key, "PuzzleMazeObjInfo must has key!!")
	end

	local keySplit = string.splitToNumber(PuzzleMazeObjInfo.key, "_")
	local keyLen = #keySplit
	local isVertex = keyLen <= 2
	local isLine = keyLen >= 4

	if isVertex then
		res = ChgMapObj_Vertex.New(mapMO, PuzzleMazeObjInfo)
	elseif isLine then
		res = ChgMapObj_Line.New(mapMO, PuzzleMazeObjInfo)
	end

	return res
end

function ChgMapObjBase:ctor(mapMO, PuzzleMazeObjInfo)
	self._mapMO = mapMO
	self._info = PuzzleMazeObjInfo
	self._isBlocking = nil
	self._hasInvokedEffect = false
	self._hasSaved = false
	self._targetKey = nil

	self:setHP(self:hp())
end

function ChgMapObjBase:key()
	return self._info.key
end

function ChgMapObjBase:type()
	return self._info.type
end

function ChgMapObjBase:subType()
	return self._info.subType
end

function ChgMapObjBase:group()
	return self._info.group or 0
end

function ChgMapObjBase:priority()
	return self._info.priority
end

function ChgMapObjBase:effects()
	return self._info.effects or {}
end

function ChgMapObjBase:interactLines()
	return self._info.interactLines
end

function ChgMapObjBase:iconUrl()
	return self._info.iconUrl
end

function ChgMapObjBase:hp()
	return self._info.hp
end

function ChgMapObjBase:iconUrl_fx()
	return tostring(self:iconUrl()) .. "_fx"
end

function ChgMapObjBase:debugName()
	return string.format("%s(%s)", self:key(), ChgEnum.rPuzzleMazeObjType[self:type()])
end

function ChgMapObjBase:isNone()
	return self:type() == ChgEnum.PuzzleMazeObjType.None
end

function ChgMapObjBase:isStart()
	return self:type() == ChgEnum.PuzzleMazeObjType.Start
end

function ChgMapObjBase:isEnd()
	return self:type() == ChgEnum.PuzzleMazeObjType.End
end

function ChgMapObjBase:isObstacle()
	if self._isBlocking ~= nil then
		return self._isBlocking
	end

	return self:type() == ChgEnum.PuzzleMazeObjType.Obstacle
end

function ChgMapObjBase:isCheckPoint()
	return self:type() == ChgEnum.PuzzleMazeObjType.CheckPoint
end

function ChgMapObjBase:subTypeIsDefault()
	return self:subType() == ChgEnum.PuzzleMazeObjSubType.Default
end

function ChgMapObjBase:subTypeIs2()
	return self:subType() == ChgEnum.PuzzleMazeObjSubType.Two
end

function ChgMapObjBase:subTypeIs3()
	return self:subType() == ChgEnum.PuzzleMazeObjSubType.Three
end

function ChgMapObjBase:objIsPoint()
	assert(false, "please override this function")
end

function ChgMapObjBase:objIsLine()
	assert(false, "please override this function")
end

function ChgMapObjBase:keyOfUp()
	assert(false, "please override this function")
end

function ChgMapObjBase:keyOfDown()
	assert(false, "please override this function")
end

function ChgMapObjBase:keyOfLeft()
	assert(false, "please override this function")
end

function ChgMapObjBase:keyOfRight()
	assert(false, "please override this function")
end

function ChgMapObjBase:keyOfDir(eDir)
	if eDir == ChgEnum.Dir.Down then
		return self:keyOfDown()
	elseif eDir == ChgEnum.Dir.Up then
		return self:keyOfUp()
	elseif eDir == ChgEnum.Dir.Left then
		return self:keyOfLeft()
	elseif eDir == ChgEnum.Dir.Right then
		return self:keyOfRight()
	end

	return ""
end

function ChgMapObjBase:stepOfUp(step)
	assert(false, "please override this function")
end

function ChgMapObjBase:stepOfDown(step)
	assert(false, "please override this function")
end

function ChgMapObjBase:stepOfLeft(step)
	assert(false, "please override this function")
end

function ChgMapObjBase:stepOfRight(step)
	assert(false, "please override this function")
end

function ChgMapObjBase:stepOfDir(eDir, step)
	if eDir == ChgEnum.Dir.Down then
		return self:stepOfDown(step)
	elseif eDir == ChgEnum.Dir.Up then
		return self:stepOfUp(step)
	elseif eDir == ChgEnum.Dir.Left then
		return self:stepOfLeft(step)
	elseif eDir == ChgEnum.Dir.Right then
		return self:stepOfRight(step)
	end

	return ""
end

function ChgMapObjBase:setIsBlocking(bool)
	self._isBlocking = bool
end

function ChgMapObjBase:hasInvokedEffect()
	do return self._hasInvokedEffect end

	if self._hasInvokedEffect then
		return true
	end

	local effects = self:effects()

	if not effects or #effects == 0 then
		return true
	end

	return false
end

function ChgMapObjBase:setHasInvokedEffect(hasInvoked)
	self._hasInvokedEffect = hasInvoked
end

function ChgMapObjBase:isSavable()
	if self._hasSaved then
		return false
	end

	return self:isEnd() or self:isCheckPoint()
end

function ChgMapObjBase:setHasSaved(bSaved)
	self._hasSaved = bSaved
end

function ChgMapObjBase:getV3a4_AddStartHP()
	local cnt = 0

	for _, effect in ipairs(self:effects()) do
		if effect.type == ChgEnum.PuzzleMazeEffectType.V3a4_AddStartHp then
			cnt = cnt + tonumber(effect.param)
		end
	end

	return cnt
end

function ChgMapObjBase:curHP()
	return self._curHP or 0
end

function ChgMapObjBase:setHP(newHp)
	self._curHP = newHp
end

function ChgMapObjBase:bindTargetKey(key)
	if self._targetKey == nil then
		self._targetKey = key
	end
end

function ChgMapObjBase:getTargetKey()
	return self._targetKey
end

return ChgMapObjBase
