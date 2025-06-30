-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyGirlData.lua

local m = {
	unLockPhone = false,
	unLock = false,
	favor = 0,
	girlFunDic = {},
	girlMessagesRecord = {}
}
local MonsterAcademyFunctionData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyFunctionData")
local MonsterAcademyGirlMessageData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyGirlMessageData")

function m.New(cid)
	local o = Clone(m)

	o:Init(cid)

	return o
end

function m:Init(cid)
	self.cfgID = cid
	self.cfgInfo = CfgGalgameMonsterGirlListTable[cid]
end

function m:GetGirlStage()
	local favorList = {}

	for i, v in pairsCfg(CfgGalgameMonsterGirlFavorTable) do
		if v.SoulID == self.cfgID then
			table.insert(favorList, v)
		end
	end

	table.sort(favorList, function(a, b)
		return a.FavorStage < b.FavorStage
	end)

	local cfgLvMax = favorList[1]
	local temp
	local tempIndex = 1

	for i = 1, #favorList do
		local favorData = favorList[i]

		if self.favor >= favorData.FavorValue then
			temp = favorData
			tempIndex = i
		end
	end

	if temp then
		if self.favor <= temp.FavorValue then
			cfgLvMax = temp
		else
			local nextIndex = tempIndex + 1

			if nextIndex > #favorList then
				nextIndex = #favorList
			end

			cfgLvMax = favorList[nextIndex]
		end
	end

	return cfgLvMax.FavorStage, cfgLvMax.LoveStage
end

function m:RefreshGirlFunction()
	if self.cfgInfo then
		for i = 1, #self.cfgInfo.FunctionID do
			local functionID = self.cfgInfo.FunctionID[i]
			local cfgFunction = CfgGalgameMonsterSchoolFunctionTable[functionID]

			if cfgFunction.FunctionType == MonsterAcademyConstant.FunctionType.FunctionType_Static or cfgFunction.FunctionType == MonsterAcademyConstant.FunctionType.FunctionType_Dynamic then
				local result, failedReason = MonsterAcademyModule.CheckConditions(cfgFunction.Condition)

				if result then
					self:AddGirlFunction(functionID)
				else
					self:RemoveGirlFunction(functionID)
				end
			end
		end
	end
end

function m:RefreshGirlMessage()
	self.girlMessagesRecord = {}

	if self.cfgInfo then
		for i = 1, #self.girlDataPOD.messageGroups do
			local messageGroupPOD = self.girlDataPOD.messageGroups[i]

			self:AddGirlMessageRecord(messageGroupPOD)
		end
	end
end

function m:AddGirlMessageRecord(messageGroupPOD)
	if messageGroupPOD == nil then
		return
	end

	if self.girlMessagesRecord == nil then
		self.girlMessagesRecord = {}
	end

	local messageData = MonsterAcademyGirlMessageData.New(messageGroupPOD.id, messageGroupPOD, self.cfgID)

	table.insert(self.girlMessagesRecord, messageData)
end

function m:AddGirlFunction(cfgID)
	if self.girlFunDic == nil then
		self.girlFunDic = {}
	end

	local isHave = self:IsHaveFunction(cfgID)

	if isHave == false then
		local funData = MonsterAcademyFunctionData.New(cfgID, self.cfgInfo.Id)

		table.insert(self.girlFunDic, funData)
	end

	table.sort(self.girlFunDic, function(a, b)
		return a.cfgFunction.Id < b.cfgFunction.Id
	end)
end

function m:RemoveGirlFunction(cfgID)
	local pos = -1

	for i = 1, #self.girlFunDic do
		local funData = self.girlFunDic[i]

		if funData and funData.cfgID == cfgID then
			pos = i

			break
		end
	end

	if pos ~= -1 then
		table.remove(self.girlFunDic, pos)
	end
end

function m:IsHaveFunction(id)
	for i, v in pairs(self.girlFunDic) do
		if v.cfgID == id then
			return true
		end
	end

	return false
end

function m:GetGirlFunctionBySubType(subTypeTable)
	local tab = {}

	for i, v in pairs(self.girlFunDic) do
		if table.indexOf(subTypeTable, v.cfgFunction.FunctionSubType) ~= -1 then
			table.insert(tab, v)
		end
	end

	return tab
end

function m:IsNextMessage()
	local lastMessageData = self.girlMessagesRecord[#self.girlMessagesRecord]

	if lastMessageData then
		local top = lastMessageData:IsComplete()

		return not top
	end

	return false
end

function m:Refresh(girlDataPOD)
	if girlDataPOD.messageGroups == nil then
		girlDataPOD.messageGroups = {}
	end

	self.girlDataPOD = girlDataPOD
	self.unLock = false
	self.favor = 0
	self.unLockPhone = false

	if self.girlDataPOD then
		self.unLock = true
		self.favor = self.girlDataPOD.favorAbility
		self.unLockPhone = self.girlDataPOD.phoneLock > 0
	end

	self:RefreshGirlFunction()
	self:RefreshGirlMessage()
end

return m
