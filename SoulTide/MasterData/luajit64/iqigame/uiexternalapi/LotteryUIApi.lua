-- chunkname: @IQIGame\\UIExternalApi\\LotteryUIApi.lua

LotteryUIApi = BaseLangApi:Extend()
LotteryUIApi.TailEffects = {
	9001521,
	9001522,
	9001523,
	9001524,
	9001525
}
LotteryUIApi.BoxEffects = {
	{
		9001506,
		9001511,
		9001501
	},
	{
		9001506,
		9001512,
		9001502
	},
	{
		9001506,
		9001513,
		9001503
	},
	{
		9001506,
		9001514,
		9001504
	},
	{
		9001506,
		9001515,
		9001505
	}
}
LotteryUIApi.OpenBoxEffects = {
	9001531,
	9001532,
	9001533,
	9001534,
	9001535
}

function LotteryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("FreeText", self.GetFreeText)
	self:RegisterApi("DrawBtnText", self.GetDrawBtnText)
	self:RegisterApi("CostItemNumText", self.GetCostItemNumText)
	self:RegisterApi("FreeCountdownText", self.GetFreeCountdownText)
	self:RegisterApi("TailEffect", self.GetTailEffect)
	self:RegisterApi("BoxEffect", self.GetBoxEffect)
	self:RegisterApi("OpenBoxEffect", self.GetOpenBoxEffect)
	self:RegisterApi("SoulFragmentLabelText", self.GetSoulFragmentLabelText)
	self:RegisterApi("SoulFragmentNumText", self.GetSoulFragmentNumText)
	self:RegisterApi("EquipShowCloseBtnText", self.GetEquipShowCloseBtnText)
	self:RegisterApi("RewardShowQuitBtnText", self.GetRewardShowQuitBtnText)
	self:RegisterApi("RewardShowOpenAllBtnText", self.GetRewardShowOpenAllBtnText)
	self:RegisterApi("RewardShowContinueBtnText", self.GetRewardShowContinueBtnText)
	self:RegisterApi("BaseRewardLabelText", self.GetBaseRewardLabelText)
	self:RegisterApi("BaseRewardNumText", self.GetBaseRewardNumText)
	self:RegisterApi("RewardListBtnText", self.GetRewardListBtnText)
	self:RegisterApi("RuleBtnText", self.GetRuleBtnText)
	self:RegisterApi("EquipShowQualityText", self.GetEquipShowQualityText)
	self:RegisterApi("EquipShowNameText", self.GetEquipShowNameText)
	self:RegisterApi("EquipShowDescText", self.GetEquipShowDescText)
	self:RegisterApi("TabBtnLimitLabel", self.GetTabBtnLimitLabel)
	self:RegisterApi("ToggleGroupName", self.GetToggleGroupName)
	self:RegisterApi("Video1", self.GetVideo1)
	self:RegisterApi("Video2", self.GetVideo2)
	self:RegisterApi("ClickSphereInVideoEffect", self.GetClickSphereInVideoEffect)
	self:RegisterApi("ItemNumText", self.GetItemNumText)
	self:RegisterApi("ResultItemBgEffect", self.GetResultItemBgEffect)
	self:RegisterApi("EquipShowBg1List", self.GetEquipShowBg1List)
	self:RegisterApi("EquipShowBg2List", self.GetEquipShowBg2List)
	self:RegisterApi("EquipShowBg1", self.GetEquipShowBg1)
	self:RegisterApi("EquipShowBg2", self.GetEquipShowBg2)
	self:RegisterApi("EquipShowEffect", self.GetEquipShowEffect)
	self:RegisterApi("InsureRewardTipText", self.GetInsureRewardTipText)
	self:RegisterApi("HiddenInsureRewardTipText", self.GetHiddenInsureRewardTipText)
	self:RegisterApi("SkipBtnText", self.GetSkipBtnText)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("HistoryBtnText", self.GetHistoryBtnText)
	self:RegisterApi("MultiPickButtonText", self.GetMultiPickButtonText)
	self:RegisterApi("TodayLeftDrawCountText", self.GetTodayLeftDrawCountText)
end

function LotteryUIApi:GetTitleText()
	return self:GetCfgText(1317001)
end

function LotteryUIApi:GetFreeText()
	return self:GetCfgText(1317004)
end

function LotteryUIApi:GetDrawBtnText(poolType, prayCount)
	return self:GetCfgText(240, prayCount)
end

function LotteryUIApi:GetCostItemNumText(num)
	return "x" .. num
end

function LotteryUIApi:GetFreeCountdownText(leftTimeSec)
	return self:GetCfgText(241, getTimeDurationText2(leftTimeSec))
end

function LotteryUIApi:GetTailEffect(quality, type)
	return LotteryUIApi.TailEffects[quality]
end

function LotteryUIApi:GetBoxEffect(quality, type)
	return LotteryUIApi.BoxEffects[quality][type]
end

function LotteryUIApi:GetOpenBoxEffect(quality, type)
	return LotteryUIApi.OpenBoxEffects[quality]
end

function LotteryUIApi:GetSoulFragmentLabelText()
	return ""
end

function LotteryUIApi:GetSoulFragmentNumText(num)
	return "x" .. num
end

function LotteryUIApi:GetEquipShowCloseBtnText()
	return self:GetCfgText(1317006)
end

function LotteryUIApi:GetRewardShowQuitBtnText()
	return self:GetCfgText(1317007)
end

