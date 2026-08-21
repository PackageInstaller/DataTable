-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/sdk/nativeutil/FoldingFeatureUtil.lua

module("logic.common.sdk.nativeutil.FoldingFeatureUtil", package.seeall)

local FoldingFeature = {}
local clazz = "com.baitian.wrap.FoldingFeatureWrap"

function XXXX.registerScreenChangedListener()
	NativeBridge.instance:registerListener("key_sdk_screen_changed", function(result)
		return
	end)
end
