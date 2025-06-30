-- chunkname: @IQIGame\\Module\\Soul\\SoulHandBookData.lua

SoulHandBookData = {}

function SoulHandBookData.New(cfgID, open, new, isGetReward)
	local o = Clone(SoulHandBookData)

	o:Init(cfgID, open, new, isGetReward)

	return o
end

function SoulHandBookData:Init(cfgID, open, new, isGetReward)
	self.cfgID = cfgID
	self.open = open
	self.isNew = new
	self.isGetReward = isGetReward
	self.cfgInfo = CfgSoulBookTable[cfgID]
end

function SoulHandBookData:IsNewState(lv)
	if lv >= self.cfgInfo.NeedSoulFavorLv and not self.open then
		return true
	end

	return false
end

function SoulHandBookData:IsCanGetReward()
	if self.open and not self.isGetReward and #self.cfgInfo.LockingReward > 0 then
		return true
	end

	return false
end

function SoulHandBookData:GetRewardState()
	if not self.open then
		return 1
	else
		if not self.isGetReward and #self.cfgInfo.LockingReward > 0 then
			return 2
		end

		return 3
	end

	return 1
end

return SoulHandBookData
