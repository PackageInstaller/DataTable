-- chunkname: @modules/logic/defines/LanguageEnum.lua

module("modules.logic.defines.LanguageEnum", package.seeall)

local LanguageEnum = _M

LanguageEnum.LanguageStoryType = {
	KR = 4,
	DE = 6,
	JP = 5,
	TW = 2,
	THAI = 8,
	CN = 1,
	FR = 7,
	EN = 3
}
LanguageEnum.LanguageStoryType2Key = {
	"cn",
	"tw",
	"en",
	"kr",
	"jp",
	"de",
	"fr",
	"thai"
}
LanguageEnum.Lang2KeyEFun = {
	jp = "ja-JP",
	kr = "ko-KR",
	zh = "zh-CN",
	tw = "zh-TW",
	thai = "th-TH",
	en = "en-US"
}
LanguageEnum.Lang2KeyGlobal = {
	jp = "ja_JP",
	kr = "ko_KR",
	zh = "zh_CN",
	tw = "zh_TW",
	thai = "thai",
	en = "en"
}

return LanguageEnum
