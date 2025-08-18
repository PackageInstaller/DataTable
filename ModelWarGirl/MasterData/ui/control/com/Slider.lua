-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Slider.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local Label = require("UI/Control/Com/Label")
local UIConst = UIConst
local strClassName = "Slider"
local Slider = Class(strClassName, UIBaseControl)

Slider.MIN_CHANGE_THRESHOLD = 0.01
Slider.MIN_DURATION_THRESHOLD = 0.05

function Slider:ctor(parent, path, textPath)
	if textPath ~= nil then
		local p = textPath

		if path ~= "" then
			p = path .. "/" .. p
		end

		self._text = Label(parent, p)
	end
end

function Slider:_getControlType()
	return UIConst.ControlTypeSlider
end

function Slider:getEnable()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.interactable
	else
		return false
	end
end

function Slider:setEnable(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.interactable = v
	end
end

function Slider:setText(v)
	if self._text ~= nil then
		self._text:setText(v)
	end
end

function Slider:getText()
	return self._text and self._text:getText() or ""
end

function Slider:setFontColor(color)
	if self._text ~= nil then
		self._text:setFontColor(color)
	end
end

function Slider:setValue(v, costTime, forReset, forceAni)
	local diffValue = -1

	if not forReset and self._cachedValue then
		diffValue = math.abs(self._cachedValue - v)

		if diffValue < Slider.MIN_CHANGE_THRESHOLD then
			return
		end
	end

	local obj = self:getComObj()

	if obj ~= nil then
		if self._isloading then
			self:getController():SetLoadingValue(obj, v)
		else
			if diffValue >= 0 and diffValue <= Slider.MIN_DURATION_THRESHOLD and not forceAni then
				costTime = 0
			end

			if costTime and costTime > 0 then
				local go = self:getGameObject()

				if go and go.activeInHierarchy then
					self:getController():SetSliderValue(obj, v, costTime or 0, 0.03)
				end
			else
				self:getController():SetSliderValue(obj, v, costTime or 0, 0.03)
			end
		end

		if costTime and costTime > 0.5 then
			self._cachedValue = nil
		else
			self._cachedValue = v
		end
	end
end

function Slider:getValue()
	local obj = self:getComObj()

	if obj ~= nil then
		self._cachedValue = obj.value

		return self._cachedValue
	end
end

function Slider:setFillImage(filePath, spriteName)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetSliderFillImage(obj, filePath, spriteName)
	end
end

function Slider:setLoadingMode(finishCallback, waitRate, runWaitTime)
	local obj = self:getComObj()

	if obj ~= nil then
		self._isloading = true
		waitRate = waitRate or 0.7
		runWaitTime = runWaitTime or 3

		self:getController():InitLoadingBar(obj, waitRate, runWaitTime, finishCallback)
	end
end

function Slider:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddSliderOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function Slider:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearSliderOnValueChanged(obj)
	end
end

return Slider
