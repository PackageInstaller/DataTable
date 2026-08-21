-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibrarySoulData.lua

TownLibrarySoulData = {}

local TownLibrarySoulBookData = require("IQIGame.Module.TownLibrary.TownLibrarySoulBookData")

function TownLibrarySoulData.New(cfgID, isLock, unlockPlate)
	local o = Clone(TownLibrarySoulData)

	o:Init(cfgID, isLock, unlockPlate)

	return o
end

function TownLibrarySoulData:Init(cfgID, isLock, unlockPlate)
	self.cfgID = cfgID
	self.cfgInfo = CfgSoulTable[cfgID]
	self.isLock = isLock
	self.soulBookData = self:CreateSoulBookData(unlockPlate)
end

function TownLibrarySoulData:CreateSoulBookData(unlockPlate)
	local tab = {}

	for i, v in pairsCfg(CfgSoulBookTable) do
		local isOpen = false

		if v.SoulId == self.cfgID and v.BookType ~= Constant.BookType.BookTypeDialog then
			local soulData = SoulModule.GetSoulData(v.SoulId)

			isOpen = unlockPlate[v.Id] ~= nil or v.UnLock > 0 and soulData.favorLv >= v.NeedSoulFavorLv

			local soulBookData = TownLibrarySoulBookData.New(v.Id, isOpen)

			table.insert(tab, soulBookData)
		end
	end

	return tab
end

function TownLibrarySoulData:GetSoulBookDataByType(type)
	local tab = {}

	for i, v in pairs(self.soulBookData) do
		if v.cfgInfo.BookType == type then
			if v.cfgInfo.IsShow then
				local soulData = SoulModule.GetSoulData(v.cfgInfo.SoulId)

				if soulData and (soulData.dressCid2D == v.cfgInfo.NeedUnlockDress or soulData.dressCid3D == v.cfgInfo.NeedUnlockDress) then
					table.insert(tab, v)
				end
			else
				table.insert(tab, v)
			end
		end
	end

	table.sort(tab, function(a, b)
		local res = false
		local aLock = a.open and 1 or 0
		local bLock = b.open and 1 or 0

		if aLock == bLock then
			res = a.cfgInfo.Sort < b.cfgInfo.Sort
		else
			res = bLock < aLock
		end

		return res
	end)

	return tab
end

return TownLibrarySoulData
