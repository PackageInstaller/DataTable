-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxElementLight.lua

module("modules.logic.scene.pushbox.logic.PushBoxElementLight", package.seeall)

local PushBoxElementLight = class("PushBoxElementLight", UserDataDispose)

function PushBoxElementLight:ctor(gameObject, cell)
	self:__onInit()

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	self._gameObject = gameObject
	self._transform = gameObject.transform
	self._cell = cell

	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RefreshElement, self._onRefreshElement, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StepFinished, self._onStepFinished, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.RevertStep, self._onRevertStep, self)
	self.addEventCb(self, PushBoxController.instance, PushBoxEvent.StartElement, self._onStartElement, self)
end

function PushBoxElementLight:setRendererIndex()
	local element_renderer = self._transform:GetChild(0):GetComponent("MeshRenderer")

	element_renderer.sortingOrder = self._cell:getRendererIndex()

	local glow1 = gohelper.findChild(self._gameObject, "vx_light/vx_light_tou/glow1")

	if glow1 then
		glow1:GetComponent("MeshRenderer").sortingOrder = self._cell:getRendererIndex() + 1
	end

	local Particle = gohelper.findChild(self._gameObject, "vx_light/vx_light_tou/Particle System (1)")

	if Particle then
		Particle:GetComponent("Renderer").sortingOrder = self._cell:getRendererIndex() + 1
	end

	self._light = gohelper.findChild(self._gameObject, "light").transform
end

function PushBoxElementLight:_onStartElement()
	local episode_config = self._game_mgr:getConfig()

	self._alarm_value = episode_config.light_alarm

	self:refreshActArea()
end

function PushBoxElementLight:_hideWallLight()
	local wall_light = gohelper.findChild(self._gameObject, "vx_light_qiang")

	if wall_light then
		gohelper.setActive(wall_light, false)
	end
end

function PushBoxElementLight:_beforeRefreshActArea()
	self._last_act_count = self._act_list and #self._act_list or 0
	self._act_list = {}

	self:_hideWallLight()

	self._play_tween = false
	self._offset_scale = 0
	self._box_show_light_obj = nil

	TaskDispatcher.cancelTask(self._showBoxLight, self)
end

