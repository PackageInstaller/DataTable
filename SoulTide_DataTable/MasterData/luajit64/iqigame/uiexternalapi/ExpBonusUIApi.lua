-- chunkname: @IQIGame\\UIExternalApi\\ExpBonusUIApi.lua

ExpBonusUIApi = BaseLangApi:Extend()

function ExpBonusUIApi:Init()
	self:RegisterApi("desc1", self.GetDesc1)
	self:RegisterApi("desc2", self.GetDesc2)
	self:RegisterApi("btnCloseTxt", self.GetBtnCloseTxt)
	self:RegisterApi("lvImg", self.GetLvImg)
	self:RegisterApi("btnJumpTxt", self.GetBtnJumpTxt)
	self:RegisterApi("title1", self.GetTitle1)
	self:RegisterApi("title2", self.GetTitle2)
	self:RegisterApi("desc3", self.GetDesc3)
	self:RegisterApi("numIcon", self.GetNumIcon)
	self:RegisterApi("BtnBuyTxt", self.GetBtnBuyTxt)
	self:RegisterApi("BtnFinishTxt", self.GetBtnFinishTxt)
end

function ExpBonusUIApi:GetBtnFinishTxt()
	return self:GetCfgText(3500006)
end

function ExpBonusUIApi:GetBtnBuyTxt(num, name, top)
	if top then
		return self:GetCfgText(3500007)
	end

	return string.format("%s%s", num, name)
end

function ExpBonusUIApi:GetNumIcon(num)
	return UIGlobalApi.GetImagePath("/MainCity/ExpBonusUI/ExpBonus_Button_" .. num .. ".png")
end

function ExpBonusUIApi:GetDesc3(desc)
	return desc
end

function ExpBonusUIApi:GetTitle2(title)
	return title
end

function ExpBonusUIApi:GetTitle1()
	return self:GetCfgText(3500001)
end

function ExpBonusUIApi:GetBtnJumpTxt()
	return self:GetCfgText(3500002)
end

function ExpBonusUIApi:GetLvImg(num)
	return UIGlobalApi.GetImagePath("/MainCity/ExpBonusUI/ExpBonus_Image_" .. num .. ".png")
end

function ExpBonusUIApi:GetBtnCloseTxt()
	return self:GetCfgText(3500003)
end

function ExpBonusUIApi:GetDesc1()
	return self:GetCfgText(3500004)
end

function ExpBonusUIApi:GetDesc2()
	return self:GetCfgText(3500005)
end

ExpBonusUIApi:Init()
