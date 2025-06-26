-- chunkname: @IQIGame\\UIExternalApi\\LibrarySoulApi.lua

LibrarySoulApi = BaseLangApi:Extend()

function LibrarySoulApi:Init()
	self:RegisterApi("TextSoulName", self.GetTextSoulName)
	self:RegisterApi("TextPanelTitle", self.GetTextPanelTitle)
	self:RegisterApi("TextSoulListTitle", self.GetTextSoulListTitle)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("TextBtnChange", self.GetTextBtnChange)
	self:RegisterApi("ToggleStr", self.GetToggleStr)
	self:RegisterApi("SoulHeight", self.GetSoulHeight)
	self:RegisterApi("SoulWeight", self.GetSoulWeight)
	self:RegisterApi("SoulConstellation", self.GetSoulConstellation)
	self:RegisterApi("SoulDescribe", self.GetSoulDescribe)
	self:RegisterApi("CVName", self.GetCVName)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("HandBookName", self.GetHandBookName)
	self:RegisterApi("TextBtnJump", self.GetTextBtnJump)
end

function LibrarySoulApi:GetTextBtnJump()
	return self:GetCfgText(1106159)
end

function LibrarySoulApi:GetTextSoulListTitle()
	return self:GetCfgText(1106148)
end

function LibrarySoulApi:GetHandBookName(name, isLock)
	if isLock then
		return self.TextColor[12] .. name .. self.TextColor[0]
	end

	return self.TextColor[26] .. name .. self.TextColor[0]
end

function LibrarySoulApi:GetTextCondition(condition, needLv, top)
	local str1 = condition
	local str2 = string.format(self:GetCfgText(1106149), needLv)

	if top then
		str2 = "<color=#ffe5a6>" .. string.format(self:GetCfgText(1106149), needLv) .. "</color>"
	end

	if not top then
		return str2
	end

	return str1
end

function LibrarySoulApi:GetCVName(str)
	return string.format(self:GetCfgText(1106154) .. "：%s", str)
end

function LibrarySoulApi:GetSoulDescribe(str)
	return string.format(self:GetCfgText(1106150) .. "：%s", str)
end

function LibrarySoulApi:GetSoulConstellation(str)
	return string.format(self:GetCfgText(1106151) .. "：%s", str)
end

function LibrarySoulApi:GetSoulWeight(num)
	return string.format(self:GetCfgText(1106152) .. "：%sKg", num)
end

function LibrarySoulApi:GetSoulHeight(num)
	return string.format(self:GetCfgText(1106153) .. "：%sCM", num)
end

function LibrarySoulApi:GetToggleStr(index)
	if index == 1 then
		return self:GetCfgText(1106155)
	elseif index == 2 then
		return self:GetCfgText(1104000)
	elseif index == 3 then
		return self:GetCfgText(1106154)
	elseif index == 4 then
		return "CV"
	elseif index == 5 then
		return self:GetCfgText(1106156)
	end

	return ""
end

function LibrarySoulApi:GetTextBtnChange(state)
	return self:GetCfgText(1106173)
end

function LibrarySoulApi:GetTextLock()
	return self:GetCfgText(1106141)
end

function LibrarySoulApi:GetTextPanelTitle()
	return self:GetCfgText(1105006)
end

function LibrarySoulApi:GetTextSoulName(name, isLock)
	if isLock then
		return name
	end

	return name
end

LibrarySoulApi:Init()
