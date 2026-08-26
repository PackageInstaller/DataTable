-- chunkname: @modules/logic/dungeon/view/puzzle/PutCubeGameItemView.lua

module("modules.logic.dungeon.view.puzzle.PutCubeGameItemView", package.seeall)

local PutCubeGameItemView = class("PutCubeGameItemView", BaseView)

function PutCubeGameItemView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function PutCubeGameItemView:addEvents()
	return
end

function PutCubeGameItemView:removeEvents()
	return
end

function PutCubeGameItemView:_editableInitView()
	return
end

function PutCubeGameItemView:onUpdateParam()
	return
end

function PutCubeGameItemView:ctor(ori_level, parent_view)
	PutCubeGameItemView.super.ctor(self)

	self.ori_level = ori_level
	self.level = ori_level
	self.parent_view = parent_view
end

function PutCubeGameItemView:onOpen()
	gohelper.findChild(self.viewGO, "Text"):GetComponent(gohelper.Type_Text).text = self.level
	self.left_x = recthelper.getAnchorX(self.viewGO.transform) - self.parent_view.cell_length / 2
	self.right_x = recthelper.getAnchorX(self.viewGO.transform) + self.parent_view.cell_length / 2
	self.bottom_y = recthelper.getAnchorY(self.viewGO.transform) - self.parent_view.cell_length / 2
	self.top_y = recthelper.getAnchorY(self.viewGO.transform) + self.parent_view.cell_length / 2
end

function PutCubeGameItemView:detectPosCover(x, y)
	if x > self.left_x and x < self.right_x and y > self.bottom_y and y < self.top_y then
		return true
	end
end

function PutCubeGameItemView:_onGameClear()
	return
end

function PutCubeGameItemView:onClose()
	return
end

function PutCubeGameItemView:onDestroyView()
	return
end

return PutCubeGameItemView
