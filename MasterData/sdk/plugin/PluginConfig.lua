-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\PluginConfig.lua

local DeviceHelper = require("Helper/DeviceHelper")
local SDKConst = require("SDK/SDKConst")
local ChannelID = SDKConst.ChannelID
local PluginConfig = {}

PluginConfig.GAME_NAME = Lang.get(1763)
PluginConfig.CUSTOMER_SERVICE_STRAT_DUMMY = 0
PluginConfig.DATA_ANALYSIS_STRAT_DUMMY = 0
PluginConfig.DATA_ANALYSIS_APP_ID = {
	[PluginConfig.DATA_ANALYSIS_STRAT_DUMMY] = "DataAnalysisAppIDDummy"
}
PluginConfig.BUG_REPORT_STRAT_DUMMY = 0
PluginConfig.BUG_REPORT_STRAT_BUGLY = 1
PluginConfig.BUGLY_APPID_DICT = {
	[DeviceHelper.PLATFORM_IOS] = {
		[ChannelID.FLOW] = {
			"ddd7bfceb5",
			"ddd7bfceb5"
		}
	},
	[DeviceHelper.PLATFORM_ANDROID] = {
		[ChannelID.FLOW] = {
			"8d03fcfc4e",
			"93f4efdd0c"
		}
	}
}

function PluginConfig.getBuglyAppID()
	local appIDPair = PluginConfig._getDataByPlatformAndChannel(PluginConfig.BUGLY_APPID_DICT)

	if appIDPair then
		return IS_PUBLISH_VERSION and appIDPair[2] or appIDPair[1]
	end

	return nil
end

PluginConfig.GAME_VOICE_STRAT_DUMMY = 0
PluginConfig.GAME_VOICE_STRAT_GCLOUD = 1
PluginConfig.GAME_VOICE_CONFIG_DICT = {
	[ChannelID.FLOW] = {
		"1654672322",
		"1385bbcdf932f59f4cc7faad5f5ae9d9",
		"udp://cn.voice.gcloudcs.com:10001"
	}
}

function PluginConfig.getGameVoiceConfig()
	local config = PluginConfig._getDataByChannel(PluginConfig.GAME_VOICE_CONFIG_DICT)

	return unpack(config or {})
end

PluginConfig.LOCAL_NOTIFICATION_STRAT_DUMMY = 0
PluginConfig.LOCAL_NOTIFICATION_STRAT_STAN = 1
PluginConfig.WEB_VIEW_STRAT_DUMMY = 0
PluginConfig.WEB_VIEW_STRAT_UNI = 1
PluginConfig.PUSH_NOTIFICATION_STRAT_DUMMY = 0
PluginConfig.PUSH_NOTIFICATION_STRAT_XG = 1
PluginConfig.DATA_PUSH_NOTIFICATION_ID_KEY = {
	[PluginConfig.PUSH_NOTIFICATION_STRAT_DUMMY] = {
		100,
		"PushAppKeyDummy"
	},
	[PluginConfig.PUSH_NOTIFICATION_STRAT_XG] = {
		[DeviceHelper.PLATFORM_IOS] = {
			[true] = {
				2200274044,
				"I4PM958G1FPV"
			},
			[false] = {
				2200274079,
				"IHZF9965LV5D"
			}
		},
		[DeviceHelper.PLATFORM_ANDROID] = {
			[true] = {
				2100273773,
				"A9PJJF942J5A"
			},
			[false] = {
				2100274073,
				"A564FMU39QBQ"
			}
		}
	}
}
PluginConfig.SOCIAL_SHARE_STRAT_DUMMY = 0
PluginConfig.SOCIAL_SHARE_STRAT_MOB = 1
PluginConfig.REMOTE_DEBUG_STRAT_DUMMY = 0
PluginConfig.REMOTE_DEBUG_STRAT_HDG = 1
PluginConfig.REMOTE_CONTROLLER_STRAT_DUMMY = 0
PluginConfig.REMOTE_CONTROLLER_STRAT_NETEASE = 1
PluginConfig.GPM_STRAT_DUMMY = 0
PluginConfig.GPM_STRAT_MOB = 1

function PluginConfig._getDataByChannel(dict)
	local channelID = ChannelUtil.getChannelID()

	if dict then
		local value = dict[channelID]

		if value ~= nil then
			return value
		else
			return dict[ChannelID.FLOW]
		end
	end
end

function PluginConfig._getDataByPlatformAndChannel(dict)
	local platform = DeviceHelper.runtimePlatform

	if dict then
		local dict2 = dict[platform]

		if dict2 ~= nil then
			return PluginConfig._getDataByChannel(dict2)
		else
			return nil
		end
	end
end

return PluginConfig
