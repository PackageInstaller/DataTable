-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/sudoku/VersionActivity2_4SudokuNumItem.lua

module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuNumItem", package.seeall)

local VersionActivity2_4SudokuNumItem = class("VersionActivity2_4SudokuNumItem", ListScrollCellExtend)
local normalNumColor = "#615448"
local correctNumColor = "#22402d"
local wrongNumColor = "#a86363"
local editableNumWrongColor = "#991d1d"
local animationType = typeof(UnityEngine.Animation)

function VersionActivity2_4SudokuNumItem:onInitView()
	self._numText = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "clickArea")
	self._go_UnFilledBG = gohelper.findChild(self.viewGO, "#go_UnFilledBG")
	self._go_Same = gohelper.findChild(self.viewGO, "#go_Same")
	self._go_WrongCircle = gohelper.findChild(self.viewGO, "#go_WrongCircle")
	self._go_WrongBG = gohelper.findChild(self.viewGO, "#go_WrongBG")
	self._go_CorrectBG = gohelper.findChild(self.viewGO, "#go_CorrectBG")
	self._wrongBGAnim = self._go_WrongBG:GetComponent(animationType)
	self._correctAnim = self._go_CorrectBG:GetComponent(animationType)
	self._sameAnim = self._go_Same:GetComponent(animationType)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4SudokuNumItem:addEvents()
	self._btn:AddClickListener(self._clickItem, self)
end

function VersionActivity2_4SudokuNumItem:removeEvents()
	self._btn:RemoveClickListener()
end

function VersionActivity2_4SudokuNumItem:_clickItem()
	VersionActivity2_4SudokuModel.instance:selectItem(self._idx)
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectItem, self._idx)
end

function VersionActivity2_4SudokuNumItem:_editableInitView()
	gohelper.setActive(self._go_Same, false)
	gohelper.setActive(self._go_WrongCircle, false)
end

function VersionActivity2_4SudokuNumItem:_editableAddEvents()
	return
end

function VersionActivity2_4SudokuNumItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4SudokuNumItem:setItemData(num, idx, cellIdx, groupIdx)
	self._num = num
	self._idx = idx
	self._cellIdx = cellIdx
	self._groupIdx = groupIdx
	self._editable = not self._num or self._num == 0

	self:refreshUI()
	gohelper.setActive(self._go_UnFilledBG, not self._num or self._num == 0)
end

function VersionActivity2_4SudokuNumItem:setItemVaild(valid)
	self._valid = valid
end

function VersionActivity2_4SudokuNumItem:setItemNum(num)
	self._num = num
end

function VersionActivity2_4SudokuNumItem:getItemNum()
	return self._num
end

function VersionActivity2_4SudokuNumItem:getItemIdx()
	return self._idx
end

function VersionActivity2_4SudokuNumItem:isEditable()
	return self._editable
end

function VersionActivity2_4SudokuNumItem:refreshUI()
	self._numText.text = self._num
end

function VersionActivity2_4SudokuNumItem:refreshSelectView(isSelected)
	gohelper.setActive(self._go_WrongCircle, isSelected)

	if self._editable then
		if not editableNumWrongColor then
			local wrongColor = wrongNumColor
			local numColor = normalNumColor

			numColor = self._editable and (self._valid and correctNumColor or wrongColor) or normalNumColor

			SLFramework.UGUI.GuiHelper.SetColor(self._numText, numColor)

			if not self._editable then
				gohelper.setActive(self._go_CorrectBG, false)
				gohelper.setActive(self._go_UnFilledBG, false)
			elseif self._num == 0 or self._valid then
				gohelper.setActive(self._go_CorrectBG, isSelected)
				gohelper.setActive(self._go_UnFilledBG, not isSelected)
			else
				gohelper.setActive(self._go_CorrectBG, false)
				gohelper.setActive(self._go_UnFilledBG, false)
			end
		end
	end
end

function VersionActivity2_4SudokuNumItem:refreshValidView(valid, show, muteAni)
	self._wrongBGAnim.enabled = not muteAni
	self._correctAnim.enabled = not muteAni

	gohelper.setActive(self._go_CorrectBG, valid and show)
	gohelper.setActive(self._go_WrongBG, not valid and show)
	gohelper.setActive(self._go_UnFilledBG, self._editable and not show)

	if self._editable then
		if not editableNumWrongColor then
			local wrongColor = wrongNumColor
			local numColor = normalNumColor

			numColor = self._editable and (valid and correctNumColor or wrongColor) or normalNumColor

			SLFramework.UGUI.GuiHelper.SetColor(self._numText, numColor)
		end
	end
end

function VersionActivity2_4SudokuNumItem:refreshSameNumView(show, muteAni)
	gohelper.setActive(self._go_Same, show)

	self._sameAnim.enabled = not muteAni
end

function VersionActivity2_4SudokuNumItem:refreshGuideView(isGuide)
	gohelper.setActive(self._go_UnFilledBG, self._editable and not isGuide)
end

function VersionActivity2_4SudokuNumItem:onDestroyView()
	return
end

return VersionActivity2_4SudokuNumItem
