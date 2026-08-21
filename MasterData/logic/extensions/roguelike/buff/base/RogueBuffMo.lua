-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/base/RogueBuffMo.lua

module("logic.extensions.roguelike.buff.base.RogueBuffMo", package.seeall)

local M = class("RogueBuffMo")

function M:ctor(buffCO, unit)
	self._buffCO = buffCO
	self._unit = unit
	self._id = 0

	if buffCO.clientProgram == "" then
		return
	end

	self._clientProgram = buffCO.clientProgram
	self._buffHandler = nil

	if RogueBuffClsUtil.getHandlerCls(buffCO.clientProgram) then
		self._buffHandler = RogueBuffClsUtil.getHandlerCls(buffCO.clientProgram):createInstance()
	end
end

function M:getBuffHandler()
	return self._buffHandler
end

function M:setBuffHandler(handlerName)
	if self._buffHandler ~= nil then
		self._buffHandler:onRemove(self._unit, self)
	end

	self._buffHandler = RogueBuffClsUtil.getHandlerCls(handlerName):createInstance()

	self._buffHandler:onAdd(self._unit, self)
end

function M:reset()
	self._buffCO = false
	self._id = 0
	self._buffHandler = nil
end

function M:destroy()
	self._buffCO = nil
	self._id = nil
	self._buffHandler = nil
end

function M:setId(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:getBuffCO()
	return self._buffCO
end

function M:getParams()
	return self._buffCO.params
end

function M:getClientProgram()
	return self._clientProgram
end

return M
