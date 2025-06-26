-- chunkname: @IQIGame\\UIExternalApi\\PassCheckDealNewUIApi.lua

PassCheckDealNewUIApi = BaseLangApi:Extend()

function PassCheckDealNewUIApi:Init()
	self:RegisterApi("Title", self.GetTitle)
	self:RegisterApi("Desc", self.GetDesc)
	self:RegisterApi("ReplacementImgNum", self.GetReplacementImgNum)
	self:RegisterApi("NewUIDesc", self.GetNewUIDesc)
end

function PassCheckDealNewUIApi:GetNewUIDesc()
	return self:GetCfgText(3501001)
end

function PassCheckDealNewUIApi:GetReplacementImgNum(num)
	local path = {
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_06.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_07.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_08.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_09.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_10.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_11.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_12.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_13.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_14.png"),
		UIGlobalApi.GetImagePath("/MainCity/PassCheckUI/PassCheckDealUI_Image_15.png")
	}

	return path[num + 1]
end

function PassCheckDealNewUIApi:GetDesc()
	return self:GetCfgText(3501002)
end

function PassCheckDealNewUIApi:GetTitle(type)
	if type == 1 then
		return self:GetCfgText(3501003)
	elseif type == 2 then
		return self:GetCfgText(3501004)
	end

	return ""
end

PassCheckDealNewUIApi:Init()
