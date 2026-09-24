-- chunkname: @modules/logic/gm/view/command/GMServerCommandExtendBase.lua

module("modules.logic.gm.view.command.GMServerCommandExtendBase", package.seeall)

local GMServerCommandExtendBase = class("GMServerCommandExtendBase")

function GMServerCommandExtendBase:ctor(obj)
	self.obj = obj
end

function GMServerCommandExtendBase:initUI()
	return
end

function GMServerCommandExtendBase:getDefaultVal(cmd, index)
	local func = self[string.format("getDefaultVal_%s_%s", cmd, index)]
	local ret = ""

	if func then
		ret = func(self) or ""

		if type(ret) ~= "string" then
			ret = tostring(ret)
		end
	end

	return ret
end

function GMServerCommandExtendBase:getInput(name, index, lastInput)
	local func = self[string.format("getInput_%s_%s", name, index)]

	if func then
		local inputData = {}

		inputData.name = name
		inputData.index = index

		func(self, inputData, lastInput)

		return inputData
	end
end

function GMServerCommandExtendBase:getText(input)
	if type(input) == "table" then
		local func = self[string.format("getText_%s_%s", input.name, input.index)]

		if func then
			return func(self, input)
		end

		return ""
	end
end

function GMServerCommandExtendBase:onCommandClick(cmd)
	local func = self[string.format("onCommandClick_%s", cmd)]

	if func then
		func(self)
	end
end

return GMServerCommandExtendBase
