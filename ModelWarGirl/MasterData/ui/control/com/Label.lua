-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Label.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local ResColor = require("ClientData/ResColor")
local VersionUtils = require("System/VersionUtils")
local UIConst = UIConst
local strClassName = "Label"
local Label = Class(strClassName, UIBaseControl)

Label.JumpDisplayMode = {
	TIME = 2,
	RAW = 0,
	SHORT_NUM = 1
}
Label.JumpAttachType = {
	DAY_POSTFIX = 4,
	COMMON_PREFIX = 1,
	SHORT_NUM_POSTFIX = 3,
	COMMON_POSTFIX = 2,
	HHMMSS_POSTFIX = 5
}

function Label:ctor(parent, path, canEmoji)
	self.mCanEmoji = canEmoji
	self.localizationComponent = self:getController():GetCom(UIConst.ControlTypeLocalizationComponent, self.mPath)
end

function Label:_getControlType(canEmoji)
	if canEmoji ~= nil and canEmoji then
		return UIConst.ControlTypeEmojiText
	else
		return UIConst.ControlTypeText
	end
end

function Label:setText(v, needJump)
	if needJump then
		local jumpObj = self:getJumpObj(true)

		if jumpObj then
			jumpObj:SetValue(v, true)
		end
	elseif self._jumpCompount ~= nil and type(v) == "number" then
		self._jumpCompount:SetValue(v, false)
	else
		if self._jumpCompount ~= nil then
			self._jumpCompount:StopJump()
		end

		if self.localizationComponent then
			self.localizationComponent.close = true
		end

		local obj = self:getComObj()

		if obj ~= nil then
			if VersionUtils.hasAbilityThai() then
				local curLanguage = Framework.Tools.LuaToolkit.GetCurLanguage()

				if RegionUtils.isSEA() and curLanguage == "th" then
					v = Framework.Tools.LuaToolkit.ThaiTextModify(obj, v)
				end
			end

			obj.text = v

			if VersionUtils.isLabelCheck() then
				Framework.Tools.LuaToolkit.CheckText(obj)
			end
		end
	end
end

function Label:setAvgText(v, interval)
	if self.localizationComponent then
		self.localizationComponent.close = true
	end

	local obj = self:getComObj()

	if obj ~= nil then
		interval = interval or 0.05

		self:getController():ShowAVGText(obj, v, interval)
	end
end

function Label:stopAvgText()
	local obj = self:getComObj()

	if obj ~= nil then
		return self:getController():StopAVGText(obj)
	end
end

function Label:setFontSize(fontSize)
	if self.fontSize and self.fontSize == fontSize then
		return
	end

	local obj = self:getComObj()

	if obj ~= nil then
		self.fontSize = fontSize

		return self:getController():SetFontSize(obj, fontSize)
	end
end

function Label:setTextWithColor(v, color)
	local colorData = ResColor[color]

	if not colorData then
		self:setText(v)
	else
		local shaderd = string.format("<color=#%s>%s</color>", colorData.ff, v)

		self:setText(shaderd)
	end
end

function Label:setTextWithColorHexadecimal(v, hex)
	if not hex then
		self:setText(v)
	else
		local shaderd = string.format("<color=#%s>%s</color>", hex, v)

		self:setText(shaderd)
	end
end

function Label:getText()
	return self:getComObj().text
end

function Label:setAlign(v)
	local obj = self:getComObj()

	if obj ~= nil and UnityEngine.TextAnchor then
		obj.alignment = v or UIConst.TXTALIGN_UL
	end
end

function Label:setColorByRGBA(r, g, b, a)
	local obj = self:getComObj()

	if obj ~= nil then
		a = a or 1
		obj.color = UnityEngine.Color(r, g, b, a)
	end
end

function Label:setFontColor(color)
	self:setObjColor(color)
end

function Label:getWidth()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.preferredWidth
	else
		return 0
	end
end

function Label:getHeight()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.preferredHeight
	else
		return 0
	end
end

function Label:setSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.rectTransform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function Label:getSize()
	local size = self:getComObj().rectTransform.rect

	return {
		width = size.width,
		height = size.height
	}
end

function Label:addEventButtonClick(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil and self.mCanEmoji then
		self:getController():AddEmojiButtonClick(obj, self:_packageCallback(eventFunc))
	end
end

function Label:clearEventButtonClick()
	local obj = self:getComObj()

	if obj ~= nil and self.mCanEmoji then
		self:getController():ClearEmojiButtonOnClick(obj)
	end
end

function Label:addEventLinkClick(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil and self.mCanEmoji then
		self:getController():AddEmojiLinkClick(obj, self:_packageCallback(eventFunc))
	end
end

function Label:clearEventLinkClick()
	local obj = self:getComObj()

	if obj ~= nil and self.mCanEmoji then
		self:getController():ClearEmojiLinkClick(obj)
	end
end

function Label:getJumpObj(defValue)
	if self._jumpCompount == nil then
		self._jumpCompount = self:getController():GetCom(UIConst.ControlTypeTextNumberJumper, self.mPath)

		if self._jumpCompount and defValue then
			local value = tonumber(self:getText()) or 0

			self._jumpCompount:SetValue(value, false)
		end
	end

	return self._jumpCompount
end

function Label:jumpTo(fromValue, toValue, duration)
	local jumpObj = self:getJumpObj()

	if jumpObj then
		duration = duration or jumpObj.JumpDuration

		jumpObj:SetValueBeginToEnd(fromValue, toValue, duration)
	end
end

function Label:setJumpDisplayMode(mode)
	local jumpObj = self:getJumpObj()

	if jumpObj then
		jumpObj:SetDisplayMode(mode)
	end
end

function Label:setJumpPostfixByMode(postfixType, postfix)
	local jumpObj = self:getJumpObj()

	if jumpObj then
		jumpObj:SetPostfixByType(postfixType, postfix)
	end
end

function Label:limitTextLength(length)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():LimitTextLength(obj, length)
	end
end

return Label
