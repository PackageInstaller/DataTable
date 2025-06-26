-- chunkname: @IQIGame\\UIExternalApi\\SoulSkillUIApi.lua

SoulSkillUIApi = BaseLangApi:Extend()

function SoulSkillUIApi:Init()
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextSelectSkillTitle1", self.GetTextSelectSkillTitle1)
	self:RegisterApi("TextSelectSkillTitle2", self.GetTextSelectSkillTitle2)
	self:RegisterApi("TextSelectSkillTitle3", self.GetTextSelectSkillTitle3)
	self:RegisterApi("TextSelectSkillTitle4", self.GetTextSelectSkillTitle4)
	self:RegisterApi("TextSelectSkillError1", self.GetTextSelectSkillError1)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextSkillRuneTitle1", self.GetTextSkillRuneTitle1)
	self:RegisterApi("TextSkillRuneTitle2", self.GetTextSkillRuneTitle2)
	self:RegisterApi("TextSkillRuneTitle3", self.GetTextSkillRuneTitle3)
	self:RegisterApi("TextSkillRuneTitle4", self.GetTextSkillRuneTitle4)
	self:RegisterApi("TextSkillRuneTitle5", self.GetTextSkillRuneTitle5)
	self:RegisterApi("TextSkillRuneTitle6", self.GetTextSkillRuneTitle6)
	self:RegisterApi("TextSkillRuneError1", self.GetTextSkillRuneError1)
	self:RegisterApi("TextSkillRuneError2", self.GetTextSkillRuneError2)
	self:RegisterApi("TextSkillRuneError3", self.GetTextSkillRuneError3)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("TextDescribe", self.GetTextDescribe)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("unlockViewTitle", self.GetUnlockViewTitle)
	self:RegisterApi("unlockViewCondition", self.GetUnlockViewCondition)
	self:RegisterApi("goBtnUp", self.GetBtnUpTxt)
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("goMax", self.GetMax)
	self:RegisterApi("maxLv", self.GetMaxLv)
	self:RegisterApi("moneyCount", self.GetMoney)
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goTitle2", self.GetTitle2)
	self:RegisterApi("goEffect", self.GetEffect)
	self:RegisterApi("goCondition", self.GetCondition)
	self:RegisterApi("lv", self.GetLv)
end

function SoulSkillUIApi:GetLv(lv, isNext)
	return "Lv." .. lv
end

function SoulSkillUIApi:GetCondition(lv)
	return self.TextColor[203] .. self:GetCfgText(1226005) .. lv .. self.TextColor[0]
end

function SoulSkillUIApi:GetTitle()
	return self:GetCfgText(1226001)
end

function SoulSkillUIApi:GetEffect(desc)
	return desc
end

function SoulSkillUIApi:GetTitle2()
	return self:GetCfgText(1226002)
end

function SoulSkillUIApi:GetMoney(count, ownCount)
	if ownCount < count then
		count = self.TextColor[28] .. count .. self.TextColor[0]
	end

	return self:FontSize(count, 18)
end

function SoulSkillUIApi:GetMaxLv(lv)
	return "Lv." .. tostring(lv)
end

function SoulSkillUIApi:GetMax()
	return self:GetCfgText(1226006)
end

function SoulSkillUIApi:GetBtnCloseTxt()
	return self:GetCfgText(2300003)
end

function SoulSkillUIApi:GetBtnUpTxt()
	return self:GetCfgText(1226003)
end

function SoulSkillUIApi:GetTextName()
	return self:GetCfgText(1227001)
end

function SoulSkillUIApi:GetTextDescribe()
	return self:GetCfgText(1227002)
end

function SoulSkillUIApi:GetTextSpend(number)
	return self:GetCfgText(1227003) .. self:Space(1) .. number
end

function SoulSkillUIApi:GetTextSkillRuneError3()
	return self:GetCfgText(1227004)
end

function SoulSkillUIApi:GetTextSkillRuneError2()
	return self:GetCfgText(1227005)
end

function SoulSkillUIApi:GetTextSkillRuneError1()
	return self:GetCfgText(1227006)
end

function SoulSkillUIApi:GetTextSkillRuneTitle6()
	return self:GetCfgText(1227007)
end

function SoulSkillUIApi:GetTextSkillRuneTitle5()
	return self:GetCfgText(1227008)
end

function SoulSkillUIApi:GetTextSkillRuneTitle4()
	return self:GetCfgText(1227009)
end

function SoulSkillUIApi:GetTextSkillRuneTitle3()
	return self:GetCfgText(1227010)
end

function SoulSkillUIApi:GetTextSkillRuneTitle2()
	return self:GetCfgText(1227011)
end

function SoulSkillUIApi:GetTextSkillRuneTitle1()
	return self:GetCfgText(1227012)
end

function SoulSkillUIApi:GetTextCondition(lv)
	return self:GetCfgText(1227013) .. lv .. self:GetCfgText(1227014)
end

function SoulSkillUIApi:GetTextSelectSkillError1()
	return self:GetCfgText(1227015)
end

function SoulSkillUIApi:GetTextSelectSkillTitle4()
	return self:GetCfgText(1227016)
end

function SoulSkillUIApi:GetTextSelectSkillTitle3()
	return self:GetCfgText(1227017)
end

function SoulSkillUIApi:GetTextSelectSkillTitle2()
	return self:GetCfgText(1227018)
end

function SoulSkillUIApi:GetTextSelectSkillTitle1()
	return self:GetCfgText(1227019)
end

function SoulSkillUIApi:GetTextTitle2()
	return self:GetCfgText(1227020)
end

function SoulSkillUIApi:GetTextTitle1()
	return self:GetCfgText(1227021)
end

function SoulSkillUIApi:GetUnlockViewTitle()
	return self:GetCfgText(1227022)
end

function SoulSkillUIApi:GetUnlockViewCondition(soulLv, unlockLv, isPreSkillUnlock)
	local ret = ""

	if soulLv < unlockLv then
		ret = string.format(self:GetCfgText(1227023) .. self:GetCfgText(1227024), unlockLv)
	elseif isPreSkillUnlock == false then
		ret = self:GetCfgText(1227025)
	end

	return ret
end

SoulSkillUIApi:Init()
