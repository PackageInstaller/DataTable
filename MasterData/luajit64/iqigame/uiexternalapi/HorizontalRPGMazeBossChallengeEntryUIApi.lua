-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGMazeBossChallengeEntryUIApi.lua

HorizontalRPGMazeBossChallengeEntryUIApi = BaseLangApi:Extend()

function HorizontalRPGMazeBossChallengeEntryUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnChallenge", self.GetTextBtnChallenge)
	self:RegisterApi("TextBtnShop", self.GetTextBtnShop)
	self:RegisterApi("TextChallenge", self.GetTextChallenge)
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("RpgBossCurrencyIcon", self.GetRpgBossCurrencyIcon)
	self:RegisterApi("RpgBossTicketTitle", self.GetRpgBossTicketTitle)
	self:RegisterApi("RpgBossTicketDes", self.GetRpgBossTicketDes)
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetRpgBossCurrencyIcon(openCount)
	if openCount == 1 then
		return "Assets/05_Images/Icon/Item/Item_Icon_HorizontalRPG_Card.png"
	elseif openCount == 2 then
		return "Assets/05_Images/Icon/Item/Item_Icon_RPG_Card.png"
	elseif openCount == 3 then
		return "Assets/05_Images/Icon/Item/Item_Icon_LHTX_15.png"
	elseif openCount == 4 then
		return "Assets/05_Images/Icon/Item/Item_Icon_RPG_Card_02.png"
	elseif openCount == 5 then
		return "Assets/05_Images/Icon/Item/Item_Icon_LHTX_15.png"
	end
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetRpgBossTicketTitle(openCount)
	if openCount == 1 then
		return self:GetCfgText(3430000)
	elseif openCount == 2 then
		return self:GetCfgText(3100405)
	elseif openCount == 3 then
		return self:GetCfgText(3410110)
	elseif openCount == 4 then
		return self:GetCfgText(3410112)
	elseif openCount == 5 then
		return self:GetCfgText(3410110)
	end
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetRpgBossTicketDes(openCount)
	if openCount == 1 then
		return self:GetCfgText(3430001)
	elseif openCount == 2 then
		return self:GetCfgText(3100404)
	elseif openCount == 3 then
		return self:GetCfgText(3410111)
	elseif openCount == 4 then
		return self:GetCfgText(3410113)
	elseif openCount == 5 then
		return self:GetCfgText(3410111)
	end
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetTextBtnTitle()
	return self:GetCfgText(3100406)
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetTextChallenge(isFree, unlock)
	if unlock then
		return self:GetCfgText(3100401)
	elseif isFree then
		return self:GetCfgText(3100403)
	end

	return self:GetCfgText(3100402)
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetTextBtnShop(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000063)
	elseif openCount == 4 then
		return self:GetCfgText(2000076)
	else
		return self:GetCfgText(3430002)
	end
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetTextBtnChallenge()
	if openCount == 3 then
		return self:GetCfgText(2000062)
	elseif openCount == 4 then
		return self:GetCfgText(2000079)
	else
		return self:GetCfgText(3430003)
	end
end

function HorizontalRPGMazeBossChallengeEntryUIApi:GetTextTitle(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000061)
	elseif openCount == 4 then
		return self:GetCfgText(2000078)
	else
		return self:GetCfgText(3430004)
	end
end

HorizontalRPGMazeBossChallengeEntryUIApi:Init()
