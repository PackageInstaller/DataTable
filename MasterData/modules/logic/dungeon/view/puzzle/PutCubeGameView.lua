-- chunkname: @modules/logic/dungeon/view/puzzle/PutCubeGameView.lua

module("modules.logic.dungeon.view.puzzle.PutCubeGameView", package.seeall)

local PutCubeGameView = class("PutCubeGameView", BaseViewExtended)

function PutCubeGameView:onInitView()
	self._gochessContainer = gohelper.findChild(self.viewGO, "chessboard/#go_chessContainer")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	self._godragAnchor = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	self._gochessitem = gohelper.findChild(self.viewGO, "chessboard/#go_chessitem")
	self._goraychessitem = gohelper.findChild(self.viewGO, "chessboard/#go_raychessitem")
	self._scrollinspiration = gohelper.findChildScrollRect(self.viewGO, "#scroll_inspiration")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	self._goinspirationItem = gohelper.findChild(self.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	self._btnrevertlastoperation = gohelper.findChildButton(self.viewGO, "#btn_revert_last_operation")
	self._btnreset = gohelper.findChildButton(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PutCubeGameView:addEvents()
	self.addClickCb(self, self._btnrevertlastoperation, self._onBtnRevertLastOperation, self)
	self.addClickCb(self, self._btnreset, self.onOpen, self)
end

function PutCubeGameView:removeEvents()
	return
end

function PutCubeGameView:_editableInitView()
	return
end

function PutCubeGameView:onUpdateParam()
	return
end

function PutCubeGameView:onOpen()
	self:_setChessData()
	self:_setDebrisData()
end

function PutCubeGameView:_setChessData()
	local str = self.viewParam.param

	self.chess_data = GameUtil.splitString2(str, true, "#", ",")

	local y_count = #self.chess_data
	local x_count = #self.chess_data[1]

	self.cell_length = 70
	self._rabbet_cell = {}
	self._rabbet_cell_list = {}

	local create_count = 0

	for y = 1, y_count do
		self._rabbet_cell[y] = {}

		for x = 1, x_count do
			local game_obj = create_count < self._gomeshContainer.transform.childCount and self._gomeshContainer.transform:GetChild(create_count).gameObject or gohelper.clone(self._gomeshItem, self._gomeshContainer)
			local offset_x = x - (x_count + 1) / 2
			local offset_y = (y_count + 1) / 2 - y

			recthelper.setAnchor(game_obj.transform, offset_x * self.cell_length, offset_y * self.cell_length)

			self._rabbet_cell[y][x] = self.openSubView(self, PutCubeGameItemView, game_obj, nil, self.chess_data[y][x], self)

			table.insert(self._rabbet_cell_list, self._rabbet_cell[y][x])

			create_count = create_count + 1
		end
	end
end

function PutCubeGameView:_setDebrisData()
	self.debris_list = {}
	self.debris_count_dic = {}

	for i, v in ipairs(DungeonConfig.instance:getPuzzleSquareDebrisGroupList(self.viewParam.id)) do
		self.debris_count_dic[v.id] = v.count

		table.insert(self.debris_list, v)
	end

	self:_refreshDebrisList()
end

function PutCubeGameView:_refreshDebrisList()
	gohelper.CreateObjList(self, self._onDebrisItemShow, self.debris_list, self._goContent, self._goinspirationItem)
end

function PutCubeGameView:_onDebrisItemShow(obj, data, index)
	local transform = obj.transform

	obj.name = index

	local cell_bg = transform:Find("item/slot"):GetComponent(gohelper.Type_Image)
	local icon = transform:Find("item/slot/icon"):GetComponent(gohelper.Type_Image)
	local countbg = transform:Find("item/slot/countbg")
	local count = transform:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh)
	local glow_icon = transform:Find("item/slot/glow"):GetComponent(gohelper.Type_Image)

	count.text = self.debris_count_dic[data.id]

	gohelper.setActive(obj, self.debris_count_dic[data.id] > 0)
	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragBeginListener(self._onDragBegin, self, data)
	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragListener(self._onDrag, self)
	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragEndListener(self._onDragEnd, self)
end

function PutCubeGameView:_onDragBegin(config)
	self:_createDragItem(config)
end

function PutCubeGameView:_createDragItem(config)
	if not self.drag_container then
		self.drag_container = self._godragContainer
		self.drag_container_transform = self.drag_container.transform
	end

	local cubeId = config.id

	transformhelper.setLocalRotation(self.drag_container_transform, 0, 0, 0)

	local drag_cube_transform = self.drag_container_transform:Find(cubeId)

	if not drag_cube_transform then
		drag_cube_transform = gohelper.clone(self._gocellModel, self.drag_container, cubeId)

		recthelper.setAnchor(drag_cube_transform.transform, 0, 0)
	end

	gohelper.setActive(self.drag_container, true)

	if self.drag_data then
		gohelper.setActive(self.drag_container_transform:Find(self.drag_data.drag_id).gameObject, false)
	else
		self.drag_data = {}
	end

	self.drag_data.drag_id = cubeId
	self.drag_data.config = config

	local drag_cube = drag_cube_transform.gameObject

	if not self.drag_cube_child_list then
		self.drag_cube_child_list = {}
		self.cube_rightful_count = {}
	end

	if not self.drag_cube_child_list[cubeId] then
		self.drag_cube_child_list[cubeId] = {}
		self.cube_rightful_count[cubeId] = {}

		self:_createDragCubeChild(self.drag_cube_child_list[cubeId], config, drag_cube)
	end

	gohelper.setActive(drag_cube, true)
end

function PutCubeGameView:_createDragCubeChild(child_list, config, drag_cube)
	local mat = GameUtil.splitString2(config.shape, true, "#", ",")
	local y_count = GameUtil.getTabLen(mat)
	local x_count = GameUtil.getTabLen(mat[1])
	local rightful = 0

	for i = 1, y_count do
		for j = 1, x_count do
			local tab = self:getUserDataTb_()

			tab.gameObject = gohelper.clone(self._gocellModel, drag_cube)
			tab.transform = tab.gameObject.transform
			tab.rightful = mat[i][j] == 1

			if tab.rightful then
				rightful = rightful + 1
			end

			local offset_x = j - (x_count + 1) / 2
			local offset_y = (y_count + 1) / 2 - i

			recthelper.setAnchor(tab.transform, offset_x * self.cell_length, offset_y * self.cell_length)
			table.insert(child_list, tab)

			if i == 1 and j == 1 then
				-- block empty
			end
		end
	end

	self.cube_rightful_count[config.id] = rightful
end

function PutCubeGameView:_onDrag()
	if not self.drag_data then
		return
	end

	local temp_pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._gomeshContainer.transform)

	recthelper.setAnchor(self.drag_container_transform, temp_pos.x, temp_pos.y)
