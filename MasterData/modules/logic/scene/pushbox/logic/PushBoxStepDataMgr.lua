-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxStepDataMgr.lua

module("modules.logic.scene.pushbox.logic.PushBoxStepDataMgr", package.seeall)

local PushBoxStepDataMgr = class("PushBoxStepDataMgr", UserDataDispose)

PushBoxStepDataMgr.StepType = {
	PushBox = 2,
	Move = 1
}

function PushBoxStepDataMgr:ctor(game_mgr)
	self:__onInit()

	self._game_mgr = game_mgr
	self._scene = game_mgr._scene
	self._scene_root = game_mgr._scene_root
end

function PushBoxStepDataMgr:init()
	self._step_data = {}
end

function PushBoxStepDataMgr:_onRevertStep()
	local step_data = table.remove(self._step_data)

	if not step_data then
		GameFacade.showToast(ToastEnum.PushBoxGame)

		return
	end

	self._game_mgr.character:revertDirection(step_data.characterDirection)

	if step_data.step_type == PushBoxStepDataMgr.StepType.Move then
		self._game_mgr.character:revertMove(step_data.from_x, step_data.from_y)
	elseif step_data.step_type == PushBoxStepDataMgr.StepType.PushBox then
		self._game_mgr:pushBox(step_data.to_x, step_data.to_y, step_data.from_x, step_data.from_y)
		self._game_mgr.character:revertMove(step_data.character_pos_x, step_data.character_pos_y)
	end

	local last_step = self:getLastStep()

	if last_step then
		self._game_mgr:setWarning(last_step.warning)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RevertStep, last_step)
	else
		self._game_mgr:setWarning(0)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StartElement)
	end
end

function PushBoxStepDataMgr:markStepData()
	local last_step = self:getLastStep()

	last_step.warning = self._game_mgr:getCurWarning()
	last_step.characterDirection = self._game_mgr.character:getDirection()

	local element_list = self._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Enemy)

	last_step.enemy_direction = {}

	for i, v in ipairs(element_list) do
		local temp_tab = {}

		temp_tab.pos_x = v:getPosX()
		temp_tab.pos_y = v:getPosY()
		temp_tab.index = v:getIndex()

		table.insert(last_step.enemy_direction, temp_tab)
	end

	last_step.fan_time = {}
	element_list = self._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Fan)

	for i, v in ipairs(element_list) do
		local temp_tab = {}

		temp_tab.active = v:getState()
		temp_tab.pos_x = v:getPosX()
		temp_tab.pos_y = v:getPosY()

		if v._start_time then
			local episode_config = self._game_mgr:getConfig()
			local duration_time = episode_config.fan_duration

			temp_tab.left_time = duration_time - (Time.realtimeSinceStartup - v._start_time)
		end

		table.insert(last_step.fan_time, temp_tab)
	end
end

function PushBoxStepDataMgr:getLastStep()
	return self._step_data[#self._step_data]
end

function PushBoxStepDataMgr:getStepCount()
	return (self._step_data or nil) and (#self._step_data or 0)
end

function PushBoxStepDataMgr:moveCharacter(from_x, from_y)
	local step_data = {}

	step_data.step_type = PushBoxStepDataMgr.StepType.Move
	step_data.from_x = from_x
	step_data.from_y = from_y

	table.insert(self._step_data, step_data)
end

function PushBoxStepDataMgr:pushBox(from_x, from_y, to_x, to_y)
	local character = self._game_mgr.character
	local step_data = {}

	step_data.step_type = PushBoxStepDataMgr.StepType.PushBox
	step_data.from_x = from_x
	step_data.from_y = from_y
	step_data.to_x = to_x
	step_data.to_y = to_y
	step_data.character_pos_x = character:getPosX()
	step_data.character_pos_y = character:getPosY()

	table.insert(self._step_data, step_data)
end

function PushBoxStepDataMgr:releaseSelf()
	self:__onDispose()
end

return PushBoxStepDataMgr
