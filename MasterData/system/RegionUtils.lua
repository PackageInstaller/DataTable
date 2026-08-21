-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\RegionUtils.lua

local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local LuaToolkit = Framework.Tools.LuaToolkit
local RegionUtils = {}
local self = RegionUtils

function RegionUtils._init()
	if not self.hasAbilityLocalization() then
		self.region = RegionConst.REGION_CN
		self.curLanguage = RegionConst.LANGUAGE_CHS
		self.languages = {
			RegionConst.LANGUAGE_CHS
		}
	else
		self.region = LuaToolkit.GetRegion()
		self.curLanguage = LuaToolkit.GetCurLanguage()

		local languages = {}
		local languageArray = LuaToolkit.GetLanguages()

		if languageArray then
			for i = 0, languageArray.Length - 1 do
				table.insert(languages, languageArray[i])
			end
		end

		self.languages = languages
	end
end

function RegionUtils.isCN()
	return self.region == RegionConst.REGION_CN
end

function RegionUtils.isJP()
	return self.region == RegionConst.REGION_JP
end

function RegionUtils.isTW()
	return self.region == RegionConst.REGION_TW
end

function RegionUtils.isKR()
	return self.region == RegionConst.REGION_KR
end

function RegionUtils.isSEA()
	return self.region == RegionConst.REGION_SEA
end

function RegionUtils.isLangJP()
	return RegionUtils.isCurrentLanguage(RegionConst.LANGUAGE_JP)
end

function RegionUtils.isCurrentRegion(region)
	return self.region == region
end

function RegionUtils.isCurrentLanguage(language)
	return self.curLanguage == language
end

function RegionUtils.isCheckType()
	return self.isCN() and self.isCurrentLanguage(RegionConst.LANGUAGE_CHTS)
end

function RegionUtils.switchLanguage(targetLanguage)
	if self.hasAbilityLocalization() then
		LuaToolkit.SetCurLanguage(targetLanguage)
	end
end

function RegionUtils.hasAbilityLocalization()
	local pkgPV = LuaToolkit.GetPkgPatchVersion()
	local engineVersion = pkgPV.engineRvn

	return engineVersion > 101600
end

self._init()

return RegionUtils
