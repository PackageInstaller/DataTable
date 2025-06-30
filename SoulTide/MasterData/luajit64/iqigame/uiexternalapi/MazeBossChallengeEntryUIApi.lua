-- chunkname: @IQIGame\\UIExternalApi\\MazeBossChallengeEntryUIApi.lua

MazeBossChallengeEntryUIApi = BaseLangApi:Extend()

function MazeBossChallengeEntryUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnChallenge", self.GetTextBtnChallenge)
	self:RegisterApi("TextBtnShop", self.GetTextBtnShop)
	self:RegisterApi("TextChallenge", self.GetTextChallenge)
	self:RegisterApi("TextBtnTitle", self.GetTextBtnTitle)
	self:RegisterApi("RpgBossCurrencyIcon", self.GetRpgBossCurrencyIcon)
	self:RegisterApi("RpgBossTicketTitle", self.GetRpgBossTicketTitle)
	self:RegisterApi("RpgBossTicketDes", self.GetRpgBossTicketDes)
end

function MazeBossChallengeEntryUIApi:GetRpgBossCurrencyIcon(openCount)
	if openCount == 1 then
		return "Assets/05_Images/Icon/Item/Item_Icon_RPG_Card.png"
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

function MazeBossChallengeEntryUIApi:GetRpgBossTicketTitle(openCount)
	if openCount == 1 then
		return self:GetCfgText(3100405)
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

function MazeBossChallengeEntryUIApi:GetRpgBossTicketDes(openCount)
	if openCount == 1 then
		return self:GetCfgText(3100404)
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

function MazeBossChallengeEntryUIApi:GetTextBtnTitle()
	return self:GetCfgText(3100406)
end

function MazeBossChallengeEntryUIApi:GetTextChallenge(isFree, unlock)
	if unlock then
		return self:GetCfgText(3100401)
	elseif isFree then
		return self:GetCfgText(3100403)
	end

	return self:GetCfgText(3100402)
end

function MazeBossChallengeEntryUIApi:GetTextBtnShop(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000063)
	elseif openCount == 4 then
		return self:GetCfgText(2000076)
	else
		return self:GetCfgText(2000021)
	end
end

function MazeBossChallengeEntryUIApi:GetTextBtnChallenge()
	if openCount == 3 then
		return self:GetCfgText(2000062)
	elseif openCount == 4 then
		return self:GetCfgText(2000079)
	else
		return self:GetCfgText(2000079)
	end
end

function MazeBossChallengeEntryUIApi:GetTextTitle(openCount)
	if openCount == 3 then
		return self:GetCfgText(2000061)
	elseif openCount == 4 then
		return self:GetCfgText(2000078)
	else
		return self:GetCfgText(2000019)
	end
end

MazeBossChallengeEntryUIApi:Init()
