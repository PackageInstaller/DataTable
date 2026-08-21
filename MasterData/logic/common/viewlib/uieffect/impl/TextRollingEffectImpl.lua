-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/impl/TextRollingEffectImpl.lua

module("logic.common.viewlib.uieffect.impl.TextRollingEffectImpl", package.seeall)

local TextRollingEffectImpl = class("TextRollingEffectImpl", UIEffectBase)

function TextRollingEffectImpl:setFormatPattern(formatPattern)
	self._formatPattern = formatPattern
end

function TextRollingEffectImpl:setValue(value)
	if not self:checkUIValid() then
		return
	end

	self:_stopTween()

	self._value = checknumber(value)

	self:_setTextContent(self._value)
end

function TextRollingEffectImpl:rollToValue(value, duration, isInt)
	if not self:checkUIValid() then
		return
	end

	self._isInt = isInt
	value = checknumber(value)

	if self._value == 0 or self._value ~= value then
		self:_stopTween()

		self._tweenId = TweenUtil.tweenNumber(self._onTweenValue, self, self._value, value, duration or 0.5)
		self._value = value
	else
		self:setValue(value)
	end
end

function TextRollingEffectImpl:getValue()
	return self._value
end

function TextRollingEffectImpl:_buildUI(mainGO)
	self._txtContent = mainGO:GetComponent(goutil.Type_UIText) or mainGO:GetComponent(UIComponentType.TMPText)
	self._formatPattern = false
	self._value = 0
	self._tweenId = 0
	self._isInt = false
end

function TextRollingEffectImpl:_destroyUI()
	self:_stopTween()

	self._txtContent = nil
	self._formatPattern = false
	self._value = 0
	self._tweenId = 0
	self._isInt = false
end

function TextRollingEffectImpl:_onTweenValue(value)
	self:_setTextContent(value)
end

function TextRollingEffectImpl:_stopTween()
	if self._tweenId > 0 then
		TweenUtil.killTween(self._tweenId)

		self._tweenId = 0
	end
end

function TextRollingEffectImpl:_setTextContent(value)
	value = TextFormatter.formatNumber(value, self._isInt)

	if self._formatPattern then
		self._txtContent.text = string.format(self._formatPattern, value)
	else
		self._txtContent.text = value
	end
end

function TextRollingEffectImpl:getTextContent()
	return self._txtContent.text
end

function TextRollingEffectImpl:setText(value)
	self:_stopTween()

	self._txtContent.text = value
end

function TextRollingEffectImpl:setColor(colorStr)
	TextUtils.SetColor(self._txtContent, colorStr)
end

return TextRollingEffectImpl
