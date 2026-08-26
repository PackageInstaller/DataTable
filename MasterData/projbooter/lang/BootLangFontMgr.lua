-- chunkname: @projbooter/lang/BootLangFontMgr.lua

module("projbooter.lang.BootLangFontMgr", package.seeall)

local BootLangFontMgr = class("BootLangFontMgr")

function BootLangFontMgr:init(font)
	self._font = font

	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(self._setFontAsset, self)
end

function BootLangFontMgr:_setFontAsset(langFont, isRegister)
	if isRegister then
		local text = langFont.text

		text.font = self._font
	end
end

function BootLangFontMgr:dispose()
	self._font = nil
end

BootLangFontMgr.instance = BootLangFontMgr.New()

return BootLangFontMgr
