-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\VersionUtils.lua

local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local LuaToolkit = Framework.Tools.LuaToolkit
local VersionUtils = {}
local ABILITY_VERSION = {
	UNITY_GC = 144654,
	THAI_LANG = 243017,
	ABILITY_PATCH_V2 = 91611,
	ABILITY_WARM_UP_SHADER_LUA = 77824,
	ABILITY_FORUM_V2 = 91812,
	SUBPACKAGE_V3 = 118075,
	NETSERVICE_JSON = 114672,
	URL_GROUP = 112975,
	LOCALIZATION = 101618,
	FONT_TEXTURE = 150000,
	MAT_CAM_DUMP = 179883,
	SUBPACKAGE_V2 = 99106,
	QUALITY_SETTINGS_V1 = 112000,
	IOS_ACC_OFF = 256243,
	ABILITY_AR_ANDROID_OTHER_CAMERA = 89298,
	READ_BYTES_CSHARP = 98822,
	JP_VIP_MONTHCARD = 311187,
	EMULATOR_CHECK = 144931,
	BILI_VIP_MONTHCARD = 335591,
	NEW_CUSTOMERSERVICE = 121817,
	DMM_SUCCESSIONS = 253800,
	PERMISSION_V2 = 141395,
	CIRCLE_BATTLE = 119292,
	ABILITY_FORUM = 89198
}

VersionUtils.ABILITY_VERSION = ABILITY_VERSION

function VersionUtils.getVersionName()
	return LuaToolkit.GetVersionName()
end

function VersionUtils.getBattleDataVersion()
	local BattleMiscConfig = require("Common/BattleMiscConfig")

	return BattleMiscConfig.BATTLE_MODIFY_VERSION
end

function VersionUtils.getDocumentPatchVersion()
	return LuaToolkit.GetLocalPatchVersionLCR()
end

VersionUtils.fakeEngineVersion = -1
VersionUtils._engineVersion = nil

function VersionUtils.getEngineVersion()
	if VersionUtils.fakeEngineVersion >= 0 then
		return VersionUtils.fakeEngineVersion
	end

	if LuaToolkit.IsEditor() then
		return Const.CSHARP_EDIT_VERSION
	end

	if VersionUtils._engineVersion == nil then
		local pkgPV = LuaToolkit.GetPkgPatchVersion()

		VersionUtils._engineVersion = pkgPV.engineRvn
	end

	return VersionUtils._engineVersion
end

function VersionUtils.IsReviewVersion(ignoreRemoteConfig)
	local isReview = false
	local spMark = LuaToolkit.GetPatchSPMark()
	local postfix = LuaToolkit.GetPatchPostfix()

	if spMark and postfix ~= "pre" and string.find(spMark, "review") then
		isReview = true
	end

	if not ignoreRemoteConfig then
		local RemoteConfig = require("Helper/RemoteConfig")

		isReview = isReview or tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_REVIEW)) == 1
	end

	return isReview
end

function VersionUtils.IsJPOpreateChangeVersion()
	local isVersion = false
	local RemoteConfig = require("Helper/RemoteConfig")

	isVersion = isVersion or tonumber(RemoteConfig.getValue(Const.REMOTE_CONFIG_OPREATE_CHANGE)) == 1

	return isVersion
end

function VersionUtils.isSectionEnabled()
	return RegionUtils.isSEA() and #Const.SEA_SECTIONS > 1 and IS_PUBLISH_VERSION and not VersionUtils.IsReviewVersion(true)
end

function VersionUtils.isSpMark(needMark)
	return needMark == SP_MARK
end

function VersionUtils.hasSpMark(needMark)
	return string.find(SP_MARK, needMark)
end

function VersionUtils.IsRechargeDisabled()
	if VersionUtils._IsRechargeDisabled == nil then
		local isDisabled = false

		VersionUtils._IsRechargeDisabled = isDisabled
	end

	return VersionUtils._IsRechargeDisabled
end

function VersionUtils.isAgreementAcceptedDefault()
	local acceptedDefault = false

	if RegionUtils.isJP() or RegionUtils.isTW() then
		acceptedDefault = false
	end

	local remoteConfigAgreement = GameConfig.getChannelConfig(Const.REMOTE_CONFIG_AGREEMENT)

	if remoteConfigAgreement == 0 then
		acceptedDefault = false
	elseif remoteConfigAgreement == 1 then
		acceptedDefault = true
	end

	return acceptedDefault
end

function VersionUtils.isTestVersion()
	local isTest = false

	if IS_EDITOR or not IS_PUBLISH_VERSION or IS_FORCE_INTRANET or POST_FIX == "qa" or POST_FIX == "pre" or VersionUtils.hasSpMark("business") or VersionUtils.hasSpMark("test") then
		isTest = true
	end

	return isTest
