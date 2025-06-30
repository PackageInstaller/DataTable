-- chunkname: @IQIGame\\Module\\Town\\TownFunctionData.lua

TownFunctionData = {}

function TownFunctionData.New(id, type, icon, ownershipAreaID, threadType, newStoryInfo)
	local o = Clone(TownFunctionData)

	o:Init(id, type, icon, ownershipAreaID, threadType, newStoryInfo)

	return o
end

function TownFunctionData:Init(id, type, icon, ownershipAreaID, threadType, newStoryInfo)
	self.cfgID = id
	self.icon = icon
	self.ownerShipAreaID = ownershipAreaID
	self.threadType = threadType

	if type == 2 then
		self.cfgTownEvent = CfgTownEventTable[id]
		self.name = self.cfgTownEvent.Name
		self.functionType = TownModule.TOWN_FUNCTION_PLOT
	elseif type == 3 then
		self.newStoryInfo = newStoryInfo
		self.name = self.newStoryInfo.cfgSoulNewStory.Name
		self.functionType = TownModule.TOWN_FUNCTION_SOUL_NEW_STORY
	elseif type == 4 then
		self.cfgTownEvent = CfgTownEventTable[id]
		self.functionType = TownModule.TOWN_FUNCTION_SHOPPING
		self.name = self.cfgTownEvent.Name
	else
		self.cfgFunction = CfgFunctionTable[id]
		self.name = self.cfgFunction.Name
		self.functionType = self.cfgFunction.FunctionType
	end

	self.rankIndex = self:RankIndex()
end

function TownFunctionData:IsFunctionOpen()
	if self.cfgTownEvent ~= nil then
		return true
	end

	if self.cfgFunction ~= nil then
		local result = UnlockFunctionModule.IsUnlock(self.cfgFunction.FunctionOpen)

		return result
	end

	if self.newStoryInfo ~= nil then
		return true
	end

	return false
end

function TownFunctionData:RankIndex()
	local index = 0

	index = self.threadType == 1 and 1 or self.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY and 2 or self.threadType == 2 and 3 or self.functionType ~= nil and self.functionType > 0 and 4 or self.cfgID

	return index
end

return TownFunctionData
