-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/sudoku/VersionActivity2_4SudokuView.lua

module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuView", package.seeall)

local VersionActivity2_4SudokuView = class("VersionActivity2_4SudokuView", BaseView)
local numCountPerGroup = 9
local numCountPerRow = 9
local groupCountPerLine = 3
local keyBoardNums = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}
local signatureId = "3025"
local sudokuGuideId = 24101
local drawLineAniName = "girdin"
local stage1InAniName = "stage1in"
local stage2InAniName = "stage2in"
local stage1To2AniName = "stage1to2"
local ctrl = VersionActivity2_4SudokuController.instance
local eventMap = VersionActivity2_4DungeonEvent
local sudokuCfgId = 1001

function VersionActivity2_4SudokuView:onInitView()
	self._goStage1 = gohelper.findChild(self.viewGO, "Rotate/Stage1")
	self._goStage2 = gohelper.findChild(self.viewGO, "Rotate/Stage2")
	self._goSmallNumGridRoot = gohelper.findChild(self.viewGO, "Rotate/Stage1/Root/Grid")
	self._goSmallNumGridItem = gohelper.findChild(self.viewGO, "Rotate/Stage1/Root/Grid/#go_Item")
	self._goNumGridRoot = gohelper.findChild(self.viewGO, "Rotate/Stage2/Root/Grid")
	self._goNumGridItem = gohelper.findChild(self.viewGO, "Rotate/Stage2/Root/Grid/#go_Item")
	self._goKeyBoardGridRoot = gohelper.findChild(self.viewGO, "Rotate/Stage2/KeyBoard/Grid")
	self._goKeyBoardGridItem = gohelper.findChild(self.viewGO, "Rotate/Stage2/KeyBoard/Grid/#go_Item")
	self._go_complete = gohelper.findChild(self.viewGO, "#go_complete")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "btn_exit")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._btnUndo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_return")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "#simage_signature")
	self._go_topleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4SudokuView:addEvents()
	self._btnExit:AddClickListener(self._onEscBtnClick, self)
	self._btnReset:AddClickListener(self._onResetBtnClick, self)
	self._btnUndo:AddClickListener(self._onUndoBtnClick, self)
end

function VersionActivity2_4SudokuView:removeEvents()
	self._btnExit:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnUndo:RemoveClickListener()
end

function VersionActivity2_4SudokuView:_onEscBtnClick()
	ctrl:dispatchEvent(eventMap.SudokuCompleted)
	self:closeThis()
end

function VersionActivity2_4SudokuView:_onResetBtnClick()
	ctrl:resetGame()
end

function VersionActivity2_4SudokuView:_onUndoBtnClick()
	ctrl:excuteLastCmd()
end

function VersionActivity2_4SudokuView:_editableInitView()
	self._numItems = {}
	self._smallNumItems = {}
	self._curEditItem = nil
	self._keyboardItems = {}
	self._curKeyboardItem = nil
	self._curIdx = 0
end

function VersionActivity2_4SudokuView:onUpdateParam()
	self:onOpen()
end

function VersionActivity2_4SudokuView:onOpen()
	self.addEventCb(self, ctrl, eventMap.SudokuSelectItem, self._onSelectedNumItem, self)
	self.addEventCb(self, ctrl, eventMap.SudokuSelectKeyboard, self._onSelectedKeyboard, self)
	self.addEventCb(self, ctrl, eventMap.DoSudokuCmd, self._doSudokuCmd, self)
	self.addEventCb(self, ctrl, eventMap.SudokuReset, self._doSudokuReset, self)
	self.addEventCb(self, ctrl, eventMap.SudokuViewAni, self._doViewAnimation, self)

	if GuideModel.instance:isGuideFinish(sudokuGuideId) or GuideController.instance:isForbidGuides() then
		gohelper.setActive(self._goStage2, true)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
		self._viewAnimator:Play(stage2InAniName, 0, 0)
	else
		self._viewAnimator:Play(stage1InAniName, 0, 0)

		self._inGuide = true
	end

	self:_createNumItems()
	self:_createKeyboardItems()
	self:_createSmallNumItems(self._allNum)
end

function VersionActivity2_4SudokuView:onClose()
	return
end

function VersionActivity2_4SudokuView:onDestroyView()
	self._simagesignature:UnLoadImage()
end

