-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/cell/MainPerformEditorVec3Cell.lua

module("logic.extensions.mainui.view.performeditor.cell.MainPerformEditorVec3Cell", package.seeall)

local M = class("MainPerformEditorVec3Cell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._valueChangeHandler = Handler.New()
	self._xChangeHandler = Handler.New()
	self._yChangeHandler = Handler.New()
	self._zChangeHandler = Handler.New()
end

function M:buildUI()
	self._vecCellX = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._go, "x"), EditorTextInputVecCell)
	self._vecCellY = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._go, "y"), EditorTextInputVecCell)
	self._vecCellZ = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._go, "z"), EditorTextInputVecCell)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._vecCellX:init()
	self._vecCellY:init()
	self._vecCellZ:init()
	self._vecCellX:setValueListener(self._onValueChangeX, self)
	self._vecCellY:setValueListener(self._onValueChangeY, self)
	self._vecCellZ:setValueListener(self._onValueChangeZ, self)
end

function M:onExit()
	return
end

function M:_clearHandler()
	self._valueChangeHandler:clear()
	self._xChangeHandler:clear()
	self._yChangeHandler:clear()
	self._zChangeHandler:clear()
end

function M:reset()
	self:_clearHandler()
end

function M:_onValueChangeX(val)
	if self._listenValueChange then
		self._xChangeHandler:call(val)
		self._valueChangeHandler:call(self:getVec3())
	end
end

function M:_onValueChangeY(val)
	if self._listenValueChange then
		self._yChangeHandler:call(val)
		self._valueChangeHandler:call(self:getVec3())
	end
end

function M:_onValueChangeZ(val)
	if self._listenValueChange then
		self._zChangeHandler:call(val)
		self._valueChangeHandler:call(self:getVec3())
	end
end

function M:setValueListenerX(callBackFun, callBackObj)
	self._xChangeHandler:setListener(callBackFun, callBackObj)
end

function M:setValueListenerY(callBackFun, callBackObj)
	self._yChangeHandler:setListener(callBackFun, callBackObj)
end

function M:setValueListenerZ(callBackFun, callBackObj)
	self._zChangeHandler:setListener(callBackFun, callBackObj)
end

function M:setValueChangeListener(callBackFun, callBackObj)
	self._valueChangeHandler:setListener(callBackFun, callBackObj)
end

function M:setVec3(vec3)
	vec3 = vec3 or Vector3.zero
	self._listenValueChange = false

	self._vecCellX:setVal(vec3.x)
	self._vecCellY:setVal(vec3.y)
	self._vecCellZ:setVal(vec3.z)

	self._listenValueChange = true
end

function M:getVec3()
	return Vector3.New(self._vecCellX:getVal(), self._vecCellY:getVal(), self._vecCellZ:getVal())
end

return M
