-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\ScrollView.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local Vector2 = Vector2
local RectTransform = typeof(UnityEngine.RectTransform)
local UIConst = UIConst
local strClassName = "ScrollView"
local ScrollView = Class(strClassName, UIBaseControl)

function ScrollView:ctor(parent, path)
	return
end

function ScrollView:_getControlType()
	return UIConst.ControlTypeScrollRect
end

function ScrollView:setContentSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.content.sizeDelta = Vector2(width, height)
	end
end

function ScrollView:getContentSize()
	local obj = self:getComObj()

	if obj ~= nil then
		return {
			obj.content.sizeDelta.x,
			obj.content.sizeDelta.y
		}
	end
end

function ScrollView:setSize(width, height)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.gameObject.rectTransform.sizeDelta = UnityEngine.Vector2(width, height)
	end
end

function ScrollView:setScrollEnable(enable)
	local obj = self:getComObj()

	if obj ~= nil then
		obj.enabled = enable
	end
end

function ScrollView:getSize()
	local obj = self:getComObj()

	if obj ~= nil then
		local size = obj.transform.sizeDelta

		return {
			width = size.x,
			height = size.y
		}
	end
end

function ScrollView:getVerticalValue()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.verticalScrollbar.value
	end

	return -1
end

function ScrollView:getHorizontalValue()
	local obj = self:getComObj()

	if obj ~= nil then
		return obj.horizontalScrollbar.value
	end

	return -1
end

function ScrollView:isScroll()
	local obj = self:getComObj()

	if obj ~= nil then
		local tran = obj.transform
		local content = obj.content

		return obj.horizontal and tran.sizeDelta.x < content.sizeDelta.x or obj.vertical and tran.sizeDelta.y < content.sizeDelta.y
	end
end

function ScrollView:gotoTop()
	if not self.contentTran then
		local obj = self:getComObj()

		if obj ~= nil then
			self.contentTran = obj.transform:Find("Viewport/Content")

			if not self.contentTran then
				self.contentTran = obj.transform:Find("Content")
			end
		end
	end

	if self.contentTran then
		local contentRT = self.contentTran:GetComponent(RectTransform)
		local tempPos = contentRT.anchoredPosition3D

		tempPos.y = 0
		contentRT.anchoredPosition3D = tempPos
	end
end

function ScrollView:gotoVerticalEnd()
	local obj = self:getComObj()

	if obj ~= nil then
		self:setContentY(self:getVerticalEndPosY())
	end
end

function ScrollView:getVerticalEndPosY()
	local obj = self:getComObj()

	if obj ~= nil then
		if obj.content.sizeDelta.y > obj.transform.sizeDelta.y then
			return obj.content.sizeDelta.y - obj.transform.sizeDelta.y
		else
			return 0
		end
	end
end

function ScrollView:gotoObj(tgtObj, correctY)
	if tgtObj and tgtObj.getPosition then
		local obj = self:getComObj()
		local curPos = obj.content.anchoredPosition

		curPos.y = -tgtObj:getPosition().y + (correctY or 0)
		obj.content.anchoredPosition = curPos
	end
end

function ScrollView:gotoIndexVertical(index, cellSize)
	local obj = self:getComObj()

	if obj then
		local curPos = obj.content.anchoredPosition
		local size = obj.transform.sizeDelta

		curPos.y = index * cellSize - size.y
		obj.content.anchoredPosition = curPos
	end
end

function ScrollView:setContentY(y)
	local obj = self:getComObj()
	local curPos = obj.content.anchoredPosition

	curPos.y = y
	obj.content.anchoredPosition = curPos
end

function ScrollView:setContentX(x)
	local obj = self:getComObj()
	local curPos = obj.content.anchoredPosition

	curPos.x = x
	obj.content.anchoredPosition = curPos
end

function ScrollView:stopMovement()
	local obj = self:getComObj()

	if obj then
		obj:StopMovement()
	end
end

function ScrollView:cancelScroll()
	local obj = self:getComObj()

	if obj then
		obj.vertical = false
		obj.horizontal = false
	end
end

function ScrollView:openScroll(vertical, horizontal)
	local obj = self:getComObj()

	if obj then
		obj.vertical = vertical or false
		obj.horizontal = horizontal or false
	end
end

function ScrollView:getContentY()
	local obj = self:getComObj()
	local curPos = obj.content.anchoredPosition

	return curPos.y
end

function ScrollView:addEventValueChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddScrollRectOnValueChanged(obj, self:_packageCallback(eventFunc))
	end
end

function ScrollView:clearEventValueChanged()
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():ClearScrollRectOnValueChanged(obj)
	end
end

function ScrollView:addScrollCorrectOnChanged(eventFunc)
	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():AddScrollCorrectOnChanged(obj, self:_packageCallback(eventFunc))
	end
end

function ScrollView:scrollToCorrectPage(page, noAni)
	page = page or 1
	noAni = noAni or false

	local obj = self:getComObj()

	if obj ~= nil then
		self:getController():SetScrollCorrectPage(obj, page, noAni)
	end
end

function ScrollView:setScrollCorrectLimitPos(minPos, maxPos)
	if VersionUtils.getEngineVersion() >= 114324 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():SetScrollCorrectLimitPos(obj, minPos, maxPos)
		end
	end
end

function ScrollView:clearScrollCorrectLimitPos()
	if VersionUtils.getEngineVersion() >= 114324 then
		local obj = self:getComObj()

		if obj ~= nil then
			self:getController():ClearScrollCorrectLimitPos(obj)
		end
	end
end

return ScrollView