function VersionActivity2_4SudokuView:_createSmallNumItems(numList)
	gohelper.CreateObjList(self, self._createSmallNumItem, numList, self._goSmallNumGridRoot, self._goSmallNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function VersionActivity2_4SudokuView:_createSmallNumItem(numItemComp, num, index)
	self._smallNumItems[index] = numItemComp

	numItemComp:setItemData(num, index, nil, nil)

	if self._inGuide then
		numItemComp:refreshGuideView(true)
	end
end

function VersionActivity2_4SudokuView:_createNumItems()
	self._allNum = {}
	self._rowItems = {}
	self._colItems = {}
	self._groupItems = {}
	self._idx2CellIdx = {}
	self._idx2GroupIdx = {}
	self._emptyItem2Vaild = {}
	self._sameNumItems = {}
	self._conflictItems = {}
	self._sudukuCfg = VersionActivity2_4SudokuModel.instance:getSudokuCfg(sudokuCfgId)

	for cellGroupIdx, cellGroups in ipairs(self._sudukuCfg) do
		for cellIdx, num in ipairs(cellGroups) do
			local idx = self:_groupCellIdx2Idx(cellGroupIdx, cellIdx)

			self._allNum[idx] = num
			self._idx2CellIdx[idx] = cellIdx
			self._idx2GroupIdx[idx] = cellGroupIdx

			if num == 0 then
				self._emptyItem2Vaild[idx] = false
			end
		end
	end

	gohelper.CreateObjList(self, self._createNumItem, self._allNum, self._goNumGridRoot, self._goNumGridItem, VersionActivity2_4SudokuNumItem, 1)
end

function VersionActivity2_4SudokuView:_createNumItem(numItemComp, num, index)
	local groupIdx, cellIdx = self:_idx2GroupCellIdx(index)
	local row, col = self:_idx2RowCol(index)

	self._numItems[index] = numItemComp
	self._rowItems[row] = self._rowItems[row] or {}
	self._colItems[col] = self._colItems[col] or {}
	self._rowItems[row][col] = numItemComp
	self._colItems[col][row] = numItemComp
	self._groupItems[groupIdx] = self._groupItems[groupIdx] or {}
	self._groupItems[groupIdx][cellIdx] = numItemComp

	local num = self._allNum[index]

	numItemComp:setItemData(num, index, groupIdx, cellIdx)
end

function VersionActivity2_4SudokuView:_resetItemState(items, sameNum, conflictNum)
	items = items or self._numItems

	for _, item in pairs(items) do
		if sameNum then
			item:refreshSameNumView(false)
		end

		if conflictNum then
			item:refreshValidView(item:isEditable() and self._emptyItem2Vaild[item:getItemIdx()] or false, false)
		end
	end
end

function VersionActivity2_4SudokuView:_getConflictItems(idx)
	local checkItem = self._numItems[idx]
	local curNum = checkItem:getItemNum()
	local row, col = self:_idx2RowCol(idx)
	local conflictItems = {}
	local rowItems = self._rowItems[row]

	for i, item in ipairs(rowItems) do
		if item:getItemNum() == curNum and i ~= col then
			conflictItems[item:getItemIdx()] = item
		end
	end

	local colItems = self._colItems[col]

	for i, item in ipairs(colItems) do
		if item:getItemNum() == curNum and i ~= row then
			conflictItems[item:getItemIdx()] = item
		end
	end

	local groupIdx, cellIdx = self:_idx2GroupCellIdx(idx)
	local groupItems = self._groupItems[groupIdx]

	for i, item in ipairs(groupItems) do
		if item:getItemNum() == curNum and i ~= cellIdx then
			conflictItems[item:getItemIdx()] = item
		end
	end

	return conflictItems
end

function VersionActivity2_4SudokuView:_getSameNumItems(idx)
	local checkItem = self._numItems[idx]
	local curNum = checkItem:getItemNum()
	local sameNumItems = {}

	if curNum ~= 0 then
		for i, item in ipairs(self._numItems) do
			if item:getItemNum() == curNum and i ~= idx then
				sameNumItems[i] = item
			end
		end
	end

	return sameNumItems
end

function VersionActivity2_4SudokuView:_getAllConflictItems()
	local allConflictItems = {}

	for idx, valid in pairs(self._emptyItem2Vaild) do
		if not valid then
			local item = self._numItems[idx]

			if item:getItemNum() > 0 then
				local conflictItems = self:_getConflictItems(idx)

				conflictItems[idx] = item

				for conflictIdx, item in pairs(conflictItems) do
					allConflictItems[conflictIdx] = item
				end
			end
		end
	end

	return allConflictItems
end

function VersionActivity2_4SudokuView:_createKeyboardItems()
	gohelper.CreateObjList(self, self._createKeyboardNumItem, keyBoardNums, self._goKeyBoardGridRoot, self._goKeyBoardGridItem, VersionActivity2_4SudokuKeyboardItem, 1)
end

function VersionActivity2_4SudokuView:_createKeyboardNumItem(numItemComp, num, index)
	local num = keyBoardNums[index]

	numItemComp:setItemData(num, index, nil, nil)

	self._keyboardItems[index] = numItemComp
end

function VersionActivity2_4SudokuView:_onSelectedKeyboard(num)
	if self._curKeyboardItem then
		self._curKeyboardItem:resetState()
	end

	self._curKeyboardItem = self._keyboardItems[num]

	local curIdx = VersionActivity2_4SudokuModel.instance:getSelectedItem()

	if curIdx then
		local curItem = self._numItems[curIdx]

		if not curItem:isEditable() then
			return
		end

		local oriNum = curItem:getItemNum()
		local sudokuCmd = VersionActivity2_4SudokuCmd.New(curIdx, oriNum, num)

		VersionActivity2_4SudokuController.instance:excuteNewCmd(sudokuCmd)
	end
end

function VersionActivity2_4SudokuView:_onSelectedNumItem(idx)
	if idx == self._curIdx then
		return
	end

	self._curIdx = idx

	self:_resetItemState(self._sameNumItems, true)

	if self._curEditItem then
		if self._curEditItem:isEditable() and self._emptyItem2Vaild[self._curEditItem:getItemIdx()] then
			self._curEditItem:refreshValidView(true, false)
		end

		self._curEditItem:refreshSelectView(false)
	end

	self._curEditItem = self._numItems[idx]

	if self._curEditItem then
		self._curEditItem:refreshSelectView(true)

		if self._curEditItem:isEditable() and self._emptyItem2Vaild[self._curEditItem:getItemIdx()] then
			self._curEditItem:refreshValidView(true, true)
		end
	end

	local curItemNum = self._curEditItem:getItemNum()
	local curItemValid = false

	if curItemNum > 0 then
		curItemValid = self:_checkValid(idx)
	end

	if self._curEditItem:isEditable() then
		if not self._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(curItemNum)

			self._curKeyboardItem = self._keyboardItems[curItemNum]

			if self._curKeyboardItem then
				self._curKeyboardItem:refreshValidView(curItemValid)
			end
		elseif curItemNum == self._curKeyboardItem:getItemNum() then
			self._curKeyboardItem:refreshValidView(curItemValid)
		else
			self._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(curItemNum)

			self._curKeyboardItem = self._keyboardItems[curItemNum]

			if self._curKeyboardItem then
				self._curKeyboardItem:refreshValidView(curItemValid)
			end
		end
	end

	if curItemNum > 0 then
		if self._sameNumItems and #self._sameNumItems > 0 then
			for _, sameNumItem in pairs(self._sameNumItems) do
				sameNumItem:refreshSameNumView(false)
			end
		end

		self._sameNumItems = self:_getSameNumItems(idx)

		for itemIdx, sameNumItem in pairs(self._sameNumItems) do
			sameNumItem:refreshSameNumView(self._conflictItems[itemIdx] == nil)
		end
	end
end

function VersionActivity2_4SudokuView:_doSudokuCmd(cmd)
	local idx = cmd:getIdx()
	local curItem = self._numItems[idx]
	local oriNum = curItem and curItem:getItemNum()
	local newNum = cmd:getNewNum()
	local isUndo = cmd:isUndo()

	if curItem and oriNum ~= newNum then
		self:_resetItemState(self._sameNumItems, true)
		curItem:setItemNum(newNum)
		curItem:refreshUI()

		local valid = self:_checkValid(idx)

		if not valid and not isUndo then
			ctrl:addErrorCount()
		end

		curItem:setItemVaild(valid)

		self._emptyItem2Vaild[idx] = valid

		if valid then
			for itemIdx, vaild in pairs(self._emptyItem2Vaild) do
				if itemIdx ~= idx then
					local item = self._numItems[itemIdx]
					local itemValid = self:_checkValid(itemIdx)

					self._emptyItem2Vaild[itemIdx] = itemValid

					item:setItemVaild(itemValid)
				end
			end
		end

		local oriConflictItems = self._conflictItems

		self._conflictItems = self:_getAllConflictItems()

		if not self._curKeyboardItem then
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(newNum)

			self._curKeyboardItem = self._keyboardItems[newNum]

			if self._curKeyboardItem then
				self._curKeyboardItem:refreshValidView(valid, isUndo)
			end
		elseif newNum == self._curKeyboardItem:getItemNum() then
			self._curKeyboardItem:refreshValidView(valid, isUndo)
		else
			self._curKeyboardItem:resetState()
			VersionActivity2_4SudokuModel.instance:selectKeyboardItem(newNum)

			self._curKeyboardItem = self._keyboardItems[newNum]

			if self._curKeyboardItem then
				self._curKeyboardItem:refreshValidView(valid, isUndo)
			end
		end

		for itemIdx, confictItem in pairs(self._conflictItems) do
			oriConflictItems[itemIdx] = nil

			confictItem:refreshValidView(false, true, isUndo)
		end

		self:_resetItemState(oriConflictItems, false, true, isUndo)

		self._sameNumItems = self:_getSameNumItems(idx)

		for itemIdx, sameNumItem in pairs(self._sameNumItems) do
			sameNumItem:refreshSameNumView(self._conflictItems[itemIdx] == nil, isUndo)
		end

		curItem:refreshValidView(valid, newNum ~= 0, isUndo)
	elseif self._curKeyboardItem then
		self._curKeyboardItem:refreshUI()
	end

	local isPass = self:_checkPass()

	if isPass then
		self:_refreshPassView()
		VersionActivity2_4SudokuController.instance:setStatResult("done")
		VersionActivity2_4SudokuController.instance:sendStat()
	end
end

function VersionActivity2_4SudokuView:_doSudokuReset()
	self:_resetItemState(self._conflictItems, false, true)
	self:_resetItemState(self._sameNumItems, true)

	if self._curKeyboardItem then
		self._curKeyboardItem:resetState()
	end

	for idx, valid in pairs(self._emptyItem2Vaild) do
		local item = self._numItems[idx]

		item:setItemNum(0)
		item:refreshUI()
		item:refreshSelectView(false)
		item:refreshValidView(false, false)

		self._emptyItem2Vaild[idx] = false
	end

	self._curIdx = nil
end

function VersionActivity2_4SudokuView:_refreshPassView()
	gohelper.setActive(self._go_complete, true)
	gohelper.setActive(self._btnExit.gameObject, true)
	gohelper.setActive(self._simagesignature.gameObject, true)
	gohelper.setActive(self._go_topleft, false)
	gohelper.setActive(self._btnUndo.gameObject, false)
	gohelper.setActive(self._btnReset.gameObject, false)
	self._simagesignature:UnLoadImage()
	self._simagesignature:LoadImage(ResUrl.getSignature(signatureId))
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	self:_resetItemState(self._conflictItems, false, true)
	self:_resetItemState(self._sameNumItems, true)

	if self._curKeyboardItem then
		self._curKeyboardItem:resetState()
	end

	for idx, valid in pairs(self._emptyItem2Vaild) do
		local item = self._numItems[idx]

		item:refreshValidView(true, false)

		self._emptyItem2Vaild[idx] = false
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_complete)
	self._curEditItem:refreshSelectView(false)
