-- chunkname: @modules/common/global/gamestate/GameLangFont.lua

module("modules.common.global.gamestate.GameLangFont", package.seeall)

local GameLangFont = class("GameLangFont")
local NotLoad = 1
local Loading = 2
local Loaded = 3

function GameLangFont:ctor()
	if not LangSettings.instance:isOverseas() then
		return
	end

	self._hasInit = true
	self._loadStatus = NotLoad
	self._SettingStatus = NotLoad
	self._registerFontDict = {}
	self._id2TmpFontUrlDict = {}
	self._id2TextFontUrlDict = {}
	self._id2TmpFontAssetDict = {}
	self._id2TextFontAssetDict = {}

	self:_loadFontAsset()
	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(self._callback, self)
end

function GameLangFont:_callback(langFont, isRegister)
	if isRegister then
		self._registerFontDict[langFont] = true

		if self._loadStatus == Loaded then
			self:_setFontAsset(langFont)
		else
			self:_loadFontAsset()
		end
	else
		self._registerFontDict[langFont] = nil

		local tmpTextId = langFont.id

		if tmpTextId > 0 and (not string.nilorempty(langFont.str1) or langFont.instanceMaterial) then
			local tmpText = langFont.tmpText
			local fontAsset = self._id2TmpFontAssetDict[tmpTextId]

			if tmpText and (fontAsset == nil or fontAsset.material ~= tmpText.fontSharedMaterial) then
				gohelper.destroy(tmpText.fontSharedMaterial)
			end
		end
	end
end

function GameLangFont:changeFontAsset(callback, callbackObj)
	if not self._hasInit then
		if callback then
			callback(callbackObj)
		end

		return
	end

	self._loadStatus = NotLoad
	self._loadFontAssetCallback = callback
	self._loadFontAssetcallbackObj = callbackObj

	self:_loadFontAsset()
end

function GameLangFont:_loadFontAsset()
	if self._loadStatus ~= NotLoad then
		return
	end

	self._loadStatus = Loading

	local fontUrlList = {}

	self._id2TmpFontUrlDict = {}
	self._id2TextFontUrlDict = {}

	local lang = LangSettings.shortcutTab[GameConfig:GetCurLangType()]
	local config = lua_setting_lang.configDict[lang]

	for i = 1, 2 do
		local fontname = "fontasset" .. i

		if not string.nilorempty(config[fontname]) then
			local url = string.format("font/meshpro/%s.asset", config[fontname])

			table.insert(fontUrlList, url)

			self._id2TmpFontUrlDict[i] = url
		end

		fontname = "textfontasset" .. i

		if not string.nilorempty(config["textfontasset" .. i]) then
			local url = string.format("font/%s", config[fontname])

			table.insert(fontUrlList, url)

			self._id2TextFontUrlDict[i] = url
		end
	end

	if self._loader then
		self._loader:dispose()
	end

	self._loader = MultiAbLoader.New()

	self._loader:setPathList(fontUrlList)
	self._loader:startLoad(self._onFontLoaded, self)
end

function GameLangFont:_onFontLoaded()
	self._loadStatus = Loaded
	self._id2TmpFontAssetDict = {}
	self._id2TextFontAssetDict = {}

	local fontAssetDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(fontAssetDict) do
		for id, url1 in pairs(self._id2TmpFontUrlDict) do
			if url1 == url then
				self._id2TmpFontAssetDict[id] = assetItem:GetResource()
			end
		end

		for id, url1 in pairs(self._id2TextFontUrlDict) do
			if url1 == url then
				self._id2TextFontAssetDict[id] = assetItem:GetResource()
			end
		end
	end

	for langfont, value in pairs(self._registerFontDict) do
		self:_setFontAsset(langfont)
	end

	if self._loadFontAssetCallback then
		self._loadFontAssetCallback(self._loadFontAssetcallbackObj)
	end

	self._loadFontAssetCallback = nil
	self._loadFontAssetcallbackObj = nil
end

