-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\NumKeyboard.lua

local NumKeyboard = Class("NumKeyboard", UIControls.Child)

function NumKeyboard:ctor()
	self.btnNum = {}

	for i = 1, 10 do
		local num = i - 1
		local btn = UIControls.Button(self, "KeyboardRoot/Btn" .. num)

		btn.mTgtNum = num

		btn:addEventClick(self.onNumClick)

		self.btnNum[num] = btn
	end

	self.btnDel = UIControls.Button(self, "BtnDel")

	self.btnDel:addEventClick(self.onDelClick)

	self.btnEnter = UIControls.Button(self, "BtnEnter")

	self.btnEnter:addEventClick(self.onEnterClick)

	self.btnClose = UIControls.Button(self, "BtnSensor")

	self.btnClose:addEventClick(self.onSensorClick)

	self.panelBoard = UIControls.Panel(self, "KeyboardRoot")
	self.size = self.panelBoard:getRectSize()
end

function NumKeyboard:show(callback, defValue, maxValue, minValue)
	if callback == nil then
		return
	end

	self._cb = callback
	self._max = maxValue
	self._min = math.max(minValue or 0, 0)

	local value = math.max(defValue or 0, minValue)

	self:_initContent(value)

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function NumKeyboard:_initContent(value)
	self._content = {}

	local num = 0

	while value > 0 do
		value, num = math.modf(value / 10)

		table.insert(self._content, 1, num * 10)
	end
end

function NumKeyboard:setMaxNotice(maxNotice)
	self.maxNotice = maxNotice
end

function NumKeyboard:_checkCallback()
	local num = 0

	for i, v in ipairs(self._content) do
		num = num * 10
		num = num + v
	end

	if num > self._max then
		if self.maxNotice then
			MsgManager.notice(self.maxNotice)
		end

		num = self._max

		self:_initContent(num)
	elseif num < self._min then
		num = self._min

		self:_initContent(num)
	end

	if self._cb then
		self._cb(num)
	end
end

function NumKeyboard:onNumClick(sender)
	table.insert(self._content, sender.mTgtNum)
	self:_checkCallback()
end

function NumKeyboard:onDelClick(sender)
	local num = #self._content

	if num > 0 then
		table.remove(self._content, num)
		self:_checkCallback()
	end
end

function NumKeyboard:setBottom(ui, distance)
	local pos = ui:getAbsPosition()

	self.panelBoard:setAbsPosition(pos.x, pos.y)

	local nowPos = self.panelBoard:getPosition()

	if distance then
		self.panelBoard:setPosition(nowPos.x, nowPos.y - 0.5 * self.size.height - distance)
	else
		self.panelBoard:setPosition(nowPos.x, nowPos.y - 250)
	end
end

function NumKeyboard:onEnterClick(sender)
	self:setVisible(false)
end

function NumKeyboard:onSensorClick()
	self:setVisible(false)
end

return NumKeyboard
