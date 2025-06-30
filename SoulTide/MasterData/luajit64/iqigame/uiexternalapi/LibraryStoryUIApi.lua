-- chunkname: @IQIGame\\UIExternalApi\\LibraryStoryUIApi.lua

LibraryStoryUIApi = BaseLangApi:Extend()

function LibraryStoryUIApi:Init()
	self:RegisterApi("StoryTypeName", self.GetStoryTypeName)
	self:RegisterApi("LockError", self.GetLockError)
	self:RegisterApi("ToggleResType", self.GetToggleResType)
	self:RegisterApi("ToggleResNum", self.GetToggleResNum)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("HandBookName", self.GetHandBookName)
	self:RegisterApi("ImgTag", self.GetImgTag)
end

function LibraryStoryUIApi:GetImgTag(type, open)
	if open then
		if type == 1 then
			return self:GetResUrl(1403002)
		else
			return self:GetResUrl(1403004)
		end
	elseif type == 1 then
		return self:GetResUrl(1403001)
	else
		return self:GetResUrl(1403003)
	end
end

function LibraryStoryUIApi:GetHandBookName(name, isLock)
	if isLock then
		return self.TextColor[12] .. name .. self.TextColor[0]
	end

	return self.TextColor[26] .. name .. self.TextColor[0]
end

function LibraryStoryUIApi:GetPanelTitle()
	return self:GetCfgText(1106160)
end

function LibraryStoryUIApi:GetTextLock()
	return "???"
end

function LibraryStoryUIApi:GetToggleResNum(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function LibraryStoryUIApi:GetToggleResType(type)
	if type == 1 then
		return self:GetCfgText(1106161)
	elseif type == 2 then
		return self:GetCfgText(1106162)
	elseif type == 3 then
		return self:GetCfgText(1106174)
	elseif type == 4 then
		return self:GetCfgText(1106164)
	elseif type == 5 then
		return self:GetCfgText(1106165)
	elseif type == 6 then
		return self:GetCfgText(1106163)
	elseif type == 7 then
		return self:GetCfgText(1106162)
	elseif type == 9 then
		return self:GetCfgText(1106161)
	elseif type == 10 then
		return self:GetCfgText(1106162)
	end

	return ""
end

function LibraryStoryUIApi:GetLockError(type)
	return self:GetCfgText(1106166)
end

function LibraryStoryUIApi:GetStoryTypeName(type)
	if type == 1 then
		return self:GetCfgText(1107009)
	elseif type == 2 then
		return self:GetCfgText(44)
	elseif type == 3 then
		return self:GetCfgText(1106167)
	elseif type == 4 then
		return self:GetCfgText(1106168)
	elseif type == 5 then
		return self:GetCfgText(1104000)
	elseif type == 7 then
		return self:GetCfgText(1106169)
	end

	return ""
end

LibraryStoryUIApi:Init()
