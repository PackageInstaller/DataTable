-- chunkname: @IQIGame\\Module\\HomeLand\\HLWork\\HLWorkData.lua

HLWorkData = {
	affairDatum = {}
}

function HLWorkData.New()
	local o = Clone(HLWorkData)

	return o
end

function HLWorkData:Initialize(POD)
	self.residueFreeRefreshTimes = POD.freeRefreshTimes

	for i, v in ipairs(POD.affairs) do
		local data = self.affairDatum[i]

		if data == nil then
			data = HLWorkAffairData.New()
			self.affairDatum[i] = data
		end

		data:Initialize(v)
	end
end

function HLWorkData:IsWorking()
	for i, v in pairs(self.affairDatum) do
		if v.status == 1 then
			return true
		end
	end

	return false
end

function HLWorkData:IsGetReward()
	for i, v in pairs(self.affairDatum) do
		if v.status == 2 then
			return true
		end
	end

	return false
end

function HLWorkData:GetAffairData(cid)
	for i, v in pairs(self.affairDatum) do
		if v.cid == cid then
			return v
		end
	end

	return nil
end

function HLWorkData:GetWorkingCount()
	local ret = 0

	for i, v in pairs(self.affairDatum) do
		if v.status == 1 then
			ret = ret + 1
		end
	end

	return ret
end

function HLWorkData:GetUnlockCount()
	return #self.affairDatum
end

function HLWorkData:GetMaxResidueTime()
	local ret = 0

	for i, v in pairs(self.affairDatum) do
		if v.status == 1 then
			local residueTime = v.finishTime - PlayerModule.GetServerTime()

			if ret < residueTime then
				ret = residueTime
			end
		end
	end

	return ret
end
