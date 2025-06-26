-- chunkname: @IQIGame\\Module\\CommonActivity\\MonsterAcademy\\MonsterAcademyAreaData.lua

local m = {
	isLock = false,
	areaFunDic = {}
}
local MonsterAcademyFunctionData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyFunctionData")

function m.New(cfgID, isLock)
	local o = Clone(m)

	o:Init(cfgID, isLock)

	return o
end

function m:Init(cfgID, isLock)
	self.cfgID = cfgID
	self.isLock = isLock
	self.cfgInfo = CfgGalgameMonsterAreaTable[cfgID]
	self.areaFunDic = {}
end

function m:AddMonsterAreaFunction(cfgID, schedulePOD)
	local isAddNew = false

	if self.areaFunDic == nil then
		self.areaFunDic = {}
	end

	local functionID = cfgID

	if schedulePOD then
		functionID = schedulePOD.id
	end

	local isHave = self:IsHaveFunction(functionID)

	if isHave == false then
		isAddNew = true

		local funData = MonsterAcademyFunctionData.New(cfgID, self.cfgInfo.Id, schedulePOD)

		table.insert(self.areaFunDic, 1, funData)
	end

	table.sort(self.areaFunDic, function(a, b)
		return a.cfgFunction.Id < b.cfgFunction.Id
	end)

	return isAddNew
end

function m:RemoveMonsterAreaFunction(functionID)
	local isRemove = false
	local pos = -1

	for i = 1, #self.areaFunDic do
		local funData = self.areaFunDic[i]

		if funData and funData.functionID == functionID then
			pos = i

			break
		end
	end

	if pos ~= -1 then
		table.remove(self.areaFunDic, pos)

		isRemove = true
	end

	return isRemove
end

function m:IsHaveFunction(id)
	for i, v in pairs(self.areaFunDic) do
		if v.functionID == id then
			return true
		end
	end

	return false
end

function m:RefreshAreaFunction()
	local isFunctionChange = false
	local doResult = false

	if self.cfgInfo then
		for i = 1, #self.cfgInfo.FunctionList do
			local functionID = self.cfgInfo.FunctionList[i]
			local cfgFunction = CfgGalgameMonsterSchoolFunctionTable[functionID]

			doResult = false

			if (cfgFunction.FunctionType == MonsterAcademyConstant.FunctionType.FunctionType_Static or cfgFunction.FunctionType == MonsterAcademyConstant.FunctionType.FunctionType_Dynamic) and cfgFunction.FunctionSubType ~= MonsterAcademyConstant.FunctionSubType.FunctionSubType_Date and MonsterAcademyModule.SaveDataDetailPOD then
				local result = MonsterAcademyModule.CheckConditions(cfgFunction.Condition)

				if result then
					doResult = self:AddMonsterAreaFunction(functionID, nil)
				else
					doResult = self:RemoveMonsterAreaFunction(functionID)
				end
			end

			isFunctionChange = isFunctionChange or doResult
		end

		local schedules = MonsterAcademyModule.GetAreaDatingFunction(self.cfgID)

		for i, v in pairs(self.areaFunDic) do
			if v.schedulePOD then
				local have = false

				for k, schedulePOD in pairs(schedules) do
					if v.functionID == schedulePOD.id then
						have = true

						break
					end
				end

				if not have then
					doResult = self:RemoveMonsterAreaFunction(v.functionID)
					isFunctionChange = isFunctionChange or doResult
				end
			end
		end

		for i, v in pairs(schedules) do
			doResult = self:AddMonsterAreaFunction(v.functionId, v)
			isFunctionChange = isFunctionChange or doResult
		end
	end

	return isFunctionChange
end

return m
