-- chunkname: @IQIGame\\UIExternalApi\\LibraryNpcListUIApi.lua

LibraryNpcListUIApi = BaseLangApi:Extend()

function LibraryNpcListUIApi:Init()
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("TextNpcName", self.GetTextNpcName)
	self:RegisterApi("TextPanelTitle", self.GetTextPanelTitle)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("TextDefault", self.GetTextDefault)
	self:RegisterApi("NpcResName", self.GetNpcResName)
	self:RegisterApi("NpcResOccupation", self.GetNpcResOccupation)
	self:RegisterApi("NpcResHeight", self.GetNpcResHeight)
	self:RegisterApi("NpcResWeight", self.GetNpcResWeight)
	self:RegisterApi("NpcResSpeciality", self.GetNpcResSpeciality)
	self:RegisterApi("NpcResWeakness", self.GetNpcResWeakness)
	self:RegisterApi("NpcResLike", self.GetNpcResLike)
	self:RegisterApi("NpcResHate", self.GetNpcResHate)
	self:RegisterApi("NpcResLabel", self.GetNpcResLabel)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("Unlocked", self.GetUnlocked)
	self:RegisterApi("ResValue", self.GetResValue)
	self:RegisterApi("TextPer", self.GetTextPer)
end

function LibraryNpcListUIApi:GetTextPer(num1, num2)
	return string.format(self:GetCfgText(1106144) .. "：%s", math.floor(num1 / num2 * 100) .. "%")
end

function LibraryNpcListUIApi:GetResValue(title, value)
	return string.format("%s: %s", title, value)
end

function LibraryNpcListUIApi:GetUnlocked(str)
	return string.format("%s: %s", str, self:GetCfgText(1106007))
end

function LibraryNpcListUIApi:GetTextMsg()
	return self:GetCfgText(1106140)
end

function LibraryNpcListUIApi:GetNpcResLabel()
	return self:GetCfgText(1106010)
end

function LibraryNpcListUIApi:GetNpcResHate()
	return self:GetCfgText(1106011)
end

function LibraryNpcListUIApi:GetNpcResLike()
	return self:GetCfgText(1106012)
end

function LibraryNpcListUIApi:GetNpcResWeakness()
	return self:GetCfgText(1106013)
end

function LibraryNpcListUIApi:GetNpcResSpeciality()
	return self:GetCfgText(1106014)
end

function LibraryNpcListUIApi:GetNpcResWeight()
	return self:GetCfgText(1106015)
end

function LibraryNpcListUIApi:GetNpcResHeight()
	return self:GetCfgText(1106016)
end

function LibraryNpcListUIApi:GetNpcResOccupation()
	return self:GetCfgText(1106017)
end

function LibraryNpcListUIApi:GetNpcResName()
	return self:GetCfgText(1106018)
end

function LibraryNpcListUIApi:GetTextDefault()
	return self:GetCfgText(1106005)
end

function LibraryNpcListUIApi:GetTextLock()
	return self:GetCfgText(1106141)
end

function LibraryNpcListUIApi:GetTextPanelTitle()
	return self:GetCfgText(1106142)
end

function LibraryNpcListUIApi:GetTextNpcName(name, isLock)
	if isLock then
		return name
	end

	return name
end

function LibraryNpcListUIApi:GetTextBtnTitle()
	return self:GetCfgText(1106143)
end

LibraryNpcListUIApi:Init()
