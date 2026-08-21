-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/lang/LanguageMgr.lua

module("logic.common.lang.LanguageMgr", package.seeall)

local M = class("LanguageMgr", LanguageMgrBase)

function M:getNames()
	return {
		ConfigName.LangTip,
		ConfigName.LangRC,
		ConfigName.Language
	}
end

function M:getLangRcInfo(status)
	local langRc = self._dict[ConfigName.LangRC]

	return langRc and langRc[status]
end

function M:getLangTipInfo(status)
	local langTip = self._dict[ConfigName.LangTip]

	return langTip and langTip[status]
end

function M:getText(info, langType)
	langType = langType or self._curLangType

	return info and info[langType] or ""
end

M.instance = M.New()

function langOrNil(key)
	return M.instance:langOrNil(key)
end

function lang(key, langType)
	return M.instance:lang(key, langType)
end

function langF(key, ...)
	return string.format(lang(key), ...)
end

setglobal("langOrNil", langOrNil)
setglobal("lang", lang)
setglobal("langF", langF)

return M