function LotteryUIApi:GetRewardShowOpenAllBtnText(isSingleDraw)
	if isSingleDraw then
		return self:GetCfgText(1317027)
	else
		return self:GetCfgText(1317008)
	end
end

function LotteryUIApi:GetRewardShowContinueBtnText()
	return self:GetCfgText(1317009)
end

function LotteryUIApi:GetBaseRewardLabelText()
	return ""
end

function LotteryUIApi:GetBaseRewardNumText(num)
	return "x" .. num
end

function LotteryUIApi:GetRewardListBtnText()
	return self:GetCfgText(1317011)
end

function LotteryUIApi:GetRuleBtnText()
	return self:GetCfgText(1317012)
end

function LotteryUIApi:GetEquipShowQualityText(quality)
	if quality == 1 then
		return "N"
	elseif quality == 2 then
		return "N"
	elseif quality == 3 then
		return "R"
	elseif quality == 4 then
		return "SR"
	elseif quality == 5 then
		return "SSR"
	end

	return "N"
end

function LotteryUIApi:GetEquipShowNameText(name, quality)
	return name
end

function LotteryUIApi:GetEquipShowDescText(desc, quality)
	return desc
end

function LotteryUIApi:GetTabBtnLimitLabel()
	return self:GetCfgText(1317020)
end

function LotteryUIApi:GetToggleGroupName(isSoul)
	if isSoul then
		return self:GetCfgText(1317021)
	else
		return self:GetCfgText(1317022)
	end
end

function LotteryUIApi:GetVideo1()
	return "21_Media/CG/Lottery/Lottery1.mp4"
end

function LotteryUIApi:GetVideo2()
	return "21_Media/CG/Lottery/Lottery2.mp4"
end

function LotteryUIApi:GetClickSphereInVideoEffect(quality)
	if quality == 1 then
		return 9001550, 0
	elseif quality == 2 then
		return 9001550, 9001551
	elseif quality == 3 then
		return 9001550, 9001552
	elseif quality == 4 then
		return 9001550, 9001553
	elseif quality == 5 then
		return 9001550, 9001554
	end

	return 9001550, 0
end

function LotteryUIApi:GetItemNumText(num)
	if num == 1 then
		return ""
	else
		return string.format("x%s", num)
	end
end

function LotteryUIApi:GetResultItemBgEffect(quality)
	if quality == 1 then
		return 9001560
	elseif quality == 2 then
		return 9001561
	elseif quality == 3 then
		return 9001562
	elseif quality == 4 then
		return 9001563
	elseif quality == 5 then
		return 9001564
	end

	return 9001560
end

function LotteryUIApi:GetEquipShowBg1List()
	return {
		self:GetResUrl(2700001),
		self:GetResUrl(2700002),
		self:GetResUrl(2700003),
		self:GetResUrl(2700004),
		self:GetResUrl(2700005)
	}
end

function LotteryUIApi:GetEquipShowBg2List()
	return {
		self:GetResUrl(2700006),
		self:GetResUrl(2700007),
		self:GetResUrl(2700008),
		self:GetResUrl(2700009),
		self:GetResUrl(2700010)
	}
end

function LotteryUIApi:GetEquipShowBg1(quality)
	if quality == 1 then
		return self:GetResUrl(2700001)
	elseif quality == 2 then
		return self:GetResUrl(2700002)
	elseif quality == 3 then
		return self:GetResUrl(2700003)
	elseif quality == 4 then
		return self:GetResUrl(2700004)
	elseif quality == 5 then
		return self:GetResUrl(2700005)
	end
end

function LotteryUIApi:GetEquipShowBg2(quality)
	if quality == 1 then
		return self:GetResUrl(2700006)
	elseif quality == 2 then
		return self:GetResUrl(2700007)
	elseif quality == 3 then
		return self:GetResUrl(2700008)
	elseif quality == 4 then
		return self:GetResUrl(2700009)
	elseif quality == 5 then
		return self:GetResUrl(2700010)
	end
end

function LotteryUIApi:GetEquipShowEffect(quality)
	if quality == 1 then
		return 9001569
	elseif quality == 2 then
		return 9001570
	elseif quality == 3 then
		return 9001571
	elseif quality == 4 then
		return 9001572
	elseif quality == 5 then
		return 9001573
	end

	return 9001569
end

function LotteryUIApi:GetInsureRewardTipText(leftCount)
	if leftCount == 1 then
		return self:GetCfgText(1317024)
	end

	return self.TextColor[206] .. string.format("%s", leftCount) .. self.TextColor[0] .. self:GetCfgText(1317025)
end

function LotteryUIApi:GetHiddenInsureRewardTipText(leftCount, isDevelop, isDebugBuild)
	if isDevelop and isDebugBuild then
		return self.TextColor[207] .. tostring(leftCount) .. self.TextColor[0]
	end

	return ""
end

function LotteryUIApi:GetSkipBtnText()
	return self:GetCfgText(1317026)
end

function LotteryUIApi:GetShopBtnText()
	return self:GetCfgText(1317013)
end

function LotteryUIApi:GetHistoryBtnText()
	return self:GetCfgText(1317304)
end

function LotteryUIApi:GetMultiPickButtonText()
	return self:GetCfgText(1317014)
end

function LotteryUIApi:GetTodayLeftDrawCountText(leftCount)
	return string.format("今日剩余祈愿次数：%s", leftCount)
end

LotteryUIApi:Init()
