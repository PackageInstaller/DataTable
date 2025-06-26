-- chunkname: @IQIGame\\UIExternalApi\\LibraryUIApi.lua

LibraryUIApi = BaseLangApi:Extend()

function LibraryUIApi:Init()
	self:RegisterApi("Title", self.GetTitle)
	self:RegisterApi("TextBtnReceiveLibrary", self.GetTextBtnReceiveLibrary)
	self:RegisterApi("TextToggle1", self.GetTextToggle1)
	self:RegisterApi("TextToggle2", self.GetTextToggle2)
	self:RegisterApi("TextToggle3", self.GetTextToggle3)
	self:RegisterApi("TextToggle4", self.GetTextToggle4)
	self:RegisterApi("TextToggle5", self.GetTextToggle5)
	self:RegisterApi("TextToggle6", self.GetTextToggle6)
	self:RegisterApi("TextToggle7", self.GetTextToggle7)
	self:RegisterApi("TextUnLock", self.GetTextUnLock)
	self:RegisterApi("Error", self.GetError)
	self:RegisterApi("NpcResName", self.GetNpcResName)
	self:RegisterApi("NpcResOccupation", self.GetNpcResOccupation)
	self:RegisterApi("NpcResHeight", self.GetNpcResHeight)
	self:RegisterApi("NpcResWeight", self.GetNpcResWeight)
	self:RegisterApi("NpcResSpeciality", self.GetNpcResSpeciality)
	self:RegisterApi("NpcResWeakness", self.GetNpcResWeakness)
	self:RegisterApi("NpcResLike", self.GetNpcResLike)
	self:RegisterApi("NpcResHate", self.GetNpcResHate)
	self:RegisterApi("NpcResLabel", self.GetNpcResLabel)
	self:RegisterApi("PanelBGM", self.GetPanelBGM)
	self:RegisterApi("TextTitle", self.GetTextTitle)
end

function LibraryUIApi:GetTextTitle(isEng)
	if isEng then
		return self:GetCfgText(1106135)
	end

	return self:GetCfgText(1106134)
end

function LibraryUIApi:GetPanelBGM()
	return 8
end

function LibraryUIApi:GetNpcResLabel()
	return self:GetCfgText(1106010)
end

function LibraryUIApi:GetNpcResHate()
	return self:GetCfgText(1106011)
end

function LibraryUIApi:GetNpcResLike()
	return self:GetCfgText(1106012)
end

function LibraryUIApi:GetNpcResWeakness()
	return self:GetCfgText(1106013)
end

function LibraryUIApi:GetNpcResSpeciality()
	return self:GetCfgText(1106014)
end

function LibraryUIApi:GetNpcResWeight()
	return self:GetCfgText(1106015)
end

function LibraryUIApi:GetNpcResHeight()
	return self:GetCfgText(1106016)
end

function LibraryUIApi:GetNpcResOccupation()
	return self:GetCfgText(1106017)
end

function LibraryUIApi:GetNpcResName()
	return self:GetCfgText(1106018)
end

function LibraryUIApi:GetError(type)
	if type == 3 then
		return self:GetCfgText(1019066)
	elseif type == 4 then
		return self:GetCfgText(1019067)
	end

	return self:GetCfgText(1106170)
end

function LibraryUIApi:GetTextUnLock()
	return "?????"
end

function LibraryUIApi:GetTextToggle7()
	return self:GetCfgText(1106052)
end

function LibraryUIApi:GetTextToggle6()
	return self:GetCfgText(1106047)
end

function LibraryUIApi:GetTextToggle5()
	return self:GetCfgText(1106160)
end

function LibraryUIApi:GetTextToggle4()
	return self:GetCfgText(49)
end

function LibraryUIApi:GetTextToggle3()
	return self:GetCfgText(1106108)
end

function LibraryUIApi:GetTextToggle2()
	return self:GetCfgText(1106148)
end

function LibraryUIApi:GetTextToggle1()
	return self:GetCfgText(1106143)
end

function LibraryUIApi:GetTitle()
	return self:GetCfgText(1106171)
end

function LibraryUIApi:GetTextBtnReceiveLibrary()
	return self:GetCfgText(1106172)
end

LibraryUIApi:Init()
