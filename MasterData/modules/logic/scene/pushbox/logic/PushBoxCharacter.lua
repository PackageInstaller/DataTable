-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxCharacter.lua

module("modules.logic.scene.pushbox.logic.PushBoxCharacter", package.seeall)

local PushBoxCharacter = class("PushBoxCharacter", UserDataDispose)

function PushBoxCharacter:ctor(game_mgr)
	self:__onInit()

	self._game_mgr = game_mgr
	self._scene = game_mgr._scene
	self._scene_root = game_mgr._scene_root
end

function PushBoxCharacter:revertMove(pos_x, pos_y)
	self:_moveCharacter(pos_x, pos_y, true)
end

function PushBoxCharacter:revertDirection(direction)
	self._cur_direction = direction
end

function PushBoxCharacter:move(direction)
	if not self._last_time then
		self._last_time = Time.time
	elseif Time.time - self._last_time < 0.2 then
		return
	end

	local to_x, to_y

	if direction == PushBoxGameMgr.Direction.Up then
		to_x = self._pos_x
		to_y = self._pos_y - 1
	elseif direction == PushBoxGameMgr.Direction.Down then
		to_x = self._pos_x
		to_y = self._pos_y + 1
	elseif direction == PushBoxGameMgr.Direction.Left then
		to_x = self._pos_x - 1
		to_y = self._pos_y
	elseif direction == PushBoxGameMgr.Direction.Right then
		to_x = self._pos_x + 1
		to_y = self._pos_y
	end

	if self._game_mgr:outOfBounds(to_x, to_y) then
		return
	end

	self._cur_direction = direction

	if not self:_canMove(to_x, to_y) then
		return
	end

	self._last_time = Time.time

	self._game_mgr.step_data:moveCharacter(self._pos_x, self._pos_y)
	self:_moveCharacter(to_x, to_y)
end

function PushBoxCharacter:_moveCharacter(aim_pos_x, aim_pos_y, is_revert)
	local cur_cell = self._game_mgr:getCell(self._pos_x, self._pos_y)

	self._pos_x = aim_pos_x
	self._pos_y = aim_pos_y

	self:_releaseWalkTween()

	local aim_cell = self._game_mgr:getCell(aim_pos_x, aim_pos_y)
	local tar_pos = aim_cell:getTransform().position

	self._character_final_renderer_index = aim_cell:getRendererIndex()

	self:_setRendererIndex(cur_cell:getRendererIndex() >= aim_cell:getRendererIndex() and cur_cell:getRendererIndex() or aim_cell:getRendererIndex())

	self._walk_tween = ZProj.TweenHelper.DOMove(self._transform, tar_pos.x, tar_pos.y, tar_pos.z, 0.2)

	TaskDispatcher.runDelay(self._refreshCharacterRendererIndex, self, 0.2)
	self._game_mgr:detectCellData()
	self._game_mgr.cell_mgr:releaseBoxLight()

	if not is_revert then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		self._game_mgr:stepOver()
	end

	if self._ani then
		for i, v in ipairs(self._ani) do
			v:Play("downm", 0, 0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_role_move)
end

function PushBoxCharacter:_refreshCharacterRendererIndex()
	self:_setRendererIndex(self._character_final_renderer_index)
end

