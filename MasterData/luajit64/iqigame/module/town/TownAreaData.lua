-- chunkname: @IQIGame\\Module\\Town\\TownAreaData.lua

TownAreaData = {}

local TownFunctionData = require("IQIGame.Module.Town.TownFunctionData")

function TownAreaData.New(cfgID, isLock, isNew)
	local o = Clone(TownAreaData)

	o:Init(cfgID, isLock, isNew)

	return o
end

function TownAreaData:Init(cfgID, isLock, isNew)
	self.cfgID = cfgID
	self.cfgInfo = CfgTownAreaTable[cfgID]
	self.isLock = isLock
	self.isNew = isNew
	self.townFunDic = {}
end

function TownAreaData:AddDynamicFunction(id, cfgTownEvent)
	if self.townFunDic == nil then
		self.townFunDic = {}
	end

	local isHave = self:IsHaveFunction(id)

	if isHave == false then
		local funData = TownFunctionData.New(id, 2, cfgTownEvent.IconImge, self.cfgID, cfgTownEvent.EventType)

		table.insert(self.townFunDic, 1, funData)
	end

	table.sort(self.townFunDic, function(a, b)
		return a.rankIndex < b.rankIndex
	end)
end

function TownAreaData:AddSoulNewStory(newStoryInfo)
	if self.townFunDic == nil then
		self.townFunDic = {}
	end

	local isHave = self:IsHaveNewStory(newStoryInfo.cid)

	if isHave == false then
		local funData = TownFunctionData.New(newStoryInfo.cid, 3, newStoryInfo.cfgSoulNewStory.SoulHead, self.cfgID, nil, newStoryInfo)

		table.insert(self.townFunDic, 1, funData)
	end

	table.sort(self.townFunDic, function(a, b)
		return a.rankIndex < b.rankIndex
	end)
end

function TownAreaData:AddRandomSopping(cfgEventID)
	if self.townFunDic == nil then
		self.townFunDic = {}
	end

	local isHave = self:IsHaveFunction(cfgEventID)

	if isHave == false then
		local funData = TownFunctionData.New(cfgEventID, 4, nil, self.cfgID)

		table.insert(self.townFunDic, 1, funData)
	end

	table.sort(self.townFunDic, function(a, b)
		return a.rankIndex < b.rankIndex
	end)
end

function TownAreaData:IsHaveNewStory(id)
	for i, v in pairs(self.townFunDic) do
		if v.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY and v.newStoryInfo.cid == id then
			return true
		end
	end

	return false
end

function TownAreaData:IsHaveFunction(id)
	for i, v in pairs(self.townFunDic) do
		if v.cfgID == id then
			return true
		end
	end

	return false
end

function TownAreaData:IsSoulNewStory()
	for i, v in pairs(self.townFunDic) do
		if v.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY then
			return true
		end
	end

	return false
end

function TownAreaData:IsFunctionPlot()
	for i, v in pairs(self.townFunDic) do
		if v.functionType == TownModule.TOWN_FUNCTION_PLOT then
			return true
		end
	end

	return false
end

function TownAreaData:IsFunctionPlotByID(id)
	for i, v in pairs(self.townFunDic) do
		if (v.threadType == 1 or v.threadType == 2) and v.cfgID == id then
			return true
		end
	end

	return false
end

function TownAreaData:IsUnlockFunction()
	for i, v in pairs(self.townFunDic) do
		if v:IsFunctionOpen() then
			return true
		end
	end

	return false
end

return TownAreaData
