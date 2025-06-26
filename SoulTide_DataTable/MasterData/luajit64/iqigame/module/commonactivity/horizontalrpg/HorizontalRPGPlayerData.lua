-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGPlayerData.lua

local m = {
	lv = 1,
	maxLv = 1
}

function m.New(lv, maxLv)
	local o = Clone(m)

	o:Init(lv, maxLv)

	return o
end

function m:Init(lv, maxLv)
	self.lv = lv
	self.maxLv = maxLv
end

function m:GetLv()
	if self.lv > self.maxLv then
		return self.maxLv
	end

	if self.lv < 1 then
		self.lv = 1
	end

	return self.lv
end

function m:GetCfgData()
	return CfgHorizontalRPGPlayerTable[self.maxLv]
end

return m
