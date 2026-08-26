-- chunkname: @modules/logic/webview/controller/WebViewEnum.lua

module("modules.logic.webview.controller.WebViewEnum", package.seeall)

local WebViewEnum = _M

WebViewEnum.WebViewCBType = {
	Err = 1,
	Hooked = 4,
	Cookies = 5,
	Started = 3,
	Cb = 0,
	HttpErr = 2,
	LD = 6
}
WebViewEnum.DefaultMargin = {
	Top = 0,
	Right = 0,
	Left = 0,
	Bottom = 120
}
WebViewEnum.DeviceType = {
	PC = 2,
	Harmony = 3,
	Emulator = 1,
	Normal = 0
}

return WebViewEnum
