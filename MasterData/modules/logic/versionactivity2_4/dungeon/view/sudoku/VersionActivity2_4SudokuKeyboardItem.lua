-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/sudoku/VersionActivity2_4SudokuKeyboardItem.lua

module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuKeyboardItem", package.seeall)

local VersionActivity2_4SudokuKeyboardItem = class("VersionActivity2_4SudokuKeyboardItem", ListScrollCellExtend)
local animationType = typeof(UnityEngine.Animation)

function VersionActivity2_4SudokuKeyboardItem:onInitView()
	self._numText = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "clickArea")
	self._go_CorrectBG = gohelper.findChild(self.viewGO, "#go_CorrectBG")
	self._go_UnFilledBG = gohelper.findChild(self.viewGO, "#go_UnFilledBG")
	self._go_Same = gohelper.findChild(self.viewGO, "#go_Same")
	self._go_WrongBG = gohelper.findChild(self.viewGO, "#go_WrongBG")
	self._go_WrongCircle = gohelper.findChild(self.viewGO, "#go_WrongCircle")
	self._wrongBGAnim = self._go_WrongBG:GetComponent(animationType)
	self._correctAnim = self._go_CorrectBG:GetComponent(animationType)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4SudokuKeyboardItem:addEvents()
	self._btn:AddClickListener(self._clickItem, self)
end

function VersionActivity2_4SudokuKeyboardItem:removeEvents()
	self._btn:RemoveClickListener()
end

function VersionActivity2_4SudokuKeyboardItem:_clickItem()
	VersionActivity2_4SudokuController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuSelectKeyboard, self._idx)
end

function VersionActivity2_4SudokuKeyboardItem:_editableInitView()
	gohelper.setActive(self._go_Same, false)
	gohelper.setActive(self._go_CorrectBG, false)
end

function VersionActivity2_4SudokuKeyboardItem:_editableAddEvents()
	return
end

function VersionActivity2_4SudokuKeyboardItem:_editableRemoveEvents()
	return
end

function VersionActivity2_4SudokuKeyboardItem:setItemData(num, idx)
	self._num = num
	self._idx = idx

	self:refreshUI()
end

function VersionActivity2_4SudokuKeyboardItem:getItemNum()
	return self._num
end

function VersionActivity2_4SudokuKeyboardItem:refreshUI()
	self._numText.text = self._num
end

function VersionActivity2_4SudokuKeyboardItem:refreshValidView(valid, muteAni)
	self._wrongBGAnim.enabled = not muteAni
	self._correctAnim.enabled = not muteAni

	if valid then
		gohelper.setActive(self._go_WrongBG, false)
		gohelper.setActive(self._go_CorrectBG, true)
	else
		gohelper.setActive(self._go_WrongBG, true)
		gohelper.setActive(self._go_CorrectBG, false)
	end
end

function VersionActivity2_4SudokuKeyboardItem:resetState()
	gohelper.setActive(self._go_WrongBG, false)
	gohelper.setActive(self._go_CorrectBG, false)
end

function VersionActivity2_4SudokuKeyboardItem:onDestroyView()
	return
end

return VersionActivity2_4SudokuKeyboardItem
