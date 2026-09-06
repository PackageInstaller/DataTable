-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/Clipboard.lua

module("logiccommon.common.sdk.Clipboard", package.seeall)

local Clipboard = {}
local VersionCode = 0

function Clipboard.copy(content)
	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(content)

		return true
	end

	if not Clipboard._checkCanUse() then
		printError("无法使用复制，当前版本号：", VersionCode)

		return
	end

	local param = {}

	param.content = content

	NativeBridge.instance:invoke("com.baitian.wrap.ClipboardWrap", "copyclip", param)

	return true
end

function Clipboard.paste()
	if not Clipboard._checkCanUse() then
		printError("无法使用粘贴，当前版本号：", VersionCode)

		return
	end

	return NativeBridge.instance:invokeString("com.baitian.wrap.ClipboardWrap", "pasteclip")
end

function Clipboard._checkCanUse()
	if Framework.OSDef.RunOS == Framework.OSDef.IOS then
		if VersionCode <= 0 then
			VersionCode = SDKManager.getGameVersionCode()
		end

		return VersionCode > 205
	end

	return true
end

return Clipboard