function PushBoxCharacter:_canMove(pos_x, pos_y)
	local target_cell = self._game_mgr:getCell(pos_x, pos_y)

	if target_cell:getBox() then
		local aim_x = pos_x
		local aim_y = pos_y

		if self._cur_direction == PushBoxGameMgr.Direction.Up then
			aim_x = pos_x
			aim_y = pos_y - 1
		elseif self._cur_direction == PushBoxGameMgr.Direction.Down then
			aim_x = pos_x
			aim_y = pos_y + 1
		elseif self._cur_direction == PushBoxGameMgr.Direction.Left then
			aim_x = pos_x - 1
			aim_y = pos_y
		elseif self._cur_direction == PushBoxGameMgr.Direction.Right then
			aim_x = pos_x + 1
			aim_y = pos_y
		end

		local box_aim_cell = self._game_mgr:getCell(aim_x, aim_y)

		if box_aim_cell then
			local can_push = true

			if box_aim_cell:getBox() then
				can_push = false
			else
				local box_cell_type = box_aim_cell:getCellType()

				if self._game_mgr:typeIsEnemy(box_cell_type) then
					can_push = false
				elseif self._game_mgr:typeIsLight(box_cell_type) then
					can_push = false
				elseif box_cell_type == PushBoxGameMgr.ElementType.Empty then
					can_push = false
				end
			end

			if can_push then
				self._game_mgr.step_data:pushBox(pos_x, pos_y, aim_x, aim_y)
				self._game_mgr.cell_mgr:pushBox(pos_x, pos_y, aim_x, aim_y)
				self:_moveCharacter(pos_x, pos_y)
			end
		end

		return false
	end

	if self._game_mgr:typeIsEnemy(target_cell:getCellType()) then
		return false
	end

	if self._game_mgr:typeIsLight(target_cell:getCellType()) then
		return false
	end

	self._chechCanMove = self._chechCanMove or {
		[PushBoxGameMgr.ElementType.Empty] = false,
		[PushBoxGameMgr.ElementType.Mechanics] = true,
		[PushBoxGameMgr.ElementType.Fan] = true,
		[PushBoxGameMgr.ElementType.Road] = true,
		[PushBoxGameMgr.ElementType.Goal] = true
	}

	if self._chechCanMove[target_cell:getCellType()] then
		return self._chechCanMove[target_cell:getCellType()]
	end

	if self._game_mgr:typeIsCharacter(target_cell:getCellType()) then
		return true
	end

	if self._game_mgr:typeIsDoor(target_cell:getCellType()) then
		if not target_cell.door_is_opened then
			return false
		end

		return true
	end
end

function PushBoxCharacter:getCharacterObj()
	return self._gameObject
end

function PushBoxCharacter:getCharacterTran()
	return self._transform
end

function PushBoxCharacter:getPosX()
	return self._pos_x
end

function PushBoxCharacter:getPosY()
	return self._pos_y
end

function PushBoxCharacter:init()
	self._gameObject = gohelper.create3d(gohelper.findChild(self._scene:getSceneContainerGO(), "Root"), "character")

	gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/CharacterUp"), self._gameObject, PushBoxGameMgr.Direction.Up)
	gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/CharacterDown"), self._gameObject, PushBoxGameMgr.Direction.Down)
	gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/CharacterLeft"), self._gameObject, PushBoxGameMgr.Direction.Left)
	gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/CharacterRight"), self._gameObject, PushBoxGameMgr.Direction.Right)

	self._transform = self._gameObject.transform

	self:_refreshPos()

	self._ani = self:getUserDataTb_()

	for i = 0, 3 do
		local tar_transform = self._gameObject.transform:GetChild(i)

		table.insert(self._ani, gohelper.onceAddComponent(tar_transform.gameObject, typeof(UnityEngine.Animator)))
	end
end

function PushBoxCharacter:setPos(x, y, direction)
	local tar_cell = self._game_mgr:getCell(x, y)

	self._cur_direction = direction
	self._pos_x = tar_cell:getPosX()
	self._pos_y = tar_cell:getPosY()

	self:_refreshPos()
end

function PushBoxCharacter:getDirection()
	return self._cur_direction
end

function PushBoxCharacter:_refreshPos()
	if not self._transform then
		return
	end

	local tar_cell = self._game_mgr:getCell(self._pos_x, self._pos_y)

	if tar_cell then
		local tar_pos = tar_cell:getCellObj().transform.position

		transformhelper.setPos(self._transform, tar_pos.x, tar_pos.y, tar_pos.z)
		self:_setRendererIndex(tar_cell:getRendererIndex())
	end
end

function PushBoxCharacter:_setRendererIndex(tar_index)
	local cur_direction = tostring(self._cur_direction)

	for i = 0, 3 do
		local tar_transform = self._gameObject.transform:GetChild(i)
		local meshRenderer = tar_transform:GetChild(0):GetComponent("MeshRenderer")

		meshRenderer.sortingOrder = tar_index + 8

		gohelper.setActive(tar_transform.gameObject, tar_transform.name == cur_direction)
	end
end

function PushBoxCharacter:_releaseWalkTween()
	if self._walk_tween then
		ZProj.TweenHelper.KillById(self._walk_tween)
	end

	self._walk_tween = nil
end

function PushBoxCharacter:releaseSelf()
	gohelper.destroy(self._gameObject)
	TaskDispatcher.cancelTask(self._refreshCharacterRendererIndex, self)
	self:_releaseWalkTween()
	self:__onDispose()
end

return PushBoxCharacter
