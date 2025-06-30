-- chunkname: @IQIGame\\Module\\Dating\\DatingEndServerData.lua

DatingEndServerData = {}

function DatingEndServerData.New()
	local o = Clone(DatingEndServerData)

	return o
end

function DatingEndServerData:Init(eventCid, getItems, beginFavor, endFavor, ending, newEnding)
	self.eventCid = eventCid
	self.soulID = CfgDatingEventsTable[eventCid].SoulID
	self.getItems = getItems
	self.beginFavor = beginFavor
	self.beginFavorLevel = SoulModule.GetFavorLv(self.soulID, beginFavor)
	self.endFavor = endFavor
	self.endFavorLevel = SoulModule.GetFavorLv(self.soulID, endFavor)
	self.ending = ending
	self.newEnding = newEnding

	local startNum = self.beginFavor - self:GetSoulFavor(self.soulID, self.beginFavorLevel)
	local startDes = self:GetSoulFavor(self.soulID, self.beginFavorLevel + 1) - self:GetSoulFavor(self.soulID, self.beginFavorLevel)

	self.beginPer = startNum / startDes
	self.endExp = self.endFavor - self:GetSoulFavor(self.soulID, self.endFavorLevel)
	self.endExpMax = self:GetSoulFavor(self.soulID, self.endFavorLevel + 1) - self:GetSoulFavor(self.soulID, self.endFavorLevel)
	self.endPer = self.endExp / self.endExpMax
end

function DatingEndServerData:GetSoulFavor(id, lv)
	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == id and v.FavorDegree == lv then
			return v.FavorValue
		end
	end

	return 0
end
