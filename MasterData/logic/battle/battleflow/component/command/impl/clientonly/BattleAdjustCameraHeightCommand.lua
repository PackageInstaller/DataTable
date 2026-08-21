-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAdjustCameraHeightCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAdjustCameraHeightCommand", package.seeall)

local M = class("BattleAdjustCameraHeightCommand", BattleTimingCommandBase)

function M:create(height, enableCamera)
	local cmd = M:createInstance()

	cmd:setHeight(height)
	cmd:setEnableCamera(enableCamera)

	return cmd
end

function M:onInit()
	self._height = 0
	self._enableCamera = false
end

function M:onClear()
	self._height = 0
	self._enableCamera = false
end

function M:execute(battleFlow, runningContext)
	if self._enableCamera then
		BattleScenePickerViewFacade.instance:setEnable(true, BattleConst.DefaultStateKey)
	end

	local time = BattleTime.getScaledTime(2)
	local cameraUnit = VirtualCameraMgr.instance:getActiveCamera()

	cameraUnit:doPosition(0, 0, self._height, time)
	self:startTimer(time)
end

function M:toString()
	return string.format("[adjust follow center command]")
end

function M:setHeight(height)
	self._height = height
end

function M:setEnableCamera(enableCamera)
	self._enableCamera = enableCamera
end

return M
