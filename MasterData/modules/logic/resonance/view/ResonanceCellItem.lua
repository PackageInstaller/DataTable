-- chunkname: @modules/logic/resonance/view/ResonanceCellItem.lua

module("modules.logic.resonance.view.ResonanceCellItem", package.seeall)

local ResonanceCellItem = class("ResonanceCellItem", UserDataDispose)

function ResonanceCellItem:ctor(gameObject, pos_x, pos_y, parent_view)
	self:__onInit()

	self.gameObject = gameObject
	self.transform = self.gameObject.transform
	self.is_filled = false
	self.filled_count = 0
	self.pos_x = pos_x
	self.pos_y = pos_y
	self.parent_view = parent_view
	self.top_line = self.transform:Find("top")
	self.bottom_line = self.transform:Find("bottom")
	self.left_line = self.transform:Find("left")
	self.right_line = self.transform:Find("right")

	self.addClickCb(self, SLFramework.UGUI.UIClickListener.Get(self.gameObject), self._onCubeClick, self)

	self._dragListener = SLFramework.UGUI.UIDragListener.Get(self.gameObject)

	self._dragListener:AddDragBeginListener(self._onDragBegin, self)
	self._dragListener:AddDragListener(self._onDrag, self)
	self._dragListener:AddDragEndListener(self._onDragEnd, self)

	self.position_x = recthelper.getAnchorX(self.transform)
	self.position_y = recthelper.getAnchorY(self.transform)
	self.left_x = self.position_x - self.parent_view.cell_length / 2
	self.right_x = self.left_x + self.parent_view.cell_length
	self.top_y = self.position_y + self.parent_view.cell_length / 2
	self.bottom_y = self.top_y - self.parent_view.cell_length

	local lattice = self.transform:Find("lattice")

	self.empty_bg = lattice and lattice.gameObject
end

function ResonanceCellItem:detectPosCover(x, y)
	if x > self.left_x and x < self.right_x and y > self.bottom_y and y < self.top_y then
		return true
	end
end

ResonanceCellItem.color = {
	green = "green",
	red = "red",
	white = "white",
	grey = "grey"
}

function ResonanceCellItem:_setLineColor(line, color)
	for k, v in pairs(ResonanceCellItem.color) do
		local transform = line:Find(v)

		if transform then
			gohelper.setActive(transform.gameObject, color == v)
		end
	end
end

function ResonanceCellItem:SetRed()
	self:_setLineColor(self.top_line, ResonanceCellItem.color.red)
	self:_setLineColor(self.right_line, ResonanceCellItem.color.red)
	self:_setLineColor(self.bottom_line, ResonanceCellItem.color.red)
	self:_setLineColor(self.left_line, ResonanceCellItem.color.red)
	gohelper.setAsLastSibling(self.gameObject)
end

function ResonanceCellItem:SetGreen()
	gohelper.setAsLastSibling(self.gameObject)
end

function ResonanceCellItem:hideEmptyBg()
	gohelper.setActive(self.empty_bg, false)
end

function ResonanceCellItem:SetNormal(put_cube)
	if self.empty_bg then
		gohelper.setActive(self.empty_bg, self.parent_view.drag_data and not self.is_filled or false)
	end

	local rabbet_cell = self.parent_view:getRabbetCell()
	local left_cell = rabbet_cell[self.pos_y][self.pos_x - 1]

	if rabbet_cell[self.pos_y - 1] then
		local top_cell = rabbet_cell[self.pos_y - 1][self.pos_x]
		local right_cell = rabbet_cell[self.pos_y][self.pos_x + 1]

		if rabbet_cell[self.pos_y + 1] then
			local bottom_cell = rabbet_cell[self.pos_y + 1][self.pos_x]
			local put_cube_ani = self.parent_view.put_cube_ani
			local show_line_effect = false

			if put_cube and self.cell_data and put_cube_ani and put_cube_ani.drag_id == self.cell_data.cubeId and put_cube_ani.direction == self.cell_data.direction and put_cube_ani.posX == self.cell_data.posX and put_cube_ani.posY == self.cell_data.posY then
				show_line_effect = true
				self.parent_view.effect_showed = true
			end

			if self.cell_data and left_cell and left_cell.cell_data == self.cell_data and self.is_filled then
				self:hideLeft()
			else
				self:_setLineColor(self.left_line, ResonanceCellItem.color.grey)

				if show_line_effect then
					if not self.left_yanwu then
						self.left_yanwu = gohelper.clone(self.parent_view.go_yanwu, self.gameObject)

						recthelper.setAnchor(self.left_yanwu.transform, -38.4, 0)
						transformhelper.setLocalRotation(self.left_yanwu.transform, 0, 0, 90)
					end

					gohelper.setActive(self.left_yanwu, false)
					gohelper.setActive(self.left_yanwu, true)
				end
			end

			if self.cell_data and top_cell and top_cell.cell_data == self.cell_data and self.is_filled then
				self:hideTop()
			else
				self:_setLineColor(self.top_line, ResonanceCellItem.color.grey)

				if show_line_effect then
					if not self.top_yanwu then
						self.top_yanwu = gohelper.clone(self.parent_view.go_yanwu, self.gameObject)

						recthelper.setAnchor(self.top_yanwu.transform, 0, 38.4)
					end

					gohelper.setActive(self.top_yanwu, false)
					gohelper.setActive(self.top_yanwu, true)
				end
			end

			if self.cell_data and right_cell and right_cell.cell_data == self.cell_data and self.is_filled then
				self:hideRight()
			else
				self:_setLineColor(self.right_line, ResonanceCellItem.color.grey)

				if show_line_effect then
					if not self.right_yanwu then
						self.right_yanwu = gohelper.clone(self.parent_view.go_yanwu, self.gameObject)

						recthelper.setAnchor(self.right_yanwu.transform, 38.2, 0)
						transformhelper.setLocalRotation(self.right_yanwu.transform, 0, 0, -90)
					end

					gohelper.setActive(self.right_yanwu, false)
					gohelper.setActive(self.right_yanwu, true)
				end
			end

			if self.cell_data and bottom_cell and bottom_cell.cell_data == self.cell_data and self.is_filled then
				self:hideBottom()
			else
				self:_setLineColor(self.bottom_line, ResonanceCellItem.color.grey)

				if show_line_effect then
					if not self.bottom_yanwu then
						self.bottom_yanwu = gohelper.clone(self.parent_view.go_yanwu, self.gameObject)

						recthelper.setAnchor(self.bottom_yanwu.transform, 0, -37.9)
						transformhelper.setLocalRotation(self.bottom_yanwu.transform, 0, 0, -180)
					end

					gohelper.setActive(self.bottom_yanwu.gameObject, false)
					gohelper.setActive(self.bottom_yanwu.gameObject, true)
				end
			end

			self:_activeStyleBg()
		end
	end
