-- chunkname: @modules/logic/gm/GMServerUrlConfig.lua

module("modules.logic.gm.GMServerUrlConfig", package.seeall)

local GMServerUrlConfig = _M

GMServerUrlConfig.Presets = {
	weekly = {
		url = "http://game-re-service-localtest5.sl916.com",
		name = "weekly内网服"
	},
	release = {
		url = "http://game-re-service-localtest3.sl916.com",
		name = "release内网服"
	}
}
GMServerUrlConfig.PresetOrder = {
	"weekly",
	"release"
}
GMServerUrlConfig.AllPlatformId = "all"

function GMServerUrlConfig.getOverrideLoginUrl(channelId)
	if not isDebugBuild then
		return nil
	end

	local overridePlatform = PlayerPrefsHelper.getString(PlayerPrefsKey.GMServerUrlOverridePlatform, "")

	if string.nilorempty(overridePlatform) then
		return nil
	end

	if overridePlatform ~= GMServerUrlConfig.AllPlatformId and overridePlatform ~= channelId then
		return nil
	end

	local overrideType = PlayerPrefsHelper.getString(PlayerPrefsKey.GMServerUrlOverrideType, "")
	local preset = GMServerUrlConfig.Presets[overrideType]

	return (preset or nil) and (preset.url or nil)
end

return GMServerUrlConfig
