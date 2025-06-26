-- chunkname: @IQIGame\\Module\\Guild\\GuildAvatarFrameData.lua

local m = {
	unLock = 0
}

function m.New(id)
	local o = Clone(m)

	o:Init(id)

	return o
end

function m:Init(id)
	self.cfgID = id
	self.cfgInfo = CfgGuildAvatarFrameTable[self.cfgID]
	self.unLock = self:GetUnlock()
end

function m:GetUnlock()
	if self.cfgInfo.IsLock and #self.cfgInfo.NeedBuildingLv > 1 then
		for i = 1, #self.cfgInfo.NeedBuildingLv, 2 do
			local buildCid = self.cfgInfo.NeedBuildingLv[i]
			local needLv = self.cfgInfo.NeedBuildingLv[i + 1]
			local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(buildCid)

			if buildLv < needLv then
				return 0
			end
		end
	end

	return 1
end

return m
