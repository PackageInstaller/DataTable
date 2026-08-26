-- chunkname: @modules/logic/scene/pushbox/logic/PushBoxCellMgr.lua

module("modules.logic.scene.pushbox.logic.PushBoxCellMgr", package.seeall)

local PushBoxCellMgr = class("PushBoxCellMgr", UserDataDispose)

function PushBoxCellMgr:ctor(game_mgr)
	self:__onInit()

	self._game_mgr = game_mgr
	self._scene = game_mgr._scene
	self._scene_root = game_mgr._scene_root
end

function PushBoxCellMgr:getCell(pos_x, pos_y)
	return self._cell_data[pos_y] and self._cell_data[pos_y][pos_x]
end

function PushBoxCellMgr:getElement(element_type, pos_x, pos_y)
	for i, v in ipairs(self._element_logic[element_type]) do
		if v:getPosX() == pos_x and v:getPosY() == pos_y then
			return v
		end
	end
end

function PushBoxCellMgr:_refreshBoxRender()
	self._cur_push_box.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = self._box_final_render_index + 3

	self:refreshBoxLight()
end

function PushBoxCellMgr:refreshBoxLight()
	local list = self._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box)

	if list then
		for i, v in ipairs(list) do
			if v:getObj() == self._cur_push_box then
				v:refreshLightRenderer(self._box_final_render_index)
			end
		end
	end
end

function PushBoxCellMgr:pushBox(from_x, from_y, to_x, to_y)
	self:_releaseBoxTween()

	local box_obj = gohelper.findChild(self._scene_root, "Root/ElementRoot/Box" .. from_y .. "_" .. from_x)
	local from_cell = self:getCell(from_x, from_y)
	local to_cell = self:getCell(to_x, to_y)
	local tar_pos = to_cell:getTransform().position
	local from_render_index = from_cell:getRendererIndex()
	local to_render_index = to_cell:getRendererIndex()

	self._box_final_render_index = to_render_index
	self._cur_push_box = box_obj

	local temp_renderer_index = (to_render_index <= from_render_index and from_render_index or to_render_index) + 3

	box_obj.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = temp_renderer_index
	self._box_tween = ZProj.TweenHelper.DOMove(box_obj.transform, tar_pos.x, tar_pos.y, tar_pos.z, 0.2)

	TaskDispatcher.runDelay(self._refreshBoxRender, self, 0.2)
	to_cell:setBox(true)
	from_cell:setBox(false)

	box_obj.name = "Box" .. to_y .. "_" .. to_x

	self:detectCellData()

	local smoke

	if from_x < to_x then
		smoke = gohelper.findChild(box_obj, "#smoke_box_right")
	elseif to_x < from_x then
		smoke = gohelper.findChild(box_obj, "#smoke_box_left")
	end

	if from_y < to_y then
		smoke = gohelper.findChild(box_obj, "#smoke_box_top")
	elseif to_y < from_y then
		smoke = gohelper.findChild(box_obj, "#smoke_box_down")
	end

	self:_hideBoxSmoke()

	local particle = smoke:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, particle.Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(particle[i], temp_renderer_index)
	end

	gohelper.setActive(smoke, true)
	TaskDispatcher.cancelTask(self._hideBoxSmoke, self)
	TaskDispatcher.runDelay(self._hideBoxSmoke, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_box_push)
end

function PushBoxCellMgr:_hideBoxSmoke()
	if self._cur_push_box then
		gohelper.setActive(gohelper.findChild(self._cur_push_box, "#smoke_box_left"), false)
		gohelper.setActive(gohelper.findChild(self._cur_push_box, "#smoke_box_right"), false)
		gohelper.setActive(gohelper.findChild(self._cur_push_box, "#smoke_box_top"), false)
		gohelper.setActive(gohelper.findChild(self._cur_push_box, "#smoke_box_down"), false)
	end
end

function PushBoxCellMgr:detectCellData()
	if self._element_cell_dic and self._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics] then
		local count = 0

		for i, v in ipairs(self._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]) do
			local has_box = false

			if v:getBox() then
				count = count + 1
				has_box = true or has_box
			end

			v:getElementLogic():refreshMechanicsState(has_box)
		end

		local open_door = count == #self._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]

		for i, v in ipairs(self._cell_list) do
			if self._game_mgr:typeIsDoor(v:getCellType()) then
				if open_door and v.door_is_opened ~= open_door then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_door_open)
				end

				v.door_is_opened = open_door

				v:getElementLogic():refreshDoorState(open_door)
			end
		end
	end
end

function PushBoxCellMgr:_releaseBoxTween()
	if self._box_tween then
		ZProj.TweenHelper.KillById(self._box_tween)
	end

	self._box_tween = nil
end

