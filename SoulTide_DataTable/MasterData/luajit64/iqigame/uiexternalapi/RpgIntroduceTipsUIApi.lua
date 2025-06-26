-- chunkname: @IQIGame\\UIExternalApi\\RpgIntroduceTipsUIApi.lua

RpgIntroduceTipsUIApi = BaseLangApi:Extend()

function RpgIntroduceTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DescTexts", self.GetDescTexts)
end

function RpgIntroduceTipsUIApi:GetTitleText(openCount)
	return self:GetCfgText(5100001)
end

function RpgIntroduceTipsUIApi:GetDescTexts(openCount)
	if openCount == 3 then
		return {
			self:GetCfgText(5100012),
			self:GetCfgText(5100013),
			self:GetCfgText(5100014),
			self:GetCfgText(5100015),
			self:GetCfgText(5100016)
		}
	elseif openCount == 4 then
		return {
			self:GetCfgText(5100020),
			self:GetCfgText(5100021),
			self:GetCfgText(5100022),
			self:GetCfgText(5100023),
			self:GetCfgText(5100024)
		}
	elseif openCount == 5 then
		return {
			self:GetCfgText(5100012),
			self:GetCfgText(5100013),
			self:GetCfgText(5100014),
			self:GetCfgText(5100015),
			self:GetCfgText(5100016)
		}
	else
		return {
			self:GetCfgText(5100002),
			self:GetCfgText(5100003),
			self:GetCfgText(5100004),
			self:GetCfgText(5100005),
			self:GetCfgText(5100006)
		}
	end
end

RpgIntroduceTipsUIApi:Init()
