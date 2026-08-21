-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/AirUnitBase.lua

module("logic.extensions.airworkshop.flow.defflow.unit.AirUnitBase", package.seeall)

local M = class("AirUnitBase", ReusableUnitBase)
local kOnInitFinishFuncName = "onInitFinish"
local kOnBeforeResetFuncName = "onBeforeReset"

function M:setActive(isActive)
	goutil.setActive(self.go, isActive)
end

function M:dispatchCompInitFinish()
	self:_executeCompFunc(kOnInitFinishFuncName)
end

return M
