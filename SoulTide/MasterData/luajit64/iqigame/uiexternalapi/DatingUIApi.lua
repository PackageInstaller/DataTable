-- chunkname: @IQIGame\\UIExternalApi\\DatingUIApi.lua

DatingUIApi = BaseLangApi:Extend()

function DatingUIApi:Init()
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextComplete", self.GetTextComplete)
	self:RegisterApi("TextDatingSpend", self.GetTextDatingSpend)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("B_BtnDatingTitle", self.GetB_BtnDatingTitle)
	self:RegisterApi("B_BtnReviewTitle", self.GetB_BtnReviewTitle)
	self:RegisterApi("B_Lock_Text1", self.GetB_Lock_Text1)
	self:RegisterApi("TextUnlock", self.GetTextUnlock)
	self:RegisterApi("TextError1", self.GetTextError1)
	self:RegisterApi("TextDatingListTitle", self.GetTextDatingListTitle)
end

function DatingUIApi:GetTextDatingListTitle()
	return self:GetCfgText(1160007)
end

function DatingUIApi:GetTextError1()
	return self:GetCfgText(1014015)
end

function DatingUIApi:GetTextUnlock()
	return self:GetCfgText(1014016)
end

function DatingUIApi:GetB_Lock_Text1()
	return self:GetCfgText(1014017) .. "："
end

function DatingUIApi:GetB_BtnReviewTitle()
	return self:GetCfgText(1014002)
end

function DatingUIApi:GetB_BtnDatingTitle()
	return self:GetCfgText(1160007)
end

function DatingUIApi:GetTextSpend(haveNum, needNum)
	if haveNum < needNum then
		return self.TextColor[203] .. haveNum .. self.TextColor[0] .. "/" .. needNum
	else
		return "<color=#14E128>" .. haveNum .. "</color>" .. "/" .. needNum
	end
end

function DatingUIApi:GetTextDatingSpend()
	return self:GetCfgText(1014018)
end

function DatingUIApi:GetTextComplete()
	return self:GetCfgText(1014013)
end

function DatingUIApi:GetTextCondition(UnlockDegree)
	return self:GetCfgText(1014004) .. UnlockDegree .. self:GetCfgText(1014005)
end

DatingUIApi:Init()