end

function ResonanceCellItem:hideTop()
	self:_setLineColor(self.top_line, ResonanceCellItem.color.white)
end

function ResonanceCellItem:hideRight()
	self:_setLineColor(self.right_line, ResonanceCellItem.color.white)
end

function ResonanceCellItem:hideBottom()
	self:_setLineColor(self.bottom_line, ResonanceCellItem.color.white)
end

function ResonanceCellItem:hideLeft()
	self:_setLineColor(self.left_line, ResonanceCellItem.color.white)
end

function ResonanceCellItem:lightTop()
	self:_setLineColor(self.top_line, ResonanceCellItem.color.green)
	self:SetGreen()
end

function ResonanceCellItem:lightRight()
	self:_setLineColor(self.right_line, ResonanceCellItem.color.green)
	self:SetGreen()
end

function ResonanceCellItem:lightBottom()
	self:_setLineColor(self.bottom_line, ResonanceCellItem.color.green)
	self:SetGreen()
end

function ResonanceCellItem:lightLeft()
	self:_setLineColor(self.left_line, ResonanceCellItem.color.green)
	self:SetGreen()
end

function ResonanceCellItem:_activeStyleBg()
	local showStyleBg = self.is_filled

	if self.parent_view and self.parent_view.hero_mo_data then
		self.mainCubeId = self.parent_view.hero_mo_data.talentCubeInfos.own_main_cube_id
	end

	if self.is_filled and self.cell_data then
		showStyleBg = self.cell_data.cubeId == self.mainCubeId
	end
end

function ResonanceCellItem:setCellData(data)
	self.cell_data = data
end

function ResonanceCellItem:_refreshCell()
	self:_activeStyleBg()
end

function ResonanceCellItem:clickCube()
	self:_onCubeClick()
end

function ResonanceCellItem:_onCubeClick()
	if self.is_filled then
		local cur_select_cell_data = self.parent_view.cur_select_cell_data

		if cur_select_cell_data and self.cell_data and cur_select_cell_data.cubeId == self.cell_data.cubeId and cur_select_cell_data.direction == self.cell_data.direction and cur_select_cell_data.posX == self.cell_data.posX and cur_select_cell_data.posY == self.cell_data.posY then
			self.parent_view:onCubeClick(self.cell_data)
		else
			self.parent_view:_btnCloseTipOnClick()

			self.parent_view.cur_select_cell_data = tabletool.copy(self.cell_data)

			self.parent_view:showCurSelectCubeAttr(self.cell_data)
		end
	end
end

function ResonanceCellItem:_onDragBegin(param, pointerEventData)
	if self.is_filled then
		self.parent_view:_onGetCube(self.cell_data)
		self.parent_view:_onContainerDragBegin(param, pointerEventData)
	end
end

function ResonanceCellItem:_onDrag(param, pointerEventData)
	self.parent_view:_onContainerDrag(param, pointerEventData)
end

function ResonanceCellItem:_onDragEnd()
	self.parent_view:_onDragEnd()
end

function ResonanceCellItem:releaseSelf()
	if self._dragListener then
		self._dragListener:RemoveDragBeginListener()
		self._dragListener:RemoveDragListener()
		self._dragListener:RemoveDragEndListener()
	end

	self:__onDispose()

	self.cell_data = nil
	self.parent_view = nil
end

return ResonanceCellItem
