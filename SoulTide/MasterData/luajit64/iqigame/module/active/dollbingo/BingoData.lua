-- chunkname: @IQIGame\\Module\\Active\\DollBingo\\BingoData.lua

local BingData = {
	gridGroups = {
		{
			1,
			2,
			3
		},
		{
			4,
			9,
			5
		},
		{
			6,
			7,
			8
		},
		{
			1,
			4,
			6
		},
		{
			2,
			9,
			7
		},
		{
			3,
			5,
			8
		},
		{
			1,
			9,
			8
		},
		{
			3,
			9,
			6
		}
	}
}

function BingData.New()
	local obj = Clone(BingData)

	return obj
end

function BingData:Update(POD)
	self.roundNum = POD.ncData.round
	self.remainCount = POD.ncData.remainCount

	local dataCfgId = POD.dataCfgId

	self.cfgNewActivityData = CfgNewCharacterActivityTable[dataCfgId]
	self.cfgBingoDatum = {}
	self.cfgBingoNumDatum = {}

	for i, v in pairsCfg(CfgNewCharacterBingoTable) do
		if v.BingoGroup == dataCfgId then
			self.cfgBingoDatum[#self.cfgBingoDatum + 1] = v
		end
	end

	table.sort(self.cfgBingoDatum, function(a, b)
		return a.Id < b.Id
	end)

	for i, v in pairsCfg(CfgNewCharacterBingoNumTable) do
		if v.BingoGroup == dataCfgId then
			self.cfgBingoNumDatum[v.Num] = v
		end
	end

	table.sort(self.cfgBingoNumDatum, function(a, b)
		return a.Id < b.Id
	end)

	self.gridStates = {
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		true
	}

	for i, v in pairs(POD.ncData.bingoNums) do
		local cfgNumData = CfgNewCharacterBingoNumTable[v]

		self.gridStates[cfgNumData.Num] = true
	end
end

function BingData:GetGridState(index)
	return self.gridStates[index]
end

function BingData:CheckIsAllBingo()
	for i, v in pairs(self.gridStates) do
		if v == false then
			return false
		end
	end

	return true
end

function BingData:CheckGroupActive(num)
	for i, v in ipairs(self.cfgBingoDatum) do
		local otherTrue = true
		local exist = false

		for m, n in ipairs(v.Combina) do
			if n ~= num then
				if not self.gridStates[n] then
					otherTrue = false

					break
				end
			else
				exist = true
			end
		end

		if exist and otherTrue then
			return v
		end
	end

	return nil
end

return BingData
