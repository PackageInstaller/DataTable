-- chunkname: @IQIGame\\UIExternalApi\\SkinApi.lua

SkinApi = BaseLangApi:Extend()

function SkinApi:Init()
	return
end

function SkinApi:GetHeroResourcesVerticalDrawByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600006), heroSkinConfig.HeroResourcesVerticalDraw)
end

function SkinApi:GetHeadIconByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600009), heroSkinConfig.HeadIcon)
end

function SkinApi:GetHeroResourcesHeadByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600004), heroSkinConfig.HeroResourcesHead)
end

function SkinApi:GetFriendHeadImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600003), heroSkinConfig.FriendHeadImg)
end

function SkinApi:GetDetailsHeadImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600003), heroSkinConfig.DetailsHeadIcon)
end

function SkinApi:GetHeroSmartHeadByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600008), heroSkinConfig.HeroSmartHead)
end

function SkinApi:GetHeroSkillChangeHeadImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600007), heroSkinConfig.HeroSkillChangeHeadImg)
end

function SkinApi:GetAssistInFightingImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600001), heroSkinConfig.AssistInFightingImg)
end

function SkinApi:GetHeroResourcesShowImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600005), heroSkinConfig.HeroResourcesShowImg)
end

function SkinApi:GetFormationShowImgByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600002), heroSkinConfig.FormationShowImg)
end

function SkinApi:GetDynamicPrefabByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	if heroSkinConfig.DynamicPrefab == nil or heroSkinConfig.DynamicPrefab == "" then
		return ""
	end

	return UIGlobalApi.ElementSpinePath .. heroSkinConfig.DynamicPrefab
end

function SkinApi:GetHeroLotterySkinPathByHeroSkinCid(heroSkinId)
	local isConfigLegal, heroSkinConfig = self:TryGetHeroSkinConfigByID(heroSkinId)

	if not isConfigLegal then
		return ""
	end

	if not heroSkinConfig.HeroLotteryTenResources then
		logError(string.format("没有找到heroSkinId = %s的HeroLotteryTenResources", tostring(heroSkinId)))
	end

	return string.format(self:GetResUrl(2005), heroSkinConfig.HeroLotteryTenResources)
end

function SkinApi:GetSkinUIScrollViewShowImgBySkinCid(skinCid)
	local isConfigLegal, skinConfig = self:TryGetSkinConfigByID(skinCid)

	if not isConfigLegal then
		return ""
	end

	return string.format(self:GetResUrl(1600010), skinConfig.SkinUIScrollPreview)
end

function SkinApi:TryGetSkinConfigByID(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local isConfigLegal = true
	local skinConfig = CfgSkinTable[skinCid]

	if skinConfig == nil then
		logError("皮肤系统 - 无法在 Skin表 找到 ID={0} 的字段. 请检查 传参或配表 是否正确.", skinCid)

		isConfigLegal = false
	end

	return isConfigLegal, skinConfig
end

function SkinApi:TryGetHeroSkinConfigByID(heroSkinId)
	if type(heroSkinId) == "string" then
		heroSkinId = tonumber(heroSkinId)
	end

	local isConfigLegal = true
	local heroSkinConfig = CfgHeroSkinTable[heroSkinId]

	if heroSkinConfig == nil then
		logError("皮肤系统 - 无法在 HeroSkin表 找到 ID={0} 的字段. 请检查 传参或配表 是否正确.", heroSkinId)

		isConfigLegal = false
	end

	return isConfigLegal, heroSkinConfig
end

SkinApi:Init()