function PushBoxElementLight:refreshActArea()
	self:_beforeRefreshActArea()

	local wall_light = gohelper.findChild(self._gameObject, "vx_light_qiang")
	local cell_type = self._cell:getCellType()
	local start_index, end_index, offet, left_right = self:_getActArea(cell_type)
	local sort_index = self._cell:getRendererIndex()

	for i = start_index, end_index, offet do
		if left_right then
			local var_6_0 = self._game_mgr:getCell(i, self._cell:getPosY())

			if not var_6_0 then
				var_6_0 = self._game_mgr:getCell(self._cell:getPosX(), i)

				local tar_cell = var_6_0
				local tar_type = tar_cell:getCellType()

				if tar_cell:getBox() then
					self:_tarCellBox(tar_cell, offet, left_right)

					break
				elseif tar_type == PushBoxGameMgr.ElementType.Enemy then
					break
				elseif tar_type == PushBoxGameMgr.ElementType.LightUp then
					break
				elseif tar_type == PushBoxGameMgr.ElementType.LightDown then
					break
				elseif tar_type == PushBoxGameMgr.ElementType.LightLeft then
					break
				elseif tar_type == PushBoxGameMgr.ElementType.LightRight then
					break
				elseif tar_type == PushBoxGameMgr.ElementType.Empty then
					if not left_right and offet < 0 and wall_light then
						self._offset_scale = 0.6

						gohelper.setActive(wall_light, true)

						local temp_x, temp_y, temp_z = transformhelper.getPos(self._act_list[#self._act_list]:getCellObj().transform)

						transformhelper.setPos(wall_light.transform, temp_x, temp_y, temp_z)
					end

					break
				end

				if sort_index <= tar_cell:getRendererIndex() then
					sort_index = tar_cell:getRendererIndex()
				end

				table.insert(self._act_list, tar_cell)

				if #self._act_list == math.abs(end_index - start_index) + 1 and not left_right and offet < 0 and wall_light then
					self._offset_scale = 0.6

					gohelper.setActive(wall_light, true)

					local temp_x, temp_y, temp_z = transformhelper.getPos(self._act_list[#self._act_list]:getCellObj().transform)

					transformhelper.setPos(wall_light.transform, temp_x, temp_y, temp_z)
				end
			end
		end
	end

	gohelper.findChild(self._gameObject, "light/glow1"):GetComponent("MeshRenderer").sortingOrder = sort_index - 1

	if wall_light then
		gohelper.findChild(wall_light, "glow1"):GetComponent("MeshRenderer").sortingOrder = sort_index
	end

	self:_playTween()
end

function PushBoxElementLight:_tarCellBox(tar_cell, offet, left_right)
	local box_obj = gohelper.findChild(self._game_mgr._scene_root, "Root/ElementRoot/Box" .. tar_cell:getPosY() .. "_" .. tar_cell:getPosX())
	local show_obj

	if left_right then
		self._offset_scale = offet > 0 and 0.29 or 0.22

		local character_direction = self._game_mgr.character:getDirection()

		if character_direction == PushBoxGameMgr.Direction.Left or character_direction == PushBoxGameMgr.Direction.Right then
			self._play_tween = true
		end
	else
		if offet > 0 then
			-- block empty
		else
			show_obj = gohelper.findChild(box_obj, "#vx_light_down")
		end

		local character_direction = self._game_mgr.character:getDirection()

		if character_direction == PushBoxGameMgr.Direction.Down or character_direction == PushBoxGameMgr.Direction.Up then
			self._play_tween = true
		end

		self._offset_scale = 0.6
	end

	if show_obj then
		self._box_show_light_obj = show_obj

		if self._play_tween then
			gohelper.setActive(show_obj, true)
		else
			TaskDispatcher.runDelay(self._showBoxLight, self, 0.2)
		end

		local meshRenderer = show_obj:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		if meshRenderer then
			for index = 0, meshRenderer.Length - 1 do
				meshRenderer[index].sortingOrder = box_obj.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 1
			end
		end
	end
end

function PushBoxElementLight:_getActArea(cell_type)
	local start_index = 0
	local end_index = 0
	local offet = 0
	local left_right = false

	if cell_type == PushBoxGameMgr.ElementType.LightRight then
		start_index = self._cell:getPosX() + 1
		end_index = 8
		offet = 1
		left_right = true
	elseif cell_type == PushBoxGameMgr.ElementType.LightLeft then
		start_index = self._cell:getPosX() - 1
		end_index = 1
		offet = -1
		left_right = true
	elseif cell_type == PushBoxGameMgr.ElementType.LightUp then
		start_index = self._cell:getPosY() - 1
		end_index = 1
		offet = -1
	elseif cell_type == PushBoxGameMgr.ElementType.LightDown then
		start_index = self._cell:getPosY() + 1
		end_index = 6
		offet = 1
	end

	return start_index, end_index, offet, left_right
end

function PushBoxElementLight:_playTween()
	if self._play_tween then
		self:_releaseTween()

		self._tween = ZProj.TweenHelper.DOTweenFloat(self._last_act_count + self._offset_scale, #self._act_list + self._offset_scale, 0.2, self._frameCallback, nil, self)
	else
		if #self._act_list == self._last_act_count then
			self:_showBoxLight()
		end

		transformhelper.setLocalScale(self._light, #self._act_list + self._offset_scale, 1, 1)
	end
end

function PushBoxElementLight:_showBoxLight()
	if self._box_show_light_obj then
		gohelper.setActive(self._box_show_light_obj, true)
	end
end

function PushBoxElementLight:_releaseTween()
	if self._tween then
		ZProj.TweenHelper.KillById(self._tween)
	end

	self._tween = nil
end

function PushBoxElementLight:_frameCallback(value)
	transformhelper.setLocalScale(self._light, value, 1, 1)
end

function PushBoxElementLight:_onRevertStep()
	self:refreshActArea()
end

function PushBoxElementLight:_onRefreshElement()
	self:refreshActArea()
end

function PushBoxElementLight:_onStepFinished()
	for i, v in ipairs(self._act_list) do
		if self._game_mgr:characterInArea(v:getPosX(), v:getPosY()) and not self._game_mgr:cellIsInvincible(v:getPosX(), v:getPosY()) then
			self._game_mgr:changeWarning(self._alarm_value)
		end
	end
end

function PushBoxElementLight:_characterInArea()
	self._in_area = self._game_mgr:characterInArea(self._act_cell_x, self._act_cell_y)

	return self._in_area
end

function PushBoxElementLight:getIndex()
	return self._index
end

function PushBoxElementLight:getPosX()
	return self._cell:getPosX()
end

function PushBoxElementLight:getPosY()
	return self._cell:getPosY()
end

function PushBoxElementLight:getObj()
	return self._gameObject
end

function PushBoxElementLight:getCell()
	return self._cell
end

function PushBoxElementLight:releaseSelf()
	TaskDispatcher.cancelTask(self._showBoxLight, self)
	self:_releaseTween()
	self:__onDispose()
end

return PushBoxElementLight
