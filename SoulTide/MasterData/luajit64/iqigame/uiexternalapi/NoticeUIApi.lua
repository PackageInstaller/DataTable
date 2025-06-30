-- chunkname: @IQIGame\\UIExternalApi\\NoticeUIApi.lua

NoticeUIApi = BaseLangApi:Extend()

function NoticeUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitleEng", self.GetTextTitleEng)
	self:RegisterApi("TextBtn", self.GetTextBtn)
	self:RegisterApi("TextUnlockCook", self.GetTextUnlockCook)
end

function NoticeUIApi:GetTextUnlockCook(type)
	if type == 1 then
		return {
			self:GetCfgText(2300080),
			self:GetCfgText(2300081),
			"%s"
		}
	elseif type == 2 then
		return {
			self:GetCfgText(1319004),
			self:GetCfgText(1319005),
			"%s"
		}
	elseif type == 3 then
		return {
			self:GetCfgText(3420221),
			"",
			"%s"
		}
	end

	return {
		self:GetCfgText(1319006),
		self:GetCfgText(1319007),
		"%s"
	}
end

function NoticeUIApi:GetTextBtn()
	return self:GetCfgText(1319001)
end

function NoticeUIApi:GetTextTitle()
	return self:GetCfgText(1319002)
end

function NoticeUIApi:GetTextTitleEng()
	return self:GetCfgText(1319003)
end

NoticeUIApi:Init()
