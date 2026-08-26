-- chunkname: @projbooter/lang/BootLangEnum.lua

module("projbooter.lang.BootLangEnum", package.seeall)

local BootLangEnum = _M

BootLangEnum.Font = {
	b_regular = "bootres/fonts/b_regular.ttf",
	b_hwzs = "bootres/fonts/b_hwzs.ttf",
	b_korea = "bootres/fonts/b_korea.ttf",
	b_japan = "bootres/fonts/b_japan.otf"
}
BootLangEnum.zh = 1
BootLangEnum.tw = 2
BootLangEnum.en = 4
BootLangEnum.ko = 8
BootLangEnum.jp = 16
BootLangEnum.de = 32
BootLangEnum.fr = 64
BootLangEnum.thai = 128
BootLangEnum.LangFont = {
	[BootLangEnum.zh] = BootLangEnum.Font.b_hwzs,
	[BootLangEnum.en] = BootLangEnum.Font.b_regular,
	[BootLangEnum.jp] = BootLangEnum.Font.b_japan,
	[BootLangEnum.ko] = BootLangEnum.Font.b_korea
}
BootLangEnum.SystemLanguageShortcut = {
	[UnityEngine.SystemLanguage.ChineseSimplified] = "zh",
	[UnityEngine.SystemLanguage.ChineseTraditional] = "tw",
	[UnityEngine.SystemLanguage.English] = "en",
	[UnityEngine.SystemLanguage.Korean] = "kr",
	[UnityEngine.SystemLanguage.Japanese] = "jp"
}

return BootLangEnum
