-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/sdk/QRCodeMgr.lua

module("logiccommon.common.sdk.QRCodeMgr", package.seeall)

local QRCodeMgr = class("QRCodeMgr")

function QRCodeMgr:ctor()
	return
end

function QRCodeMgr.qrCodeScan(failText)
	local param = {}

	param.failText = failText

	NativeBridge.instance:invoke("com.baitian.android.qrcode.scanner.QRCodeScannerWrap", "qrCodeScan", param)
end

function QRCodeMgr.registerQRCodeScanListener(callFunc)
	NativeBridge.instance:registerListener("key_qrcode_scan", function(result)
		callFunc(result.content)
	end)
end

function QRCodeMgr.generateQRCode(width, height, content, returnType, foreground, background, overlay)
	local param = {}

	param.width = width
	param.height = height
	param.content = content
	param.returnType = returnType
	param.foreground = foreground
	param.background = background
	param.overlay = overlay

	return NativeBridge.instance:invokeString("com.baitian.android.qrcode.generator.QRCodeGeneratorWrap", "generateQRCode", param)
end

function QRCodeMgr.generateQRCodeV2(width, height, content, returnType, foreground, background, overlay)
	local param = {}

	param.width = width
	param.height = height
	param.content = content
	param.returnType = returnType
	param.foreground = foreground
	param.background = background
	param.overlay = overlay

	NativeBridge.instance:invoke("com.baitian.android.qrcode.generator.QRCodeGeneratorWrap", "generateQRCodeV2", param)
end

function QRCodeMgr.registerQRCodeGenerateListener(callFunc)
	NativeBridge.instance:registerListener("key_qrcode_generate", function(result)
		callFunc(result.qrCode)
	end)
end

return QRCodeMgr