end

function VersionActivity2_4SudokuView:_doViewAnimation(aniName)
	if aniName == drawLineAniName then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_lvhu_clue_write_2)
	elseif aniName == stage1To2AniName then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_mln_page_turn)
	end

	self._viewAnimator:Play(aniName, 0, 0)
end

function VersionActivity2_4SudokuView:_checkValid(idx)
	local checkItem = self._numItems[idx]
	local curNum = checkItem:getItemNum()

	if curNum == 0 then
		return false
	end

	local row, col = self:_idx2RowCol(idx)
	local rowItems = self._rowItems[row]

	for i, item in ipairs(rowItems) do
		if item:getItemNum() == curNum and i ~= col then
			return false
		end
	end

	local colItems = self._colItems[col]

	for i, item in ipairs(colItems) do
		if item:getItemNum() == curNum and i ~= row then
			return false
		end
	end

	local groupIdx, cellIdx = self:_idx2GroupCellIdx(idx)
	local groupItems = self._groupItems[groupIdx]

	for i, item in ipairs(groupItems) do
		if item:getItemNum() == curNum and i ~= cellIdx then
			return false
		end
	end

	return true
end

function VersionActivity2_4SudokuView:_checkPass()
	for idx, valid in pairs(self._emptyItem2Vaild) do
		if not valid then
			return false
		end
	end

	return true
end

function VersionActivity2_4SudokuView:_idx2GroupCellIdx(idx)
	return self._idx2GroupIdx[idx], self._idx2CellIdx[idx]
end

function VersionActivity2_4SudokuView:_groupCellIdx2Idx(groupIdx, cellIdx)
	return math.floor((groupIdx - 1) / groupCountPerLine) * numCountPerGroup * groupCountPerLine + (groupIdx - 1) % groupCountPerLine * groupCountPerLine + math.floor((cellIdx - 1) / groupCountPerLine) * numCountPerGroup + (cellIdx - 1) % groupCountPerLine + 1
end

function VersionActivity2_4SudokuView:_idx2RowCol(idx)
	local row = math.floor((idx - 1) / numCountPerRow) + 1
	local col = math.floor((idx - 1) % numCountPerRow) + 1

	return row, col
end

return VersionActivity2_4SudokuView
