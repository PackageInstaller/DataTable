-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillTargetBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillTargetBase", package.seeall)

local ArcadeSkillTargetBase = class("ArcadeSkillTargetBase", ArcadeSkillClass)

function ArcadeSkillTargetBase:ctor()
	ArcadeSkillTargetBase.super.ctor(self)

	self._targetList = {}
	self._targetDict = {}
	self._cfgNeedTargetTypeDict = {}

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillTargetBase:setTargetConfig(cfg)
	self._config = cfg
	self._isIgnoreSelf = false

	if self._config then
		local targets = self._config.targets

		if not string.nilorempty(targets) then
			local targetArr = GameUtil.splitString2(targets)

			for _, arr in ipairs(targetArr) do
				local targetType = arr[1]
				local strTargetIds = arr[2]

				if string.nilorempty(strTargetIds) then
					self._cfgNeedTargetTypeDict[targetType] = true
				else
					local idDict = {}
					local targetIdList = string.splitToNumber(strTargetIds, ",")

					for _, targetId in ipairs(targetIdList) do
						idDict[targetId] = true
					end

					self._cfgNeedTargetTypeDict[targetType] = idDict
				end
			end
		end

		local effect = self._config.effect

		if not string.nilorempty(effect) then
			self._effectParams = string.split(effect, "#")
		end

		self._isIgnoreSelf = self._config.ignoreSelf
	end

	self:tryCallFunc(self.onConfigParams)
end

function ArcadeSkillTargetBase:setTargetTypeByList(targetTypeList)
	self._cfgNeedTargetTypeDict = {}

	if not targetTypeList then
		return
	end

	for _, targetType in ipairs(targetTypeList) do
		self._cfgNeedTargetTypeDict[targetType] = true
	end
end

function ArcadeSkillTargetBase:setRadius(radius)
	self._radius = tonumber(radius) or 0
end

function ArcadeSkillTargetBase:findTarget(gridX, gridY, direction)
	self.gridX = gridX
	self.gridY = gridY
	self.direction = direction
	self._context = nil

	self:tryCallFunc(self.onClearTarget)
	self:tryCallFunc(self.onFindTarget)
end

function ArcadeSkillTargetBase:findByContext(context)
	self.gridX, self.gridY = context.target:getGridPos()
	self.sizeX, self.sizeY = context.target:getSize()
	self.direction = context.target:getDirection()
	self._context = context

	self:tryCallFunc(self.onClearTarget)
	self:tryCallFunc(self.onFindTarget)
end

function ArcadeSkillTargetBase:onClearTarget()
	if self._targetList and #self._targetList > 0 or self._isAddNewTarget then
		self._isAddNewTarget = false

		self:clearList(self._targetList)

		for _, typeDict in pairs(self._targetDict) do
			self:clearTable(typeDict)
		end

		self:clearTable(self._targetDict)
	end
end

function ArcadeSkillTargetBase:onFindTarget()
	return
end

function ArcadeSkillTargetBase:onConfigParams()
	return
end

function ArcadeSkillTargetBase:onCtor()
	return
end

function ArcadeSkillTargetBase:_checkTargetIsValid(unitMO)
	if not unitMO or unitMO:getIsDead() then
		return
	end

	local gridX, gridY = unitMO:getGridPos()
	local isOutSideRoom = ArcadeGameHelper.isOutSideRoom(gridX, gridY)

	if not self._targetCanOutsideRoom and isOutSideRoom then
		return
	end

	local alreadyHas = self:isHasTarget(unitMO)

	if alreadyHas then
		return
	end

	if self._context then
		local selfUnitMO = self._context.target

		if self._isIgnoreSelf and selfUnitMO == unitMO then
			return
		end

		local id = unitMO:getId()
		local entityType = unitMO:getEntityType()

		if next(self._cfgNeedTargetTypeDict) then
			local entityTypeValidData = self._cfgNeedTargetTypeDict[entityType]

			if not entityTypeValidData then
				return
			end

			if type(entityTypeValidData) == "table" and next(entityTypeValidData) and not entityTypeValidData[id] then
				return
			end
		end

		return true
	end
end

function ArcadeSkillTargetBase:addTarget(target)
	local isCanAdd = self:_checkTargetIsValid(target)

	if not isCanAdd then
		return
	end

	local uid = target:getUid()
	local entityType = target:getEntityType()

	table.insert(self._targetList, target)

	local typeDict = ArcadeGameHelper.checkDictTable(self._targetDict, entityType)

	typeDict[uid] = true
	self._isAddNewTarget = true
end

function ArcadeSkillTargetBase:isHasTarget(target)
	if target then
		local uid = target:getUid()
		local entityType = target:getEntityType()
		local typeDict = self._targetDict[entityType]

		if typeDict and typeDict[uid] then
			return true
		end
	end

	return false
end

function ArcadeSkillTargetBase:getTargetList()
	return self._targetList
end

function ArcadeSkillTargetBase:getMainTarget()
	return self._targetList[1]
end

function ArcadeSkillTargetBase:findUnitMOByRectXY(minX, maxX, minY, maxY)
	if not self._cfgNeedTargetTypeDict then
		return
	end

	for targetType, _ in pairs(self._cfgNeedTargetTypeDict) do
		if targetType == ArcadeGameEnum.EntityType.Character then
			self:_checkAddUnitMOXY(minX, maxX, minY, maxY, ArcadeGameModel.instance:getCharacterMO())
		elseif targetType == ArcadeGameEnum.EntityType.Grid then
			self:_checkAddUnitMOListXY(minX, maxX, minY, maxY, ArcadeGameModel.instance:getGridMOList())
		else
			local unitMOList = ArcadeGameModel.instance:getEntityMOList(targetType)

			self:_checkAddUnitMOListXY(minX, maxX, minY, maxY, unitMOList)
		end
	end
end

function ArcadeSkillTargetBase:_checkAddUnitMOListXY(minX, maxX, minY, maxY, unitMOList)
	if not unitMOList or #unitMOList <= 0 then
		return
	end

	for _, unitMO in ipairs(unitMOList) do
		self:_checkAddUnitMOXY(minX, maxX, minY, maxY, unitMO)
	end
end

function ArcadeSkillTargetBase:_checkAddUnitMOXY(minX, maxX, minY, maxY, unitMO)
	if unitMO then
		local bMinX, bMaxX, bMinY, bMaxY = self:getUnitMORectXY(unitMO)

		if self:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY) then
			self:addTarget(unitMO)
		end
	end
end

function ArcadeSkillTargetBase:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY)
	if math.max(minX, bMinX) <= math.min(maxX, bMaxX) and math.max(minY, bMinY) <= math.min(maxY, bMaxY) then
		return true
	end
end

function ArcadeSkillTargetBase:isCheckUnitMOByRectXY(unitMO, minX, maxX, minY, maxY)
	local bMinX, bMaxX, bMinY, bMaxY = self:getUnitMORectXY(unitMO)

	if self:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY) then
		return true
	end
end

function ArcadeSkillTargetBase:getUnitMORectXY(unitMO)
	local gridX, gridY = unitMO:getGridPos()
	local sizeX, sizeY = unitMO:getSize()
	local gMaxX = gridX

	if sizeX and sizeX > 1 then
		gMaxX = gridX + sizeX - 1
	end

	return gridX, gMaxX, gridY, (sizeY and sizeY > 1 or nil) and gridY + sizeY - 1
end

return ArcadeSkillTargetBase
