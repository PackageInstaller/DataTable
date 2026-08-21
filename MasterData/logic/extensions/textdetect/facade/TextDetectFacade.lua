-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/textdetect/facade/TextDetectFacade.lua

module("logic.extensions.textdetect.facade.TextDetectFacade", package.seeall)

local M = class("TextDetectFacade", BaseFacade)

function M:ctor()
	self._inputFieldAdapter = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SENSITIVE_WORDS_SCREEN, self._handleSensitiveWordsReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SENSITIVE_WORDS_SCREEN, self._handleSensitiveWordsReply, self)
	end
end

function M:registTextDetect(inputFieldAdapter, textType, ensureHandlerFunc, ensureHandler)
	self._inputFieldAdapter = inputFieldAdapter
	self._ensureHandlerFunc = ensureHandlerFunc
	self._ensureHandler = ensureHandler
	self._textType = textType

	self:_setEvent(true)
end

function M:removeTextDetect()
	self:_setEvent(false)

	self._inputFieldAdapter = nil
	self._ensureHandlerFunc = nil
	self._ensureHandler = nil
	self._textType = nil
end

function M:_handleSensitiveWordsReply(e, illegal, filteredText, textType)
	if illegal ~= 0 then
		if textType == GameEnum.TextTypeEnum.Name then
			FloatWordMgr.instance:show(lang("tip_name_error_1"))
		elseif textType == GameEnum.TextTypeEnum.Nickname then
			if illegal == 6 then
				FloatWordMgr.instance:show(lang("tip_name_error_1"))
			elseif illegal ~= 0 then
				FloatWordMgr.instance:show(lang("tip_name_error_2"))
			end
		elseif textType == GameEnum.TextTypeEnum.Chat then
			self._inputFieldAdapter:SetText(filteredText)
		elseif textType == GameEnum.TextTypeEnum.Sign then
			FloatWordMgr.instance:show(lang("tip_name_error_3"))
		end
	end

	if self._ensureHandlerFunc ~= nil then
		if self._ensureHandler ~= nil then
			self._ensureHandlerFunc(self._ensureHandler, illegal, filteredText)
		else
			self._ensureHandlerFunc(illegal, filteredText)
		end
	end
end

function M:sendDetectTextRequest()
	local value = self._inputFieldAdapter:GetText()

	TextDetectAgent.instance:sendDetectTextRequest(value, self._textType)
end

M.instance = M.New()

return M