function PushBoxCellMgr:init()
	self._floor_root = gohelper.findChild(self._scene_root, "Root/FloorRoot")

	local episode_config = self._game_mgr:getConfig()
	local wall_map = episode_config.wall
	local data = GameUtil.splitString2(episode_config.layout, true)
	local wall_data = GameUtil.splitString2(wall_map)

	self._cell_data = {}
	self._cell_list = {}
	self._element_cell_dic = {}
	self._element_logic = {}

	local sorder_index = 0

	for y = 1, #data do
		for x = 1, #data[y] do
			local cell_type = data[y][x]

			self._cell_data[y] = self._cell_data[y] or {}

			local tar_obj = self:_cloneCellObj(x, y)

			tar_obj.name = y .. "_" .. x

			if cell_type == PushBoxGameMgr.ElementType.Empty then
				gohelper.setActive(tar_obj, false)
			end

			local offset_x = x - 4.5
			local offset_y = 2.5 - y

			transformhelper.setLocalPos(tar_obj.transform, offset_x * 2.5, offset_y * 1.54, 0)

			local meshRenderer = tar_obj.transform:GetChild(0):GetComponent("MeshRenderer")

			meshRenderer.sortingOrder = sorder_index

			local cell_item = PushBoxCellItem.New(self, self._scene:getSceneContainerGO(), tar_obj)

			self._cell_data[y][x] = cell_item

			cell_item:initData(cell_type, x, y)

			local cell_real_type = cell_item:getCellType()
			local element_logic = cell_item:initElement(cell_type)

			self._element_logic[cell_real_type] = self._element_logic[cell_real_type] or {}

			if element_logic then
				table.insert(self._element_logic[cell_real_type], element_logic)

				if cell_item:getBox() then
					self._element_logic[cell_type] = self._element_logic[cell_type] or {}

					table.insert(self._element_logic[cell_type], element_logic)
				end
			end

			self._element_cell_dic[cell_real_type] = self._element_cell_dic[cell_real_type] or {}

			table.insert(self._element_cell_dic[cell_real_type], cell_item)
			table.insert(self._cell_list, cell_item)

			if cell_type == PushBoxGameMgr.ElementType.Character then
				self._game_mgr:setCharacterPos(x, y, PushBoxGameMgr.Direction.Down)
			end

			local wall_str = wall_data[y][x]
			local wall_arr = string.splitToNumber(wall_str, "_")
			local cur_cell_is_door = cell_type == PushBoxGameMgr.ElementType.Goal

			for wall_index, wall_value in ipairs(wall_arr) do
				if wall_value ~= 0 then
					self:_setWallRenderer(wall_value, tar_obj, sorder_index, cur_cell_is_door)
				end
			end

			sorder_index = sorder_index + 100
		end
	end
end

function PushBoxCellMgr:_cloneCellObj(x, y)
	local tar_obj

	return x % 2 ~= 0 and (y % 2 ~= 0 and gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Road), self._floor_root) or gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/diban_b"), self._floor_root)) or y % 2 ~= 0 and gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/diban_c"), self._floor_root) or gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/diban_d"), self._floor_root)
end

function PushBoxCellMgr:_setWallRenderer(wall_value, tar_obj, sorder_index, cur_cell_is_door)
	local wall_obj = gohelper.clone(gohelper.findChild(self._scene_root, "Root/OriginElement/" .. wall_value), self._floor_root, "Wall")
	local temp_pos = tar_obj.transform.position

	transformhelper.setPos(wall_obj.transform, temp_pos.x, temp_pos.y, temp_pos.z)

	local wall_sorder_index = sorder_index + 10000
	local wallMeshRenderer = wall_obj.transform:GetChild(0):GetComponent("MeshRenderer")
	local finalOrder = wall_sorder_index

	if cur_cell_is_door then
		finalOrder = wall_sorder_index + 2
	end

	if wall_value == PushBoxGameMgr.ElementType.WallLeft then
		finalOrder = wall_sorder_index + 2
	elseif wall_value == PushBoxGameMgr.ElementType.WallCornerTopLeft then
		finalOrder = wall_sorder_index + 5 + 10000
	elseif wall_value == PushBoxGameMgr.ElementType.WallCornerTopRight then
		finalOrder = wall_sorder_index + 5 + 10000
	elseif wall_value == PushBoxGameMgr.ElementType.WallCornerBottomLeft then
		finalOrder = wall_sorder_index + 5 + 10000
	elseif wall_value == PushBoxGameMgr.ElementType.WallCornerBottomRight then
		finalOrder = wall_sorder_index + 5 + 10000
	end

	wallMeshRenderer.sortingOrder = finalOrder
end

function PushBoxCellMgr:releaseBoxLight()
	local list = self._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box)

	if list then
		for i, v in ipairs(list) do
			v:hideLight()
		end
	end
end

function PushBoxCellMgr:_releaseCell()
	if self._cell_list then
		for i, v in ipairs(self._cell_list) do
			v:releaseSelf()
		end

		self._cell_list = nil
	end

	if self._element_logic then
		for k, v in pairs(self._element_logic) do
			for i, element in ipairs(v) do
				element:releaseSelf()
			end
		end

		self._element_logic = nil
	end

	gohelper.destroyAllChildren(self._floor_root)
	gohelper.destroyAllChildren(gohelper.findChild(self._scene_root, "Root/ElementRoot"))
end

function PushBoxCellMgr:releaseSelf()
	TaskDispatcher.cancelTask(self._refreshBoxRender, self)
	TaskDispatcher.cancelTask(self._hideBoxSmoke, self)
	self:_releaseCell()
	self:_releaseBoxTween()
	self:__onDispose()
end

return PushBoxCellMgr
