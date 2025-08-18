-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResChannelHideActivityConfig.lua

local RT = {}

RT[1] = {
	22
}

local Data = {
	["DMM-Android"] = {
		channel_name = "DMM-Android",
		hide_mall_subpanel_id = RT[1]
	},
	["DMM-PC"] = {
		channel_name = "DMM-PC",
		hide_activity = {
			2993
		},
		hide_mall_subpanel_id = RT[1]
	},
	amazon = {
		channel_name = "amazon",
		hide_mall_subpanel_id = RT[1]
	}
}

return Data
