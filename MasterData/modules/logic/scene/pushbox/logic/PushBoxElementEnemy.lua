-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementEnemy.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementEnemy", package.seeall)

local PushBoxElementEnemy = class("PushBoxElementEnemy", UserDataDispose)

function PushBoxElementEnemy:ctor(gameObject, cell)
	self:__onInit()

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	self._gameObject = gameObject
	self._transform = gameObject.transform
	self._cell = cell
	self._ani = self:getUserDataTb_()

	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshElement, self._onRefreshElement, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StepFinished, self._onStepFinished, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RevertStep, self._onRevertStep, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StartElement, self._onStartElement, self)
end

function PushBoxElementEnemy:setRendererIndex()
	local final_renderer_index = self._cell:getRendererIndex()

	for i = 0, self._transform.childCount - 1 do
		local tar_transform = self._transform:GetChild(i)
		local meshRenderer = tar_transform:GetChild(0):GetComponent("MeshRenderer")

		meshRenderer.sortingOrder = final_renderer_index

		table.insert(self._ani, gohelper.findChildComponent(tar_transform.gameObject, "eyeglow", typeof(UnityEngine.Animator)))
	end
end

function PushBoxElementEnemy:_onStartElement()
	local rule_index = self._game_mgr:getEnemyIndex(self)
	local episode_config = self._game_mgr:getConfig()

	self._act_rule = GameUtil.splitString2(string.split(episode_config.enemy_act, "_")[rule_index], true, "|", "#")
	self._alarm_value = episode_config.enemy_alarm
	self._index = 1
	self._next_act_time = self._act_rule[self._index][2] + Time.realtimeSinceStartup

	self:_startAct()
	TaskDispatcher.runDelay(self._onTime, self, self._act_rule[self._index][2])
end

function PushBoxElementEnemy:_onRevertStep(step_data)
	if step_data.enemy_direction then
		for i, v in ipairs(step_data.enemy_direction) do
			if v.pos_x == self._cell:getPosX() and v.pos_y == self._cell:getPosY() then
				self._index = v.index

				self:doAct()
			end
		end
	end
end

function PushBoxElementEnemy:_onTime()
	if self._in_area and self:_characterInArea() then
		return
	end

	self._index = self._index + 1

	if self._index > #self._act_rule then
		self._index = 1
	end

	self:doAct()
end

function PushBoxElementEnemy:doAct()
	self:_startAct()

	self._next_act_time = self._act_rule[self._index][2] + Time.realtimeSinceStartup

	TaskDispatcher.runDelay(self._onTime, self, self._act_rule[self._index][2])
end

function PushBoxElementEnemy:_onRefreshElement()
	self._check_warning = true

	local state = self._in_area

	if state and not self:_characterInArea() then
		if Time.realtimeSinceStartup > self._next_act_time then
			self:_onTime()
		end

		self._check_warning = false

		return
	end
end

function PushBoxElementEnemy:_onStepFinished()
	if not self._check_warning then
		return
	end

	if self._game_mgr:cellIsInvincible(self._act_cell_x, self._act_cell_y) then
		return
	end

	if self:_characterInArea() then
		self._game_mgr:changeWarning(self._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
	end
end

function PushBoxElementEnemy:_startAct()
	self._act_cell_x = self._cell:getPosX()
	self._act_cell_y = self._cell:getPosY()

	local direction = self._act_rule[self._index][1]

	if direction == PushBoxGameMgr.Direction.Up then
		self._act_cell_y = self._act_cell_y - 1
	elseif direction == PushBoxGameMgr.Direction.Down then
		self._act_cell_y = self._act_cell_y + 1
	elseif direction == PushBoxGameMgr.Direction.Left then
		self._act_cell_x = self._act_cell_x - 1
	elseif direction == PushBoxGameMgr.Direction.Right then
		self._act_cell_x = self._act_cell_x + 1
	end

	self._act_cell = self._game_mgr:getCell(self._act_cell_x, self._act_cell_y)

	local show_obj = tostring(direction)

	for i = 0, 3 do
		local tar_transform = self._gameObject.transform:GetChild(i)

		gohelper.setActive(tar_transform.gameObject, show_obj == tar_transform.name)

		local meshRenderer = gohelper.findChild(tar_transform.gameObject, "eyeglow"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		if meshRenderer then
			for index = 0, meshRenderer.Length - 1 do
				meshRenderer[index].sortingOrder = self._act_cell:getRendererIndex() + 2
			end
		end
	end

	if self._game_mgr:cellIsInvincible(self._act_cell_x, self._act_cell_y) then
		return
	end

	if self:_characterInArea() then
		self._game_mgr:changeWarning(self._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
		self._game_mgr:detectGameOver()
	end
end

function PushBoxElementEnemy:_characterInArea()
	self._in_area = self._game_mgr:characterInArea(self._act_cell_x, self._act_cell_y)

	if self._ani then
		for i, v in ipairs(self._ani) do
			v:Play(self._in_area and "click" or "loop")
		end
	end

	return self._in_area
end

function PushBoxElementEnemy:getIndex()
	return self._index
end

function PushBoxElementEnemy:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementEnemy:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementEnemy:getObj()
	return self._gameObject
end

function PushBoxElementEnemy:getCell()
	return self._cell
end

function PushBoxElementEnemy:releaseSelf()
	TaskDispatcher.cancelTask(self._onTime, self)
	self:__onDispose()
end

PushBoxElementEnemy.Direction = {
	180,
	0,
	90,
	-90
}

return PushBoxElementEnemy
