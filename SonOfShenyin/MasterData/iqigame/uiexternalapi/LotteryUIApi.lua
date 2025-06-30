-- chunkname: @IQIGame\\UIExternalApi\\LotteryUIApi.lua

LotteryUIApi = BaseLangApi:Extend()

function LotteryUIApi:GetTitleText()
	return
end

function LotteryUIApi:GetImgPath(path)
	return UIGlobalApi.GetIconPath(path)
end

function LotteryUIApi:SetTenMoneyTextColor(str, isenough)
	if isenough then
		return self.TextColor[4] .. "X" .. str .. self.TextColor[0]
	else
		return self.TextColor[1] .. "X" .. str .. self.TextColor[0]
	end
end

function LotteryUIApi:SetOneMoneyTextColor(str, isenough)
	if isenough then
		return self.TextColor[9] .. "X" .. str .. self.TextColor[0]
	else
		return self.TextColor[1] .. "X" .. str .. self.TextColor[0]
	end
end

function LotteryUIApi:GetHeroQualityImg(quality)
	return UIGlobalApi.GetImagePath(string.format("/Lottery/LotteryUI/LotteryGrade/Grade-Icon_00%s.png", quality))
end

function LotteryUIApi:GetHeroProfessionImg(type, profession)
	if type == 1 then
		return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/LotteryProfession/Profession_%s.png", profession))
	elseif type == 2 then
		return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/LotteryProfession/Profession_%s.png", profession))
	elseif type == 3 then
		return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/LotteryProfession/Profession_%s.png", profession))
	end
end

function LotteryUIApi:GetRepeatText(type, value)
	if type == 1 then
		return self:GetCfgText(180101)
	else
		return "+" .. value
	end
end

function LotteryUIApi:GetTokenItemText()
	return self:GetCfgText(180204)
end

function LotteryUIApi:GetOnceBtnTitle()
	return self:GetCfgText(180102)
end

function LotteryUIApi:GetTenBtnTitle()
	return self:GetCfgText(180103)
end

function LotteryUIApi:GetImgShowEffect(quality)
	if quality == 3 then
		return 70004
	elseif quality == 4 then
		return 70005
	elseif quality == 5 then
		return 70006
	end
end

function LotteryUIApi:GetItemShowEffect(quality)
	if quality == 3 then
		return 70001
	elseif quality == 4 then
		return 70002
	elseif quality == 5 then
		return 70003
	end
end

function LotteryUIApi:GetItemNotEnoughTips(num, itemName, needMoney, moneyName)
	return string.format(self:GetCfgText(180104), num, itemName, needMoney, moneyName)
end

function LotteryUIApi:GetDateTimeFormat_DDHHText()
	return self:GetCfgText(180105)
end

function LotteryUIApi:GetDateTimeFormat_MMSSText()
	return self:GetCfgText(180106)
end

function LotteryUIApi:GetDrwaResultTitle(openType)
	if openType == 1 then
		return self:GetCfgText(180202)
	elseif openType == 2 then
		return self:GetCfgText(180201)
	else
		return ""
	end
end

function LotteryUIApi:GetDetailTipsStarText(tipsCid)
	return self:GetCfgText(tipsCid)
end

function LotteryUIApi:GetDetailTipsStarBg(starNum)
	return string.format("Assets/05_Images/DataResource/UIResource/LotteryCommonImg/LotteryDetail_TitleImg_0%s.png", starNum)
end

function LotteryUIApi:GetProbabilityTipsStarText(starNum)
	return string.format(self:GetCfgText(180110), starNum)
end

function LotteryUIApi:GetProbabilityTipsItemType(itemType)
	if itemType == 2 then
		return self:GetCfgText(180107)
	elseif itemType == 4 then
		return self:GetCfgText(180108)
	else
		return "-"
	end
end

function LotteryUIApi:GetProbabilityTipsItemTitle()
	return {
		self:GetCfgText(180111),
		self:GetCfgText(180112)
	}
end

function LotteryUIApi:GetCfgTextWithNumberString(cfgIdStr)
	return self:GetCfgText(tonumber(cfgIdStr))
end

function LotteryUIApi:GetMainItemBackground(id)
	return string.format("Assets/05_Images/DataResource/UIResource/LotteryCardBigImg/LotteryShow_%s.png", id)
end

function LotteryUIApi:GetSubItemBackground(id)
	return string.format("Assets/05_Images/DataResource/UIResource/LotteryCardSmallImg/LotteryShow_%s.png", id)
end

function LotteryUIApi:GetHeroPoolUINodeName()
	return "RoleMould"
end

function LotteryUIApi:GetDIYPoolUINodeName()
	return "DIYMould"
end

function LotteryUIApi:GetLotteryResultMoviePath()
	return "21_Media/Lottery/Lottery.mp4"
end

function LotteryUIApi:GetLotteryResultQualityMoviePath(quality)
	return string.format("21_Media/Lottery/Quality_%s.mp4", quality)
end

function LotteryUIApi:GetLotteryResultDisplayDurationTime()
	return 0.12
end

function LotteryUIApi:GetShopButtonJumpCid()
	return 20000024
end

function LotteryUIApi:GetShopFreeButtonJumpCid()
	return 20000075
end

function LotteryUIApi:GetFirstShowViewDelayTime()
	return 1
end

function LotteryUIApi:GetRookieCardPoolCloseTimeS()
	return 86400
end

function LotteryUIApi:GetRookieCardPoolCloseText(timeStr)
	return string.format(self:GetCfgText(180203), timeStr)
end

function LotteryUIApi:GetMovieJumpButtonShowDelayTime()
	return 2.2
end
