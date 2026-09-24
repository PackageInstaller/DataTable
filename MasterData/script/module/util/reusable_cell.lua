local var_0_0 = {}
local var_0_1 = lx
local var_0_3 = UnityEngine.Vector3(1, 1, 1)
local var_0_4 = UnityEngine.CanvasGroup

lx.define_class("reusable_cell", function(arg_1_0)
	function arg_1_0:init()
		self._mgr:Init()
		self:update_cell_rect(self._mgr.maxCount - 1)

		self._items = {}

		for iter_2_0 = 0, self._mgr.maxCount - 1 do
			local var_2_0
			local var_2_1

			if self._is_load_ui then
				var_2_1 = self._ui_owner:loadUI(self._prefab)

				var_2_1._panel.transform:SetParent(self._content.transform)

				var_2_0 = var_2_1
			else
				var_2_0 = self._ui_owner:loadUIPrefab(self._prefab)

				var_2_0._panel.transform:SetParent(self._content.transform)

				var_2_1 = var_2_0._control
			end

			var_2_0._panel.transform.localScale = var_0_3
			self._items[iter_2_0] = {
				is_visible = false,
				cell = var_2_0._panel:GetComponent(typeof(ItemBase)),
				control = var_2_1,
				cell_rect = self._cell_rec_dic[iter_2_0],
				canvas_group = self:add_canvas_group_component_to_panel(var_2_0)
			}

			var_2_0:setVisible(true)
			self:set_lookable(self._items[iter_2_0], false)
			self._mgr:UpdateCellPosition(var_2_0._panel, iter_2_0)
		end

		self._mgr:SetContentSize(self._mgr.maxCount - 1)

		self._is_init = true
	end

	function arg_1_0.add_canvas_group_component_to_panel(arg_3_0, arg_3_1)
		return arg_3_1._panel:GetComponent(typeof(var_0_4)) or arg_3_1._panel:AddComponent(typeof(var_0_4))
	end

	function arg_1_0.set_lookable(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1.canvas_group.alpha = arg_4_2 and 1 or 0
		arg_4_1.canvas_group.blocksRaycasts = not not arg_4_2
	end

	function arg_1_0:get_all_item()
		return self._items
	end

	function arg_1_0:update_cell_rect(arg_6_1)
		self._cell_rec_dic = {}

		for iter_6_0 = 0, arg_6_1 do
			if self._mgr.Direction == ScrollDirection.Horizontal then
				self._cell_rec_dic[iter_6_0] = {
					x = math.floor(iter_6_0 / self._mgr.RowCount) * self:get_x(),
					y = math.floor(iter_6_0 % self._mgr.RowCount) * self:get_y(),
					width = self._mgr.CellSize.x,
					height = self._mgr.CellSize.y,
					index = iter_6_0
				}
			else
				local var_6_0 = {
					x = math.floor(iter_6_0 % self._mgr.ColumnCount) * self:get_x()
				}

				var_6_0.y = -self._mgr.CellSize.y - math.floor(iter_6_0 / self._mgr.ColumnCount) * self:get_y()
				var_6_0.width = self._mgr.CellSize.x
				var_6_0.height = self._mgr.CellSize.y
				var_6_0.index = iter_6_0
				self._cell_rec_dic[iter_6_0] = var_6_0
			end
		end
	end

	function arg_1_0:update()
		if not self._is_init then
			return
		end

		if self._already_do then
			if not self._mgr:CheckSetMaskRect() then
				return
			end
		else
			self._already_do = true
		end

		local var_7_0 = {}
		local var_7_1 = self._mgr.maskRect.xMax
		local var_7_2 = self._mgr.maskRect.xMin
		local var_7_3 = self._mgr.maskRect.yMax
		local var_7_4 = self._mgr.maskRect.yMin

		for iter_7_0, iter_7_1 in pairs(self._cell_rec_dic) do
			self._over = var_7_1 > iter_7_1.x and var_7_2 < iter_7_1.width + iter_7_1.x and var_7_3 > iter_7_1.y and var_7_4 < iter_7_1.height + iter_7_1.y

			if self._over then
				var_7_0[iter_7_1.index] = iter_7_1
			end
		end

		for iter_7_2 = 0, #self._items do
			if self._items[iter_7_2] and self._items[iter_7_2].cell_rect and not self:contains_key(var_7_0, self._items[iter_7_2].cell_rect.index) then
				if self._recycle_func then
					self._recycle_func(self._items[iter_7_2].cell_rect.index)
				end

				self._items[iter_7_2].cell_rect = nil

				if self._items[iter_7_2].is_visible then
					self._items[iter_7_2].is_visible = false

					self:set_lookable(self._items[iter_7_2], false)
				end
			end
		end

		for iter_7_3, iter_7_4 in pairs(var_7_0) do
			local var_7_5 = self:get_next_item()

			if self:get_null_cell_item(iter_7_4) == nil and var_7_5 then
				var_7_5.cell_rect = iter_7_4

				if not var_7_5.is_visible then
					var_7_5.is_visible = true

					self:set_lookable(var_7_5, true)
				end

				self._mgr:UpdateCellPosition(var_7_5.cell.gameObject, iter_7_4.index)

				if iter_7_4.index < self._length and self._set_func then
					self._set_func(var_7_5.control, iter_7_4.index)
				end
			end
		end
	end

	function arg_1_0:get_null_cell_item(arg_8_1)
		for iter_8_0 = 0, #self._items do
			if self._items[iter_8_0] and self._items[iter_8_0].cell_rect ~= nil and arg_8_1.index == self._items[iter_8_0].cell_rect.index then
				return self._items[iter_8_0]
			end
		end

		return nil
	end

	function arg_1_0:get_next_item()
		for iter_9_0 = 0, #self._items do
			if self._items[iter_9_0] and self._items[iter_9_0].cell_rect == nil then
				return self._items[iter_9_0]
			end
		end

		return nil
	end

	function arg_1_0:clear_all()
		if self._items then
			for iter_10_0 = 0, #self._items do
				if self._items[iter_10_0] then
					self._items[iter_10_0].cell_rect = nil

					if self._items[iter_10_0].is_visible then
						self._items[iter_10_0].is_visible = false

						self:set_lookable(self._items[iter_10_0], false)
					end
				end
			end
		end

		self._recycle_func = nil
		self._set_func = nil
	end

	function arg_1_0.contains_key(arg_11_0, arg_11_1, arg_11_2)
		return not not arg_11_1[arg_11_2]
	end

	function arg_1_0:get_x()
		return self._mgr.CellSize.x + self._mgr.SpacingSize.x
	end

	function arg_1_0:get_y()
		return self._mgr.CellSize.y + self._mgr.SpacingSize.y
	end

	function arg_1_0:set_data(arg_14_1)
		self:update_cell_rect(#arg_14_1 - 1)
		self._mgr:SetContentSize(#arg_14_1)

		self._data = arg_14_1
		self._length = #self._data

		self:clear_all()

		self._already_do = false
	end

	function arg_1_0.overlaps(arg_15_0, arg_15_1, arg_15_2)
		return arg_15_2.xMax > arg_15_1.x and arg_15_2.xMin < arg_15_1.width + arg_15_1.x and arg_15_2.yMax > arg_15_1.y and arg_15_2.yMin < arg_15_1.height + arg_15_1.y
	end
end)

function var_0_0.create(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = var_0_1.class("reusable_cell")

	var_16_0._ui_owner = arg_16_1
	var_16_0._mgr = arg_16_2
	var_16_0._content = arg_16_3
	var_16_0._items = nil
	var_16_0._cell_rec_dic = nil
	var_16_0._is_init = false
	var_16_0._prefab = arg_16_4
	var_16_0._parent = arg_16_5
	var_16_0._data = nil
	var_16_0._set_func = nil
	var_16_0._recycle_func = nil
	var_16_0._is_load_ui = arg_16_6
	var_16_0._over = false
	var_16_0._already_do = false
	var_16_0._length = 0

	return var_16_0
end

return var_0_0
