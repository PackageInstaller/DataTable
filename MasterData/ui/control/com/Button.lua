-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\Button.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local Label = require("UI/Control/Com/Label")
local Image = require("UI/Control/Com/Image")
local UIConst = UIConst
local strClassName = "Button"
local Button = Class(strClassName, UIBaseControl)
local BTN_CLICK_CD = 0.2

function Button:ctor(parent, path, textPath, canEmoji)
	if textPath ~= nil then
		local p = textPath

		if path ~= "" then
			p = path .. "/" .. p
		end

		self._text = Label(parent, p, canEmoji)
	end
end

function Button:_getControlType()
	return UIConst.ControlTypeButton
end

function Button:getComObj()
	if self._obj == nil then
		local obj = Button.super.getComObj(self)
	end

	return self._obj
end

function Button:getEnable()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.interactable
	else
		return false
	end
end

function Button:setEnable(v)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.interactable = v
	end
end

function Button:setText(v)
	if self._text ~= nil then
		self._text:setText(v)
	end
end

function Button:getText()
	return self._text and self._text:getText() or ""
end

function Button:setFontColor(color)
	if self._text ~= nil then
		self._text:setFontColor(color)
	end
end

function Button:setImage(filePath, spriteName)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetImageSprite(obj.image, filePath, spriteName, true)
	end
end

function Button:getImageSize()
	local size = self:getComObj().image.rectTransform.rect

	return {
		width = size.width,
		height = size.height
	}
end

function Button:setImageSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.image.rectTransform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function Button:interruptHoldEvent()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():InterruptHoldClick(obj)
	end
end

function Button:addEventClick(eventFunc, clickCD)
	local obj = self:getComObj()

	if obj ~= nil then
		if clickCD == nil then
			clickCD = BTN_CLICK_CD
		end

		self:getController():AddButtonOnClick(obj, self:_packageCallback(eventFunc), clickCD)
	end
end

function Button:addEventClickCD(eventFunc, cd, noticeMsg, serverTimeStamp)
	local obj = self:getComObj()

	if obj ~= nil then
		local clickCD = cd or BTN_CLICK_CD
		local msg = noticeMsg or Lang.get(61044)

		self.lastClickTime = serverTimeStamp or 0

		local function func(mParent, mySelf)
			local curTime = ClientUtils.getServerTime()
			local timeDelta = curTime - self.lastClickTime

			if timeDelta >= clickCD then
				if eventFunc(mParent, mySelf) then
					self.lastClickTime = curTime
				end
			else
				local timeDistance = clickCD - timeDelta
				local finalMsg = utils.format(Lang.get(61811), msg, timeDistance)

				MsgManager.notice(finalMsg)
			end
		end

		self:getController():AddButtonOnClick(obj, self:_packageCallback(func), 0)
	end
end

function Button:clearButtonCd()
	if self.lastClickTime then
		self.lastClickTime = 0
	end
end

function Button:clearEventClick()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearButtonOnClick(obj)
	end
end

function Button:setHoldDelayTime(delayTime)
	if VersionUtils.getEngineVersion() >= 113808 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():SetHoldDelayTime(obj, delayTime)
		end
	end
end

function Button:addEventHoldClick(eventFunc)
	if VersionUtils.getEngineVersion() >= 112457 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():AddButtonOnHoldClick(obj, self:_packageCallback(eventFunc))
		end
	end
end

function Button:clearEventHoldClick()
	if VersionUtils.getEngineVersion() >= 112457 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():ClearButtonOnHoldClick(obj)
		end
	end
end

function Button:addEventHoldPointerUp(eventFunc)
	if VersionUtils.getEngineVersion() >= 112457 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():AddButtonOnHoldPointerUp(obj, self:_packageCallback(eventFunc))
		end
	end
end

function Button:clearEventHoldPointerUp()
	if VersionUtils.getEngineVersion() >= 112457 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():ClearButtonOnHoldPointerUp(obj)
		end
	end
end

return Button
