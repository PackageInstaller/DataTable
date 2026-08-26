-- chunkname: @modules/ugui/uieffect/UIEffectManager.lua

module("modules.ugui.uieffect.UIEffectManager", package.seeall)

local UIEffectManager = class("UIEffectManager")

function UIEffectManager:ctor()
	self._effectDic = {}
end

function UIEffectManager:addEffect(targetGo, effectPath, rtWidth, rtHeight, rawImageWidth, rawImageHeight, loadcallback, callbackTarget)
	if gohelper.isNil(targetGo) then
		return
	end

	self._loadcallback = loadcallback
	self._callbackTarget = callbackTarget

	if not rtWidth or not rtHeight then
		logError(string.format("addEffect rt size error rtWidth:%s,rtHeight:%s", rtWidth, rtHeight))

		return
	end

	local effectUnit = MonoHelper.addNoUpdateLuaComOnceToGo(targetGo, UIEffectUnit)

	if effectUnit then
		effectUnit:Refresh(targetGo, effectPath, rtWidth, rtHeight, rawImageWidth, rawImageHeight)
	end

	AudioEffectMgr.instance:playAudioByEffectPath(effectPath)
end

function UIEffectManager:_getEffect(effectPath, width, height, rawImage)
	self._effectDic[effectPath] = self._effectDic[effectPath] or {}

	local key = string.format("%s_%s", width, height)
	local uiEffectLoader = self._effectDic[effectPath][key]

	if not uiEffectLoader then
		uiEffectLoader = UIEffectLoader.New()

		uiEffectLoader:Init(effectPath, width, height)

		self._effectDic[effectPath][key] = uiEffectLoader
	end

	uiEffectLoader:getEffect(rawImage, self._loadcallback, self._callbackTarget)
end

function UIEffectManager:getEffectGo(effectPath, width, height)
	if not self._effectDic[effectPath] then
		return
	end

	local key = string.format("%s_%s", width, height)

	return self._effectDic[effectPath][key]:getEffectGo()
end

function UIEffectManager:_putEffect(effectPath, width, height)
	if not self._effectDic[effectPath] then
		return
	end

	local key = string.format("%s_%s", width, height)
	local uiEffectLoader = self._effectDic[effectPath][key]

	if uiEffectLoader then
		uiEffectLoader:ReduceRef()
	end
end

function UIEffectManager:_delEffectLoader(effectPath, width, height)
	if not self._effectDic[effectPath] then
		return
	end

	local key = string.format("%s_%s", width, height)

	self._effectDic[effectPath][key] = nil
end

function UIEffectManager:getUIEffect(gameObject, type)
	if not gameObject then
		return nil
	end

	local tmp = gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if tmp then
		logError("TextMeshPro 不能和 UIEffect 一起使用")

		return nil
	end

	return gohelper.onceAddComponent(gameObject, type)
end

UIEffectManager.instance = UIEffectManager.New()

return UIEffectManager
