-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\TaskAchievePanel.lua

local ResAchieve = require("ClientData/ResAchieve")
local ResRandClient = require("ClientData/ResRandClient")
local TaskConfig = require("DesignerScript/TaskConfig")
local ResTrunkAchieveMisc = require("ClientData/ResTrunkAchieveMisc")
local ResItem = require("ClientData/ResItem")
local TaskAchievePanel = Class("TaskAchievePanel", UIControls.Child)
local BranchTaskCell = Class("BranchTaskCell", UIControls.ScrollViewLoopCell)

function BranchTaskCell:ctor(...)
	self:initUI()
end

function BranchTaskCell:initUI(...)
	self.bgImg = UIControls.Image(self, "TaskMainListCell/BgTask")
	self.titleTxt = UIControls.Label(self, "TaskMainListCell/RulePanel/TextRuleTitle")
	self.ruleTxt = UIControls.Label(self, "TaskMainListCell/RulePanel/TextRule")
	self.processSlider = UIControls.Slider(self, "TaskMainListCell/Slider")
	self.processTxt1 = UIControls.Label(self, "TaskMainListCell/TextNum1")
	self.processTxt2 = UIControls.Label(self, "TaskMainListCell/TextNum2")
	self.getAwardBtn = UIControls.Button(self, "TaskMainListCell/BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.gotoBtn = UIControls.Button(self, "TaskMainListCell/BtnGo")

	self.gotoBtn:addEventClick(self.onClickGotoBranch)

	self.itemImg = UIControls.Image(self, "TaskMainListCell/BgTask")
	self.efxPanel = UIControls.Panel(self, "TaskMainListCell/EfxGridItem")
	self.jumpLockTxt = UIControls.Label(self, "TaskMainListCell/TextLock")
	self.itemGridPath = "TaskMainListCell/GridItemPanel"
	self.anim = UIControls.UIAni(self, "")
end

function BranchTaskCell:setBranchTask(achieveId)
	if self.achieveId and self.achieveId == achieveId then
		return
	end

	self.achieveId = achieveId

	local achieveInfo = ResAchieve[achieveId]
	local iconPath = achieveInfo.icon_path
	local icon = achieveInfo.icon

	if iconPath and icon then
		self.bgImg:setImage(iconPath, icon)
	end

	if RegionUtils.isLangJP() then
		self.titleTxt:setVisible(false)
	else
		self.titleTxt:setText(achieveInfo.name or "")
	end

	self.ruleTxt:setText(achieveInfo.action_desc or "")

	local awardRandId = achieveInfo.award_randid

	if awardRandId and ResRandClient[awardRandId] and ResRandClient[awardRandId].show_ids then
		local itemId = ResRandClient[awardRandId].show_ids[1]
		local itemNum = ResRandClient[awardRandId].show_nums[1]

		if self.itemGrid and (self.itemGrid.object.id ~= itemId or self.itemGrid.object.num ~= itemNum) then
			self.itemGridContainer:destroy()

			self.itemGridContainer = nil
		end

		if not self.itemGridContainer then
			self.itemGridContainer = UIControls.getGridContainer(self, self.itemGridPath)

			local fakeItem = BaseObject.GetObject(itemId, itemNum)

			self.itemGridContainer:setObj(fakeItem)
			self.itemGridContainer:setVisible(true)

			self.itemGrid = self.itemGridContainer.grid
			self.itemGrid.mDisableWays = true
		end
	end

	self.needProgress = achieveInfo.action_param
	self.jumpId = achieveInfo.jump_guide_id
end

function BranchTaskCell:refreshBranchTask(...)
	local progress, needProgress = CurAvatar:getAchieveProcess(self.achieveId)

	self.processTxt1:setText(progress)
	self.processTxt2:setText(needProgress)

	local percent = progress / needProgress

	self.processSlider:setValue(percent)

	local isQuality = CurAvatar.achieveQualify[self.achieveId]
	local isGot = CurAvatar.achieveAwardGot[self.achieveId]
	local jumpLock, jumpLockDesc

	if self.jumpId ~= nil then
		jumpLock, jumpLockDesc = JumpGuideManager.isConditionLimited(self.jumpId)
	else
		jumpLock = false
	end

	self.gotoBtn:setVisible(not isQuality and self.jumpId ~= nil and not jumpLock)
	self.getAwardBtn:setVisible(isQuality and not isGot)
	self.itemImg:setImageGray(isGot)

	if self.itemGrid then
		self.itemGrid:setIconGray(isGot)
	end

	self.jumpLockTxt:setVisible(jumpLock)

	if jumpLock and jumpLockDesc then
		self.jumpLockTxt:setText(jumpLockDesc)
	end

	local nextState = "Nml"

	if not isQuality then
		-- block empty
	else
		nextState = not isGot and "High" or "Dis"
	end

	self:playStateAnimator(nextState)
	self.anim:startAni("ShowTaskMainListCell", true)
end

function BranchTaskCell:destroy(...)
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	BranchTaskCell.super.destroy(self)
end

function BranchTaskCell:onClickGetAward(...)
	if self.getAwardTimer then
		return
	end

	self.efxPanel:setVisible(true)

	local animName = "TaskMainListCellEnd"

	if self.mParent and self.mParent.branchAchieveData then
		local nextAchieveId = self.mParent.branchAchieveData:getGroupNextAchieve(self.achieveId)

		animName = nextAchieveId and CurAvatar.achieveQualify[nextAchieveId] and not CurAvatar.achieveAwardGot[nextAchieveId] and "TaskMainCellRepeatCellection" or animName
	end

	self.anim:startAni(animName, true)

	if self.itemGrid and self.itemGrid.object and BaseObject.isAttrs(self.itemGrid.object.id) then
		self.itemGrid:flyToCommonFuncEntryPanel()
	end

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function BranchTaskCell:_delayGetAward(...)
	self.efxPanel:setVisible(false)

	self.getAwardTimer = nil

	CurAvatar:getAchieveAward(self.achieveId)
end

function BranchTaskCell:onClickGotoBranch(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	end
end

local TrunkAchieveNode = Class("TrunkAchieveNode", UIControls.Child)

function TrunkAchieveNode:ctor(...)
	self:initUI()
end

function TrunkAchieveNode:initUI(...)
	self.simplePanel = UIControls.Panel(self, "SmallPanel")
	self.simpleNotGotPanel = UIControls.Panel(self, "SmallPanel/Nml")
	self.simpleGotPanel = UIControls.Panel(self, "SmallPanel/Light")
	self.showAwardBtn = UIControls.Button(self, "BtnAwardPoint")

	self.showAwardBtn:addEventClick(self._onClickViewAward)

	self.awardNotGotPanel = UIControls.Panel(self, "BtnAwardPoint/Nml")
	self.awardGotPanel = UIControls.Panel(self, "BtnAwardPoint/Light")
	self.awardMountPath = "BtnAwardPoint/AwardPanel"
	self.awardConfigId = 22
end

function TrunkAchieveNode:setAchieveNodeData(achieveId, index, totalCount)
	self.achieveId = achieveId

	local trunkAchieveData = CurAvatar:getUpperSystemData(Const.ACHEVE_UPPER_SYSTEM_TRUNKTASK)

	self.specialDisplay = ResTrunkAchieveMisc[achieveId] ~= nil
	self.isSimple = not trunkAchieveData:achieveIsGroupEnd(achieveId) and not self.specialDisplay

	self.simplePanel:setVisible(self.isSimple)
	self.showAwardBtn:setVisible(not self.isSimple)

	if not self.isSimple then
		if self.awardGrid then
			self.awardGrid:destroy()
		end

		self.awardGrid = UIControls.getGridAwardContainer(self, self.awardMountPath)

		self.awardGrid:setContainerConfig(self.awardConfigId)

		local fakeItem

		if self.specialDisplay then
			local specInfo = ResTrunkAchieveMisc[achieveId]

			fakeItem = self:_displayFilter(specInfo.item_id, specInfo.item_num)
		else
			local trunkTaskInfo = ResAchieve[achieveId]

			if not trunkTaskInfo then
				return
			end

			local awardRandId = trunkTaskInfo.award_randid

			if awardRandId and ResRandClient[awardRandId] then
				fakeItem = self:_displayFilter(ResRandClient[awardRandId].show_ids, ResRandClient[awardRandId].show_nums)
			end
		end

		if fakeItem then
			self.awardGrid:setObj(fakeItem)

			self.awardGrid.grid.mEnableTips = false
			self.awardGrid.grid.mDisableWays = true

			self.awardGrid:setVisible(true)
		end
	end

	local posPercent = index / totalCount - 0.5

	self:setPosition(posPercent * 648)
end

function TrunkAchieveNode:_displayFilter(items, nums)
	local heroItem, ticketItem, headFrameItem

	for i, itemId in ipairs(items) do
		local fakeItem = BaseObject.GetObject(itemId, nums[i])

		if fakeItem:isHero() then
			heroItem = fakeItem
		elseif fakeItem.subType == Const.ITEM_STYPE_HEAD_FRAME then
			headFrameItem = fakeItem
		elseif (itemId == 510006 or itemId == 510001 or itemId == 510009) and (not ticketItem or itemId > ticketItem.id) then
			ticketItem = fakeItem
		end
	end

	if headFrameItem then
		return headFrameItem
	end

	if heroItem then
		return heroItem
	end

	if ticketItem then
		return ticketItem
	end

	return BaseObject.GetObject(items[1], nums[1])
end

function TrunkAchieveNode:refreshAchieveNode(...)
	if not self.achieveId then
		return
	end

	local achieveIsGot = CurAvatar.achieveAwardGot[self.achieveId]

	if self.isSimple then
		self.simpleNotGotPanel:setVisible(not achieveIsGot)
		self.simpleGotPanel:setVisible(achieveIsGot)
	else
		self.awardNotGotPanel:setVisible(not achieveIsGot)
		self.awardGotPanel:setVisible(achieveIsGot)
	end
end

function TrunkAchieveNode:_onClickViewAward(...)
	if self.achieveId then
		local viewDlg = UIManager.getUI("achieveAwardDlg", true)

		if viewDlg then
			viewDlg:showPreviewAward(self.achieveId)
		end
	end
end

function TaskAchievePanel:ctor(...)
	self:initUI()
end

function TaskAchievePanel:initUI(...)
	self.trunkBgImg = UIControls.RawImage(self, "ImgMainBattle")
	self.trunkTitleTxt = UIControls.Label(self, "TextMainBattle")
	self.trunkDescTxt = UIControls.Label(self, "TextRule")
	self.trunkProcessSlider = UIControls.Slider(self, "Slider")
	self.getAwardBtn = UIControls.Button(self, "BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetTrunkAward)

	self.completeTxt = UIControls.Label(self, "TextComplete")
	self.itemGridPath = "GridItemPanel"
	self.efxPanels = {}

	for i = 1, 3 do
		local efxPanel = UIControls.Panel(self, "EfxGridItem" .. i)

		self.efxPanels[i] = efxPanel
	end

	self.trunkItemGrids = {}
	self.trunkStageMountPath = "PointPanel"
	self.trunkStageNodes = {}
	self.stageChangingEfx = UIControls.Panel(self, "EfxChapterNextPanel")
	self.runningFrames = UIControls.Panel(self, "Slider/FillArea/Fill/FrameImage1")
	self.noBranchImg = UIControls.Image(self, "ImgNone")
	self.branchCellPath = "TaskList/Content"
	self.branchCellScroll = UIControls.ScrollViewLoopV(self, "TaskList")

	self.branchCellScroll:addEventCellChanged(self.onBranchCellChanged)

	self.branchCellList = {}
end

function TaskAchievePanel:setTaskPanel()
	return
end

function TaskAchievePanel:refreshTeskPanel()
	if self.inStageChangingMode then
		return
	end

	self.trunkAchieveData = CurAvatar:getUpperSystemData(Const.ACHEVE_UPPER_SYSTEM_TRUNKTASK)

	if not self.trunkAchieveData then
		return
	end

	self.branchAchieveData = CurAvatar:getUpperSystemData(Const.ACHEVE_UPPER_SYSTEM_BRANCHTASK)

	if not self.branchAchieveData then
		return
	end

	local nowFoucsAchieve = self.trunkAchieveData.currentFocusAchieve

	if nowFoucsAchieve ~= self.currentFocusAchieve then
		self:_setNewFocusAchieve(nowFoucsAchieve)
	end

	local trunkIsQuality = CurAvatar.achieveQualify[self.currentFocusAchieve]
	local trunkIsGot = CurAvatar.achieveAwardGot[self.currentFocusAchieve]

	self.getAwardBtn:setVisible(trunkIsQuality and not trunkIsGot)

	for i, grid in ipairs(self.trunkItemGrids) do
		if grid.setIconGray ~= nil then
			grid:setIconGray(trunkIsGot)
		end
	end

	self.completeTxt:setVisible(not trunkIsQuality or trunkIsGot)

	if trunkIsGot then
		self.completeTxt:setText(Lang.get(74))
	elseif not trunkIsQuality then
		self.completeTxt:setText(Lang.get(114))
	end

	self:_checkTrunkEnd()

	self.branchAchieveList = self.branchAchieveData:getSortedBranchList()

	local branchAchieveCount = #self.branchAchieveList

	self.noBranchImg:setVisible(branchAchieveCount == 0)
	self.branchCellScroll:setTotalCount(branchAchieveCount)
end

function TaskAchievePanel:_setNewFocusAchieve(focusAchieve)
	self.currentFocusAchieve = focusAchieve

	if not self.currentFocusAchieve then
		return
	end

	local trunkTaskInfo = ResAchieve[self.currentFocusAchieve]

	if not trunkTaskInfo then
		return
	end

	local iconPath = trunkTaskInfo.icon_path
	local icon = trunkTaskInfo.icon

	if iconPath and icon then
		self.trunkBgImg:setImage(iconPath .. "/" .. icon)
	end

	for _, grid in ipairs(self.trunkItemGrids) do
		grid:destroy()
	end

	self.trunkItemGrids = {}

	local awardRandId = trunkTaskInfo.award_randid

	if awardRandId and ResRandClient[awardRandId] then
		for i, itemId in ipairs(ResRandClient[awardRandId].show_ids) do
			local itemNum = ResRandClient[awardRandId].show_nums[i]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)
			local grid = UIControls.getGridChild(fakeItem, self, self.itemGridPath)

			grid:setVisible(true)

			grid.mDisableWays = true

			grid:setObj(fakeItem)

			self.trunkItemGrids[i] = grid
		end
	end

	self.trunkTitleTxt:setText(trunkTaskInfo.name or "")
	self.trunkDescTxt:setText(trunkTaskInfo.action_desc or "")

	self.trunkNeedProgress = trunkTaskInfo.action_param
	self.trunkJumpId = trunkTaskInfo.jump_guide_id

	self:_setStageAchieveList()
end

function TaskAchievePanel:_setStageAchieveList()
	local trunkTaskInfo = ResAchieve[self.currentFocusAchieve]

	if not trunkTaskInfo then
		return
	end

	local curStage = trunkTaskInfo.stage_id

	if not curStage then
		return
	end

	if not self.trunkAchieveData then
		return
	end

	local achieveList = self.trunkAchieveData.stageAchieveList[curStage]

	if not achieveList then
		return
	end

	table.sort(achieveList, function(a, b)
		return a < b
	end)

	local achieveCount = #achieveList

	for i, achieveId in ipairs(achieveList) do
		if not self.trunkStageNodes[i] then
			self.trunkStageNodes[i] = TrunkAchieveNode(self, self.trunkStageMountPath, "System/Task/ChildPointPanel", 0, 0, true)
		end

		local node = self.trunkStageNodes[i]

		node:setAchieveNodeData(achieveId, i, achieveCount)
	end

	if achieveCount < #self.trunkStageNodes then
		for i = #self.trunkStageNodes, achieveCount + 1, -1 do
			self.trunkStageNodes[i]:destroy()

			self.trunkStageNodes[i] = nil
		end
	end

	self:_refreshStageAchieveList(false, true)
end

function TaskAchievePanel:_refreshStageAchieveList(addOne, skipSlide)
	local gotIndex = 0

	for i, node in ipairs(self.trunkStageNodes) do
		node:refreshAchieveNode()

		if CurAvatar.achieveAwardGot[node.achieveId] then
			gotIndex = i
		end
	end

	if addOne then
		gotIndex = gotIndex + 1
	end

	local slidTime = TaskConfig.AWARD_EFX_LENGTH

	if skipSlide then
		slidTime = 0
	end

	self.trunkProcessSlider:setValue(gotIndex / #self.trunkStageNodes, slidTime)
end

function TaskAchievePanel:showChangeStage()
	self.inStageChangingMode = nil

	self.stageChangingEfx:setVisible(true)

	self.getAwardTimer = Timer.New(Slot(self._afterChangingEfx, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function TaskAchievePanel:_afterChangingEfx(...)
	self.getAwardTimer = nil

	self.stageChangingEfx:setVisible(false)
	self:refreshTeskPanel()
	self:_refreshStageAchieveList(false, true)
end

function TaskAchievePanel:_checkTrunkEnd()
	if not self.currentFocusAchieve or not self.trunkAchieveData then
		return false
	end

	local trunkIsEnd = self.trunkAchieveData:achieveIsTrunkEnd(self.currentFocusAchieve) and CurAvatar.achieveAwardGot[self.currentFocusAchieve]

	if trunkIsEnd then
		self.runningFrames:setVisible(false)
	end
end

function TaskAchievePanel:onBranchCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BranchTaskCell(sender, "System/Task/TaskMainListCellPanel", newIdx, 0, 0)
	else
		self.branchCellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local achieveId = self.branchAchieveList[newIdx]

	if achieveId then
		targetCell:setBranchTask(achieveId)
		targetCell:refreshBranchTask()
	end

	self.branchCellList[newIdx] = targetCell
end

function TaskAchievePanel:onClickGetTrunkAward(...)
	if self.getAwardTimer then
		return
	end

	local itemCount = #self.trunkItemGrids

	for i = 1, 3 do
		self.efxPanels[i]:setVisible(i <= itemCount)
	end

	for i, grid in ipairs(self.trunkItemGrids) do
		if grid and grid.object and BaseObject.isAttrs(grid.object.id) then
			grid:flyToCommonFuncEntryPanel()
		end
	end

	self:_refreshStageAchieveList(true, false)

	if self.trunkAchieveData:achieveIsStageEnd(self.currentFocusAchieve) then
		self.inStageChangingMode = true
		CurAvatar.trunkAchieveChangeStage = true
	end

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function TaskAchievePanel:_delayGetAward(...)
	for i = 1, 3 do
		self.efxPanels[i]:setVisible(false)
	end

	self.getAwardTimer = nil

	CurAvatar:getAchieveAward(self.currentFocusAchieve)
end

function TaskAchievePanel:destroy(...)
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	TaskAchievePanel.super.destroy(self)
end

function TaskAchievePanel:onClickGotoTrunk(...)
	if self.trunkJumpId then
		JumpGuideManager.jump(self.trunkJumpId)
	end
end

return TaskAchievePanel
