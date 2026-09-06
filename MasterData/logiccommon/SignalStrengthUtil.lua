-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/SignalStrengthUtil.lua

module("logiccommon.common.sdk.SignalStrengthUtil", package.seeall)

local SignalStrengthUtil = {}

function SignalStrengthUtil.getSignalStrengthLevel(simSlotIndex)
	local param = {}

	param.simSlotIndex = 0

	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getSignalStrengthLevel", param)
end

function SignalStrengthUtil.getWifiStrengthLevel()
	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getWifiStrengthLevel")
end

function SignalStrengthUtil.getSimCardCount()
	return NativeBridge.instance:invokeInt("com.baitian.wrap.SignalStrengthWrap", "getSimCardCount")
end

function SignalStrengthUtil.registerSignalStrengthListener(callFunc)
	NativeBridge.instance:registerListener("key_signal_strength", function(result)
		callFunc(result)
	end)
end

function SignalStrengthUtil.unregisterSignalStrengthListener()
	NativeBridge.instance:unregisterListener("key_signal_strength")
end

return SignalStrengthUtil
