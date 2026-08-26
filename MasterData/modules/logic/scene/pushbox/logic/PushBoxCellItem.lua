-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxCellItem.lua

module("modules.logic.scene.pushbox.logic.PushBoxCellItem", package.seeall)

local PushBoxCellItem = class("PushBoxCellItem", UserDataDispose)

function PushBoxCellItem:ctor(cell_mgr, scene_root, cell_obj)
	self:__onInit()

	self._cell_mgr = cell_mgr
	self._scene_root = scene_root
	self._cell_obj = cell_obj
	self._cell_transform = cell_obj.transform
	self._element_root = gohelper.findChild(scene_root, "Root/ElementRoot")
end

function PushBoxCellItem:getCellObj()
	return self._cell_obj
end

function PushBoxCellItem:getRendererIndex()
	return self._cell_obj.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 2 + 20000
end

function PushBoxCellItem:characterInArea()
	self._cell_mgr._game_mgr:characterInArea(self:getPosX(), self:getPosY())
end

function PushBoxCellItem:doorIsOpend()
	return self.door_is_opened
end

function PushBoxCellItem:getTransform()
	return self._cell_transform
end

function PushBoxCellItem:getPosX()
	return self._pos_x
end

function PushBoxCellItem:getPosY()
	return self._pos_y
end

function PushBoxCellItem:getCellType()
	return self._cell_type
end

function PushBoxCellItem:setBox(box)
	self._box = box
end

function PushBoxCellItem:getBox()
	return self._box
end

function PushBoxCellItem:initData(cell_type, pos_x, pox_y)
	self._pos_x = pos_x
	self._pos_y = pox_y
	self._cell_type = cell_type

	if cell_type == PushBoxGameMgr.ElementType.Box then
		self._box = true
		self._cell_type = PushBoxGameMgr.ElementType.Road
	end
end

function PushBoxCellItem:initElement(cell_type)
	local tar_obj, element_logic

	if cell_type == PushBoxGameMgr.ElementType.Goal then
		tar_obj = gohelper.create3d(self._element_root, "Door" .. self._pos_y .. "_" .. self._pos_x)

		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Goal), tar_obj, "Close")

		local _open = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/DoorOpen"), tar_obj, "Open")

		gohelper.setActive(_open, false)

		element_logic = PushBoxElementDoor.New(tar_obj, self)

		element_logic:setRendererIndex()
	elseif cell_type == PushBoxGameMgr.ElementType.Box then
		tar_obj = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. cell_type), self._element_root, "Box" .. self._pos_y .. "_" .. self._pos_x)

		local element_renderer = tar_obj.transform:GetChild(0):GetComponent("MeshRenderer")

		element_renderer.sortingOrder = self:getRendererIndex() + 3
		element_logic = PushBoxElementBox.New(tar_obj, self)
	elseif self._cell_mgr._game_mgr:typeIsEnemy(cell_type) then
		tar_obj = gohelper.create3d(self._element_root, "Enemy")

		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/EnemyUp"), tar_obj, PushBoxGameMgr.Direction.Up)
		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/EnemyDown"), tar_obj, PushBoxGameMgr.Direction.Down)
		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/EnemyLeft"), tar_obj, PushBoxGameMgr.Direction.Left)
		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/EnemyRight"), tar_obj, PushBoxGameMgr.Direction.Right)

		element_logic = PushBoxElementEnemy.New(tar_obj, self)

		element_logic:setRendererIndex()
	elseif cell_type == PushBoxGameMgr.ElementType.Mechanics then
		tar_obj = gohelper.create3d(self._element_root, "Mechanics" .. self._pos_y .. "_" .. self._pos_x)

		gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Mechanics), tar_obj, "Normal")

		local _enabled = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/EnabledMechanics"), tar_obj, "Enabled")

		gohelper.setActive(_enabled, false)

		element_logic = PushBoxElementMechanics.New(tar_obj, self)

		element_logic:setRendererIndex()
	elseif cell_type == PushBoxGameMgr.ElementType.Fan then
		tar_obj = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. cell_type), self._element_root, "Fan")
		element_logic = PushBoxElementFan.New(tar_obj, self)

		element_logic:setRendererIndex()
	elseif self._cell_mgr._game_mgr:typeIsLight(cell_type) then
		tar_obj = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. cell_type), self._element_root, "Light" .. cell_type)
		element_logic = PushBoxElementLight.New(tar_obj, self)

		element_logic:setRendererIndex()
	end

	if tar_obj then
		gohelper.setActive(tar_obj, true)

		local cell_pos = self:getTransform().position

		transformhelper.setPos(tar_obj.transform, cell_pos.x, cell_pos.y, cell_pos.z)

		self._element_obj = tar_obj
	end

	self._element_logic = element_logic

	return element_logic
end

function PushBoxCellItem:getElementLogic()
	return self._element_logic
end

function PushBoxCellItem:setCellInvincible(state)
	self._invincible = state
end

function PushBoxCellItem:getInvincible()
	return self._invincible
end

function PushBoxCellItem:releaseSelf()
	self:__onDispose()

	self._element_logic = nil
end

return PushBoxCellItem
