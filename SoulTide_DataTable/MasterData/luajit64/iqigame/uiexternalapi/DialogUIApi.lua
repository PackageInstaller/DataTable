-- chunkname: @IQIGame\\UIExternalApi\\DialogUIApi.lua

DialogUIApi = BaseLangApi:Extend()

function DialogUIApi:Init()
	self:RegisterApi("NameText", self.GetName)
	self:RegisterApi("BtnSelectTxt", self.GetBtnSelectTxt)
	self:RegisterApi("BtnSelectTitleTxt", self.GetBtnTitleTxt)
	self:RegisterApi("SkipBtnText", self.GetSkipBtnText)
	self:RegisterApi("PauseBtnText", self.GetPauseBtnText)
	self:RegisterApi("ReviewBtnText", self.GetReviewBtnText)
	self:RegisterApi("PlayBtnText", self.GetPlayBtnText)
end

function DialogUIApi:GetName(name)
	return name
end

function DialogUIApi:GetBtnSelectTxt(desc, canClick, conditionDesc)
	if canClick then
		return desc
	else
		return desc .. "      " .. string.format("<color=red>%s</color>", conditionDesc)
	end
end

function DialogUIApi:GetBtnTitleTxt(desc)
	return desc
end

function DialogUIApi:GetSkipBtnText()
	return self:GetCfgText(2610001)
end

function DialogUIApi:GetPauseBtnText()
	return self:GetCfgText(2610004)
end

function DialogUIApi:GetReviewBtnText()
	return self:GetCfgText(2610005)
end

function DialogUIApi:GetPlayBtnText()
	return self:GetCfgText(2610006)
end

DialogUIApi:Init()