function GameLangFont:_setFontAsset(langFont)
	if gohelper.isNil(langFont) then
		return
	end

	local tmpTextId = langFont.id

	if tmpTextId > 0 then
		local tmpText = langFont.tmpText

		if tmpText then
			local fontAsset = self._id2TmpFontAssetDict[tmpTextId]

			if fontAsset then
				tmpText.font = fontAsset
			end

			local outlineColorHex = langFont.str1

			if not string.nilorempty(outlineColorHex) or not string.nilorempty(langFont.str2) then
				langFont.instanceMaterial = true
			end

			local fontSharedMaterial = tmpText.fontSharedMaterial

			if langFont.instanceMaterial then
				fontSharedMaterial = UnityEngine.Object.Instantiate(tmpText.fontSharedMaterial)
			end

			if not string.nilorempty(outlineColorHex) then
				local color = SLFramework.UGUI.GuiHelper.ParseColor(outlineColorHex)
				local color32 = UnityEngine.Color32.New(color.r * 255, color.g * 255, color.b * 255, color.a * 255)

				fontSharedMaterial:EnableKeyword("OUTLINE_ON")

				tmpText.outlineColor = color32
				tmpText.outlineWidth = langFont.int1 / 1000
			end

			if not string.nilorempty(langFont.str2) then
				local underlayInfo = string.split(langFont.str2, "|||")
				local color = SLFramework.UGUI.GuiHelper.ParseColor(underlayInfo[1])

				fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
				fontSharedMaterial:SetFloat("_UnderlayOffsetX", tonumber(underlayInfo[2]))
				fontSharedMaterial:SetFloat("_UnderlayOffsetY", tonumber(underlayInfo[3]))
				fontSharedMaterial:SetFloat("_UnderlayDilate", tonumber(underlayInfo[4]))
				fontSharedMaterial:SetFloat("_UnderlaySoftness", tonumber(underlayInfo[5]))
				fontSharedMaterial:SetColor("_UnderlayColor", color)
			end

			tmpText.fontSharedMaterial = fontSharedMaterial
		else
			local TMPInputField = langFont.tmpInputText

			if TMPInputField then
				local fontAsset = self._id2TmpFontAssetDict[tmpTextId]

				if fontAsset then
					TMPInputField.fontAsset = fontAsset
				end
			end

			local tmpTextScene = langFont.tmpTextScene

			if tmpTextScene then
				local fontAsset = self._id2TmpFontAssetDict[tmpTextId]

				if fontAsset then
					tmpTextScene.font = fontAsset
				end
			end
		end

		return
	end

	local textId = langFont.textId

	if textId > 0 then
		local text = langFont.text

		if text then
			local fontAsset = self._id2TextFontAssetDict[textId]

			if fontAsset then
				text.font = fontAsset
			end
		end
	end
end

function GameLangFont:ControlDoubleEn()
	if not self._hasInit then
		return
	end

	local root = ViewMgr.instance:getUIRoot()

	self.languageMgr = SLFramework.LanguageMgr.Instance

	local arrays = root:GetComponentsInChildren(typeof(SLFramework.LangCaptions), true)

	self._comps = {}

	ZProj.AStarPathBridge.ArrayToLuaTable(arrays, self._comps)
	TaskDispatcher.runRepeat(self._onRepectSetEnActive, self, 0)
end

function GameLangFont:_onRepectSetEnActive()
	for i = 1, 100 do
		if #self._comps > 0 then
			local captionsComInfo = self._comps[#self._comps]

			table.remove(self._comps, #self._comps)

			if not gohelper.isNil(captionsComInfo) then
				self.languageMgr:ApplyLangCaptions(captionsComInfo)
			end
		end
	end

	if #self._comps == 0 then
		self:_stopSetEnActive()
	end
end

function GameLangFont:_stopSetEnActive()
	TaskDispatcher.cancelTask(self._onRepectSetEnActive, self)

	if self._comps then
		self._comps = nil
	end
end

return GameLangFont
