-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgBattleMapRoundMO.lua

local ti = table.insert
local _B = Bitwise

module("modules.logic.versionactivity3_4.chg.model.ChgBattleMapRoundMO", package.seeall)

local ChgBattleMapRoundMO = class("ChgBattleMapRoundMO")

function ChgBattleMapRoundMO:ctor(mapMO)
	self._mapMO = mapMO
	self._objs = {}
	self._groupId2ObjList = {}
	self._endObjList = {}
	self._startObj = false
	self._visitedKeyDict = {}
end

function ChgBattleMapRoundMO:setStartEnergy(energy)
	self._startEnergy = energy
end

function ChgBattleMapRoundMO:getStartEnergy()
	if not self._startEnergy then
		return self:energy()
	end

	return self._startEnergy
end

function ChgBattleMapRoundMO:roundIndex()
	return self._mapMO:curRound()
end

function ChgBattleMapRoundMO:roundCO()
	return self._mapMO:curRoundCO()
end

function ChgBattleMapRoundMO:energy()
	return self._mapMO:curEnergy()
end

function ChgBattleMapRoundMO:restart()
	self._objs = {}
	self._groupId2ObjList = {}
	self._endObjList = {}
	self._startObj = false
	self._visitedKeyDict = {}
	self._startEnergy = self:energy()

	local function _makeMapObjs(refMap, PuzzleMazeObjInfo_List)
		for _, PuzzleMazeObjInfo in pairs(PuzzleMazeObjInfo_List or {}) do
			local obj = ChgMapObjBase.s_ctor(self, PuzzleMazeObjInfo)
			local group = obj:group()

			if group > 0 then
				self._groupId2ObjList[group] = self._groupId2ObjList[group] or {}

				ti(self._groupId2ObjList[group], obj)
			end

			if obj:isStart() then
				self._startObj = obj
			elseif obj:isEnd() then
				ti(self._endObjList, obj)
			end

			refMap[obj:key()] = obj
		end
	end

	local roundCO = self:roundCO()

	_makeMapObjs(self._objs, roundCO.blockMap)
	_makeMapObjs(self._objs, roundCO.objMap)
end

function ChgBattleMapRoundMO:getObj(key)
	return self._objs[key]
end

function ChgBattleMapRoundMO:startObj()
	return self._startObj
end

function ChgBattleMapRoundMO:endObjList()
	return self._endObjList
end

function ChgBattleMapRoundMO:addVisit(key, eDir)
	if not eDir then
		return
	end

	if not self._visitedKeyDict[key] then
		local newSaved = ChgEnum.Dir.None

		self._visitedKeyDict[key] = _B.set(newSaved, eDir)
	end
end

function ChgBattleMapRoundMO:isVisited(key, eDir)
	if not eDir then
		return false
	end

	if not self._visitedKeyDict[key] then
		local saved = ChgEnum.Dir.None

		return _B.hasAny(saved, eDir)
	end
end

function ChgBattleMapRoundMO:getGroupListByGroupId(groupId)
	if not groupId then
		return {}
	end

	return self._groupId2ObjList[groupId] or {}
end

function ChgBattleMapRoundMO:addVisitByLine(itemIndex, itemCount, lineDir, key)
	if not lineDir or lineDir == ChgEnum.Dir.None then
		return
	end

	local isLast = itemIndex > 1 and itemIndex == itemCount
	local blockDir = isLast and ChgEnum.simpleFlipDir(lineDir) or lineDir

	self:addVisit(key, blockDir)

	if itemIndex > 1 and not isLast then
		self:addVisit(key, ChgEnum.Dir.All)
	end
end

return ChgBattleMapRoundMO