end

function PutCubeGameView:_detectDragResult(fill_cell_tab)
	self.cur_fill_count = 0

	for i, v in ipairs(self._rabbet_cell_list) do
		local cell = v

		for index, cube in ipairs(self.drag_cube_child_list[self.drag_data.drag_id]) do
			local cube_transform = cube.transform
			local temp_x = recthelper.getAnchorX(cube_transform)
			local temp_y = recthelper.getAnchorY(cube_transform)
			local cube_anchor_pos_x = recthelper.getAnchorX(self.drag_container_transform) + temp_x
			local cube_anchor_pos_y = recthelper.getAnchorY(self.drag_container_transform) + temp_y
			local is_covered = cell:detectPosCover(cube_anchor_pos_x, cube_anchor_pos_y)

			if is_covered and cube.rightful and cell.level < 3 then
				self.cur_fill_count = self.cur_fill_count + 1

				if fill_cell_tab then
					table.insert(fill_cell_tab, cell)
				end
			end
		end
	end
end

function PutCubeGameView:_onDragEnd()
	local fill_cell = {}

	self:_detectDragResult(fill_cell)

	if not self.drag_data then
		self:_releaseDragItem()

		self.cur_fill_count = 0

		return
	end

	if self.cur_fill_count == self.cube_rightful_count[self.drag_data.config.id] then
		for i, v in ipairs(fill_cell) do
			v.level = v.level + 1

			v:onOpen()
		end

		self.step_data = self.step_data or {}

		table.insert(self.step_data, {
			config = self.drag_data.config,
			fill_cell = fill_cell
		})

		self.debris_count_dic[self.drag_data.config.id] = self.debris_count_dic[self.drag_data.config.id] - 1

		self:_refreshDebrisList()

		if self:_detectGameWin() then
			DungeonRpc.instance:sendMapElementRequest(self.viewParam.id)
			self:closeThis()
		end
	end

	self:_releaseDragItem()

	self.cur_fill_count = 0
end

function PutCubeGameView:_detectGameWin()
	for i, v in ipairs(self._rabbet_cell_list) do
		if v.level < 3 then
			return false
		end
	end

	return true
end

function PutCubeGameView:_releaseDragItem()
	if self.drag_data then
		gohelper.setActive(self.drag_container_transform:Find(self.drag_data.drag_id).gameObject, false)
	end

	self.drag_data = nil

	gohelper.setActive(self.drag_container, false)
end

function PutCubeGameView:_onBtnRevertLastOperation()
	if self.step_data and #self.step_data > 0 then
		local step = table.remove(self.step_data)
		local cube_id = step.config.id

		self.debris_count_dic[cube_id] = self.debris_count_dic[cube_id] + 1

		for i, v in ipairs(step.fill_cell) do
			v.level = v.level - 1

			v:onOpen()
		end

		self:_refreshDebrisList()
	end
end

function PutCubeGameView:onClose()
	local transform = self._goContent.transform
	local child_count = transform.childCount

	for i = 0, child_count - 1 do
		local obj = transform:GetChild(i):Find("item/slot").gameObject

		SLFramework.UGUI.UIDragListener.Get(obj):RemoveDragBeginListener()
		SLFramework.UGUI.UIDragListener.Get(obj):RemoveDragListener()
		SLFramework.UGUI.UIDragListener.Get(obj):RemoveDragEndListener()
	end
end

function PutCubeGameView:onDestroyView()
	return
end

return PutCubeGameView
