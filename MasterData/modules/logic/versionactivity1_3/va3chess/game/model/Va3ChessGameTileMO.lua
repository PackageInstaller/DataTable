-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/model/Va3ChessGameTileMO.lua

module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameTileMO", package.seeall)

local Va3ChessGameTileMO = pureTable("Va3ChessGameTileMO")

function Va3ChessGameTileMO:init(index)
	local var_1_0

	if not index then
		::label_1_0::

		var_1_0 = self.id or 1
	end

	self.id = var_1_0
	self.tileType = 0
	self.triggerTypeList = {}
	self.finishList = {}
	self.triggerStatusDict = {}
end

function Va3ChessGameTileMO:addTrigger(triggerType)
	if triggerType and triggerType > 0 and tabletool.indexOf(self.triggerTypeList, triggerType) == nil then
		table.insert(self.triggerTypeList, triggerType)
	end
end

function Va3ChessGameTileMO:updateTrigger(triggerType, status)
	local oldStatus = self.triggerStatusDict[triggerType]

	if oldStatus ~= status then
		self.triggerStatusDict[triggerType] = status
	end
end

function Va3ChessGameTileMO:getTriggerBrokenStatus()
	local result = self:getTriggerStatus(Va3ChessEnum.TileTrigger.Broken)
	local brokenTrigger = Va3ChessEnum.TileTrigger.Broken

	result = result or Va3ChessEnum.TriggerStatus[brokenTrigger].Normal

	return result
end

function Va3ChessGameTileMO:getTriggerStatus(triggerType)
	if self.triggerStatusDict then
		return self.triggerStatusDict[triggerType]
	end
end

function Va3ChessGameTileMO:removeTrigger(triggerType)
	tabletool.removeValue(self.triggerTypeList, triggerType)
end

function Va3ChessGameTileMO:isHasTrigger(triggerType)
	if tabletool.indexOf(self.triggerTypeList, triggerType) then
		return true
	end

	return false
end

function Va3ChessGameTileMO:addFinishTrigger(triggerType)
	if tabletool.indexOf(self.finishList, triggerType) == nil then
		table.insert(self.finishList, triggerType)
	end
end

function Va3ChessGameTileMO:isFinishTrigger(triggerType)
	local result = not not tabletool.indexOf(self.finishList, triggerType)
	local brokenTrigger = Va3ChessEnum.TileTrigger.Broken

	if self:isHasTrigger(triggerType) and triggerType == brokenTrigger then
		local status = self:getTriggerBrokenStatus()

		result = result or status == Va3ChessEnum.TriggerStatus[brokenTrigger].Broken
	end

	return result
end

function Va3ChessGameTileMO:resetFinish()
	if #self.finishList > 0 then
		self.finishList = {}
	end
end

function Va3ChessGameTileMO:setParamStr(str)
	local hasBaffleTypeData = string.find(str, "|")

	if hasBaffleTypeData then
		local strArr = string.split(str, "|") or {}

		str = strArr[1]
		self.baffleTypeData = strArr[2]
	end

	local nums = string.splitToNumber(str, "#") or {}

	if not nums[1] then
		local cfgTileType = 0

		self.originalTileType = cfgTileType

		if cfgTileType > 0 then
			self.tileType = Va3ChessEnum.TileBaseType.Normal or Va3ChessEnum.TileBaseType.None
		end

		self.triggerTypeList = {}

		if nums and #nums > 1 then
			for i = 2, #nums do
				table.insert(self.triggerTypeList, nums[i])
			end
		end

		self:resetFinish()
	end
end

function Va3ChessGameTileMO:getBaffleDataList()
	return (Activity142Helper.getBaffleDataList(self.originalTileType, self.baffleTypeData))
end

function Va3ChessGameTileMO:getOriginalTileType()
	return self.originalTileType
end

function Va3ChessGameTileMO:isHasBaffleInDir(dir)
	return (Activity142Helper.isHasBaffleInDir(self.originalTileType, dir))
end

function Va3ChessGameTileMO:getParamStr()
	local str = tostring(self.tileType)

	if self.triggerTypeList then
		for i = 1, #self.triggerTypeList do
			str = string.format("%s#%s", str, self.triggerTypeList[i])
		end
	end

	return str
end

return Va3ChessGameTileMO
