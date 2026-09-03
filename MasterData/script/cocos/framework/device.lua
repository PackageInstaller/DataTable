-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/device.lua

local device = {}

device.platform = "unknown"
device.model = "unknown"

local app = cc.Application:getInstance()
local target = app:getTargetPlatform()

if target == cc.PLATFORM_OS_WINDOWS then
	device.platform = "windows"
elseif target == cc.PLATFORM_OS_MAC then
	device.platform = "mac"
elseif target == cc.PLATFORM_OS_ANDROID then
	device.platform = "android"
elseif target == cc.PLATFORM_OS_IPHONE or target == cc.PLATFORM_OS_IPAD then
	device.platform = "ios"

	local director = cc.Director:getInstance()
	local view = director:getOpenGLView()
	local framesize = view:getFrameSize()
	local w, h = framesize.width, framesize.height

	if w == 640 and h == 960 then
		device.model = "iphone 4"
	elseif w == 640 and h == 1136 then
		device.model = "iphone 5"
	elseif w == 750 and h == 1334 then
		device.model = "iphone 6"
	elseif w == 1242 and h == 2208 then
		device.model = "iphone 6 plus"
	elseif w == 768 and h == 1024 then
		device.model = "ipad"
	elseif w == 1536 and h == 2048 then
		device.model = "ipad retina"
	end
elseif target == cc.PLATFORM_OS_WINRT then
	device.platform = "winrt"
elseif target == cc.PLATFORM_OS_WP8 then
	device.platform = "wp8"
end

local language_ = app:getCurrentLanguage()

language_ = language_ == cc.LANGUAGE_CHINESE and "cn" or language_ == cc.LANGUAGE_FRENCH and "fr" or language_ == cc.LANGUAGE_ITALIAN and "it" or language_ == cc.LANGUAGE_GERMAN and "de" or language_ == cc.LANGUAGE_SPANISH and "es" or language_ == cc.LANGUAGE_RUSSIAN and "ru" or language_ == cc.LANGUAGE_KOREAN and "kr" or language_ == cc.LANGUAGE_JAPANESE and "jp" or language_ == cc.LANGUAGE_HUNGARIAN and "hu" or language_ == cc.LANGUAGE_PORTUGUESE and "pt" or language_ == cc.LANGUAGE_ARABIC and "ar" or language_ == cc.LANGUAGE_THAI and "th" or "en"
device.language = language_
device.writablePath = cc.FileUtils:getInstance():getWritablePath()
device.directorySeparator = "/"
device.pathSeparator = ":"

if device.platform == "windows" then
	device.directorySeparator = "\\"
	device.pathSeparator = ";"
end

printInfo("# device.platform              = " .. device.platform)
printInfo("# device.model                 = " .. device.model)
printInfo("# device.language              = " .. device.language)
printInfo("# device.writablePath          = " .. device.writablePath)
printInfo("# device.directorySeparator    = " .. device.directorySeparator)
printInfo("# device.pathSeparator         = " .. device.pathSeparator)
printInfo("#")

return device
