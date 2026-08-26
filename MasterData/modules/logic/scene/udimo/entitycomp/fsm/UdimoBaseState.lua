-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/UdimoBaseState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.UdimoBaseState", package.seeall)

local UdimoBaseState = class("UdimoBaseState")

function UdimoBaseState:ctor(name)
	self.name = name

	self:clear()
end

function UdimoBaseState:register(fsm)
	self.fsm = fsm
	self._isClear = false
end

function UdimoBaseState:updateParam(param)
	self.param = param
end

function UdimoBaseState:clear()
	self._isClear = true

	self:onClear()

	self.fsm = nil
end

function UdimoBaseState:onFSMStart()
	return
end

function UdimoBaseState:onEnter(param)
	return
end

function UdimoBaseState:onExit()
	return
end

function UdimoBaseState:onFSMStop()
	return
end

function UdimoBaseState:onClear()
	return
end

return UdimoBaseState
