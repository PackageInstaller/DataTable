-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameBlocksUIApi.lua

AmusementParkGameBlocksUIApi = BaseLangApi:Extend()

function AmusementParkGameBlocksUIApi:Init()
	self:RegisterApi("TextRank", self.GetTextRank)
	self:RegisterApi("Title", self.GetTitle)
	self:RegisterApi("TextCurrentLv", self.GetTextCurrentLv)
	self:RegisterApi("TextMaxLv", self.GetTextMaxLv)
	self:RegisterApi("TextGameLv", self.GetTextGameLv)
end

function AmusementParkGameBlocksUIApi:GetTextGameLv(lv)
	return string.format(self:GetCfgText(3830080), lv)
end

function AmusementParkGameBlocksUIApi:GetTextMaxLv(lv)
	if lv == 0 then
		return self:GetCfgText(3830085)
	end

	return string.format(self:GetCfgText(3830081), lv)
end

function AmusementParkGameBlocksUIApi:GetTextCurrentLv(lv)
	if lv == 0 then
		return self:GetCfgText(3830085)
	end

	return string.format(self:GetCfgText(3830082), lv)
end

function AmusementParkGameBlocksUIApi:GetTitle()
	return self:GetCfgText(3830083)
end

function AmusementParkGameBlocksUIApi:GetTextRank(index)
	if index == -1 then
		return self:GetCfgText(3830084)
	end

	return index
end

AmusementParkGameBlocksUIApi:Init()