end

function VersionUtils.isLabelCheck()
	if not VersionUtils.isTestVersion() then
		return false
	end

	return VersionUtils.getEngineVersion() >= 152418 and pcall(function()
		local try = LuaToolkit.CheckText
	end)
end

function VersionUtils._hasEngineAbility(ability)
	local version = ABILITY_VERSION[ability]

	if version and version <= VersionUtils.getEngineVersion() then
		return true
	end

	return false
end

function VersionUtils.hasAbilityWarmUpShaderByLua()
	return VersionUtils._hasEngineAbility("ABILITY_WARM_UP_SHADER_LUA")
end

function VersionUtils.hasAbilityAROtherCamera()
	return VersionUtils._hasEngineAbility("ABILITY_AR_ANDROID_OTHER_CAMERA")
end

function VersionUtils.hasAbilityForum()
	local DeviceHelper = require("Helper/DeviceHelper")

	if DeviceHelper.isWindows() then
		return false
	end

	if VersionUtils.ChannelUtil == nil then
		VersionUtils.ChannelUtil = require("SDK/ChannelUtil")
	end

	if not ChannelUtil.isPlat and not ChannelUtil.isMulti then
		return false
	end

	local hasAbility = VersionUtils._hasEngineAbility("ABILITY_FORUM_V2")

	if not hasAbility then
		hasAbility = VersionUtils._hasEngineAbility("ABILITY_FORUM")

		if hasAbility and DeviceHelper.isAndroid() then
			local operatingSystem = Framework.Tools.LuaToolkit.GetOperatingSystem()

			if operatingSystem then
				local apiLevel = operatingSystem:match("API%-(%d+)")

				apiLevel = apiLevel and tonumber(apiLevel)

				if apiLevel then
					hasAbility = hasAbility and apiLevel > 23
				end
			end
		end
	end

	if SP_MARK == "cmptest" then
		hasAbility = true
	end

	return hasAbility
end

function VersionUtils.hasAbilityPatchV2()
	return VersionUtils._hasEngineAbility("ABILITY_PATCH_V2")
end

function VersionUtils.hasAbilityLocalization()
	return VersionUtils._hasEngineAbility("LOCALIZATION") and LuaToolkit.GetRegion() ~= RegionConst.REGION_CN
end

function VersionUtils.hasAbilitySubpackageV2()
	return VersionUtils._hasEngineAbility("SUBPACKAGE_V2")
end

function VersionUtils.hasAbilityUrlGroup()
	return VersionUtils._hasEngineAbility("URL_GROUP") and Framework.Network.UrlGroup ~= nil
end

function VersionUtils.hasAbilitySubpackageV3()
	return VersionUtils._hasEngineAbility("SUBPACKAGE_V3")
end

function VersionUtils.hasAbilityNetserviceJson()
	return VersionUtils._hasEngineAbility("NETSERVICE_JSON")
end

function VersionUtils.hasAbilityQualitySettingsV1()
	return VersionUtils._hasEngineAbility("QUALITY_SETTINGS_V1")
end

function VersionUtils.hasAbilityNewCustomerService()
	return VersionUtils._hasEngineAbility("NEW_CUSTOMERSERVICE")
end

function VersionUtils.hasAbilityCircleBattle(...)
	return VersionUtils._hasEngineAbility("CIRCLE_BATTLE")
end

function VersionUtils.hasAbilityShareCN()
	if RegionUtils.isCN() then
		local version = VersionUtils.getEngineVersion()

		if version >= 138478 and version < 161238 then
			return false
		end
	end

	return true
end

function VersionUtils.hasAbilityPermissionV2()
	return VersionUtils._hasEngineAbility("PERMISSION_V2")
end

function VersionUtils.hasAbilityUnityGC()
	return VersionUtils._hasEngineAbility("UNITY_GC")
end

function VersionUtils.hasAbilityEmulatorCheck()
	return VersionUtils._hasEngineAbility("EMULATOR_CHECK")
end

function VersionUtils.isOldVersionSDK_jp()
	return VersionUtils.getEngineVersion() < 169282
end

function VersionUtils.hasMaterialAndCamSupport()
	return false
end

function VersionUtils.hasAbilityThai()
	return VersionUtils._hasEngineAbility("THAI_LANG")
end

function VersionUtils.hasAbilityIOSAccOff()
	return false
end

function VersionUtils.hasAbilityDMMSuccession()
	return false
end

function VersionUtils.hasAbilityJPVIPMonthCard()
	return false
end

function VersionUtils.hasAbilityBiliVIPMonthCard()
	return false
end

return VersionUtils
