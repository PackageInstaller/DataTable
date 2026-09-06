-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/controller/ConditionValidator.lua

module("logic.extensions.mission.controller.ConditionValidator", package.seeall)

local ConditionValidator = class("ConditionValidator", BaseController)
local priority = {
	["!"] = 3,
	["("] = 4,
	["|"] = 1,
	["&"] = 2,
	[")"] = 4
}

function ConditionValidator:ctor()
	self._stack = Stack.New()
	self._list = {}
end

function ConditionValidator:_isExistOperator(inputStr)
	if string.nilorempty(inputStr) then
		return false
	end

	if string.find(inputStr, "[&|!]") then
		return true
	else
		return false
	end
end

function ConditionValidator:isMatch(inputStr, handler, ...)
	if not handler then
		printError("没有传入条件处理 handler")

		return true
	end

	local arg = {
		...
	}

	if not self:_isExistOperator(inputStr) then
		return handler(inputStr, unpack(arg))
	end

	local index = 1
	local conditionList = {}

	for w in string.gmatch(inputStr, "[^&|!%(%)]+") do
		conditionList[index] = w
		index = index + 1
	end

	local s = string.gsub(inputStr, "[^&|!%(%)]+", "0")
	local strList = {}
	local m = 1

	for i = 1, #s do
		local v = string.sub(s, i, i)

		if v == "0" then
			table.insert(strList, conditionList[m])

			m = m + 1
		elseif self:_isOperator(v) then
			table.insert(strList, v)
		end
	end

	return (self:_calculateResult(strList, handler, ...))
end

function ConditionValidator:getAllConditions(inputStr)
	local conditionList = {}

	for w in string.gmatch(inputStr, "[^&|!%(%)]+") do
		conditionList[#conditionList + 1] = w
	end

	return conditionList
end

function ConditionValidator:_calculateResult(strList, handler, ...)
	self._stack:clear()
	table.clear(self._list)
	self:_primaryToPostfixExpressions(strList)

	local arg = {
		...
	}
	local stack = Stack.New()

	for i, v in ipairs(self._list) do
		if v == "&" or v == "|" then
			local condition2 = stack:pop()
			local condition1 = stack:pop()
			local result = false

			if v == "&" then
				result = condition1 and condition2
			elseif v == "|" then
				result = condition1 or condition2
			end

			stack:push(result)
		elseif v == "!" then
			local condition1 = stack:pop()
			local result = not condition1

			stack:push(result)
		else
			local result = handler(v, unpack(arg))

			stack:push(result)
		end
	end

	return (stack:pop())
end

function ConditionValidator:_isOperator(v)
	return v == "&" or v == "|" or v == "!" or v == "(" or v == ")"
end

function ConditionValidator:_primaryToPostfixExpressions(strList)
	for i, v in ipairs(strList) do
		if v == "(" then
			self._stack:push(v)
		elseif v == "&" or v == "|" or v == "!" then
			if self._stack:isEmpty() then
				self._stack:push(v)
			elseif priority[self._stack:peek()] < priority[v] then
				self._stack:push(v)
			else
				while not self._stack:isEmpty() do
					local item = self._stack:peek()

					if item == "(" then
						break
					elseif priority[item] >= priority[v] then
						table.insert(self._list, self._stack:pop())
					else
						break
					end
				end

				self._stack:push(v)
			end
		elseif v == ")" then
			while not self._stack:isEmpty() do
				local item = self._stack:peek()

				if item == "(" then
					self._stack:pop()
				else
					table.insert(self._list, self._stack:pop())
				end
			end
		else
			table.insert(self._list, v)
		end
	end

	while not self._stack:isEmpty() do
		table.insert(self._list, self._stack:pop())
	end
end

ConditionValidator.instance = ConditionValidator.New()

return ConditionValidator
