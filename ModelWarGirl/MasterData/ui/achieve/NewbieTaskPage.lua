-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\NewbieTaskPage.lua

local ResTask = require("ClientData/ResTask")
local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local TaskConfig = require("DesignerScript/TaskConfig")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local strClassName = "NewbieTaskPage"
local NewbieTaskPage = Class(strClassName, UIControls.Child)
local MainTaskCell = Class("MainTaskCell", UIControls.Child)

function MainTaskCell:ctor(...)
	self:initUI()
end

function MainTaskCell:initUI(...)
	self.lockBtn = UIControls.Button(self, "BtnTaskDis")

	self.lockBtn:addEventClick(self.onClickWhenDis)

	self.unlockBtn = UIControls.Button(self, "BtnTask", "TextNum")

	self.unlockBtn:addEventClick(self.onClickSelect)

	self.newImg = UIControls.Image(self, "BtnTask/IconNew")
	self.finishImg = UIControls.Image(self, "BtnTask/IconFinish")
	self.lockAwardImg = UIControls.Image(self, "BtnTaskDis/IconAward")
	self.unlockAwardImg = UIControls.Image(self, "BtnTask/IconAward")
end

function MainTaskCell:setMainTaskTab(taskId)
	self.mainTaskId = taskId

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	local iconPath

	if taskInfo.icon_path and taskInfo.icon then
		iconPath = {
			taskInfo.icon_path,
			taskInfo.icon
		}
	else
		local awardRandId = taskInfo.award_value

		if awardRandId and ResRandClient[awardRandId] then
			local itemId = ResRandClient[awardRandId].show_ids[1]
			local itemNum = ResRandClient[awardRandId].show_nums[1]
			local fakeItem = BaseObject.GetObject(itemId, itemNum)

			iconPath = fakeItem:getIconPath()
		end
	end

	if iconPath and #iconPath == 2 then
		self.lockAwardImg:setImage(iconPath[1], iconPath[2])
		self.lockAwardImg:setImageGray(true)
		self.unlockAwardImg:setImage(iconPath[1], iconPath[2])

		self.needProgress = taskInfo.action_param
	end

	local mainTaskInfo = CurAvatar.mainTaskClientInfo[taskId]

	if not mainTaskInfo then
		return
	end

	self.unlockDesc = mainTaskInfo.unlockDesc or Lang.get(30118)
end

function MainTaskCell:refreshMainTaskCell(...)
	local status = CurAvatar:getTaskStatus(self.mainTaskId)

	self.lockBtn:setVisible(status == Const.TASK_STATUS.NOT_ACTIVE)
	self.unlockBtn:setVisible(status ~= Const.TASK_STATUS.NOT_ACTIVE)
	self.finishImg:setVisible(status == Const.TASK_STATUS.AWARD_GOT)

	local taskComplete = status == Const.TASK_STATUS.COMPLETE

	if taskComplete then
		self.newImg:setVisible(true)
	else
		local hasSubComplete = false
		local subTaskIdList = CurAvatar.parent2ChildrenDict[self.mainTaskId]

		for i, subTaskId in ipairs(subTaskIdList) do
			if CurAvatar:getTaskStatus(subTaskId) == Const.TASK_STATUS.COMPLETE then
				hasSubComplete = true

				break
			end
		end

		self.newImg:setVisible(hasSubComplete)
	end

	local process, needProgress = CurAvatar:getTaskProcess(self.mainTaskId)

	self.unlockBtn:setText(math.floor(process * 100 / needProgress))
end

function MainTaskCell:setEnable(isEnabled)
	self.unlockBtn:setEnable(isEnabled)
end

function MainTaskCell:setSelectFunc(selectFunc)
	self.selectFunc = selectFunc
end

function MainTaskCell:onClickSelect(...)
	if self.selectFunc then
		self.selectFunc()
	end
end

function MainTaskCell:onSelected(isSelect)
	return
end

function MainTaskCell:onClickWhenDis(...)
	if self.unlockDesc then
		MsgManager.notice(self.unlockDesc)
	end
end

local SubTaskCell = Class("SubTaskCell", UIControls.ScrollViewLoopCell)

function SubTaskCell:ctor(...)
	self:initUI()
end

function SubTaskCell:initUI(...)
	self.bgImg = UIControls.Image(self, "")
	self.bgAwardImg = UIControls.Image(self, "BgTaskCell")
	self.itemImg = UIControls.Image(self, "BgTask")
	self.titleTxt = UIControls.Label(self, "RulePanel/TextRuleTitle")
	self.ruleTxt = UIControls.Label(self, "RulePanel/TextRule")
	self.efxPanel = UIControls.Panel(self, "EfxGridItem")
	self.progressSlider = UIControls.Slider(self, "Slider")
	self.sonNumTxt = UIControls.Label(self, "TextNum1")
	self.momNumTxt = UIControls.Label(self, "TextNum2")
	self.getAwardBtn = UIControls.Button(self, "BtnConfirm")

	self.getAwardBtn:addEventClick(self.onClickGetAward)

	self.gotoBtn = UIControls.Button(self, "BtnGo")

	self.gotoBtn:addEventClick(self.onClickGoto)

	self.stateTxt = UIControls.Label(self, "TextState")
	self.itemGridPath = "GridItemPanel"
end

function SubTaskCell:setSubTaskCell(taskId)
	if self.subTaskId and self.subTaskId == taskId then
		return
	end

	self.subTaskId = taskId

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	local iconPath = taskInfo.icon_path
	local path = taskInfo.icon

	if iconPath and path then
		self.itemImg:setImage(iconPath, path)
	end

	if self.itemGrid then
		self.itemGrid:destroy()

		self.itemGrid = nil
	end

	local awardRandId = taskInfo.award_value

	if awardRandId and ResRandClient[awardRandId] then
		local itemId = ResRandClient[awardRandId].show_ids[1]
		local itemNum = ResRandClient[awardRandId].show_nums[1]
		local fakeItem = BaseObject.GetObject(itemId, itemNum)

		self.itemGrid = UIControls.ItemGridChild(self, self.itemGridPath, "System/Common/Grid/GridMaterialItem", 0, 0, true)
		self.itemGrid.mDisableWays = true

		self.itemGrid:setObj(fakeItem)
	end

	if RegionUtils.isLangJP() then
		self.titleTxt:setVisible(false)
	else
		self.titleTxt:setVisible(true)
		self.titleTxt:setText(taskInfo.name or "")
	end

	self.ruleTxt:setText(taskInfo.action_desc or "")

	self.needProgress = taskInfo.action_param
	self.jumpId = taskInfo.jump_guide_id
end

function SubTaskCell:refreshSubTaskCell()
	if not self.subTaskId then
		return
	end

	local progress, needProgress = CurAvatar:getTaskProcess(self.subTaskId)

	self.sonNumTxt:setText(progress)
	self.momNumTxt:setText(needProgress)

	local percent = progress / needProgress

	self.progressSlider:setValue(percent)

	local status = CurAvatar:getTaskStatus(self.subTaskId)
	local isComplete = status == Const.TASK_STATUS.COMPLETE
	local isGot = status == Const.TASK_STATUS.AWARD_GOT

	self.getAwardBtn:setVisible(isComplete)
	self.gotoBtn:setVisible(status == Const.TASK_STATUS.IN_PROCESS and self.jumpId ~= nil)
	self.stateTxt:setVisible(isGot)
	self.itemImg:setImageGray(isGot)
	self.itemGrid:setIconGray(isGot)

	local nextState = "BeginnerTaskListCellNml"

	if isComplete then
		nextState = "BeginnerTaskListCellHigh"
	end

	if isGot then
		nextState = "BeginnerTaskListCellDis"
	end

	self:playStateAnimator(nextState)
end

function SubTaskCell:destroy(...)
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	SubTaskCell.super.destroy(self)
end

function SubTaskCell:onClickGetAward()
	if self.getAwardTimer then
		return
	end

	self.efxPanel:setVisible(true)

	if self.itemGrid and self.itemGrid.object and BaseObject.isAttrs(self.itemGrid.object.id) then
		self.itemGrid:flyToCommonFuncEntryPanel()
	end

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), TaskConfig.AWARD_EFX_LENGTH)

	self.getAwardTimer:Start()
end

function SubTaskCell:_delayGetAward()
	self.efxPanel:setVisible(false)

	self.getAwardTimer = nil

	CurAvatar:getNewbieTaskAward(self.subTaskId)
end

function SubTaskCell:onClickGoto(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	end
end

local TaskInfoPanel = Class("TaskInfoPanel", UIControls.Panel)

function TaskInfoPanel:ctor(parent, path)
	self:initUI()
end

function TaskInfoPanel:initUI(...)
	self.heroInfoPanel = UIControls.Panel(self, self.mPath .. "/AwardHeroPanel")
	self.heroPortrait = UIControls.Role(self, self.mPath .. "/AwardHeroPanel/MaskAward/GridHeroPortraitPanel")
	self.heroStarImg = UIControls.Image(self, self.mPath .. "/AwardHeroPanel/IconStar")
	self.heroRankBtn = UIControls.Button(self, self.mPath .. "/AwardHeroPanel/BtnRanking")

	self.heroRankBtn:addEventClick(self.onClickRank)

	self.heroNameTxt = UIControls.Label(self, self.mPath .. "/AwardHeroPanel/BgName/TextName")
	self.heroTipsBtn = UIControls.Button(self, self.mPath .. "/AwardHeroPanel/BgName/TextName/BtnTips")

	self.heroTipsBtn:addEventClick(self.onClickHeroTips)

	self.itemInfoPanel = UIControls.Panel(self, self.mPath .. "/AwardItemPanel")
	self.itemIcon = UIControls.Image(self, self.mPath .. "/AwardItemPanel/ImgAward")
	self.itemNameTxt = UIControls.Label(self, self.mPath .. "/AwardItemPanel/BgName/TextName")
	self.itemTipsBtn = UIControls.Button(self, self.mPath .. "/AwardItemPanel/BgName/TextName/BtnTips")

	self.itemTipsBtn:addEventClick(self.onClickItemTips)

	self.ruleTxt = UIControls.Label(self, self.mPath .. "/TextRule")
	self.progressSlider = UIControls.Slider(self, self.mPath .. "/Slider")
	self.progressTxt = UIControls.Label(self, self.mPath .. "/TextNum")
	self.completeTxt = UIControls.Label(self, self.mPath .. "/TextComplete")
	self.getAwardBtn = UIControls.Button(self, self.mPath .. "/BtnConfirm", "Text")

	self.getAwardBtn:addEventClick(self.onClickGetAward)
end

function TaskInfoPanel:setTaskInfo(taskId)
	self.currentMainTask = taskId

	local mainTaskInfo = CurAvatar.mainTaskClientInfo[taskId]

	if not mainTaskInfo then
		return
	end

	local bannerIconPath = mainTaskInfo.iconPath
	local bannerIcon = mainTaskInfo.icon
	local heroId = mainTaskInfo.heroId

	if heroId then
		self:_setHeroDisplay(heroId, bannerIconPath, bannerIcon)

		self.heroId = heroId
	else
		local itemId = mainTaskInfo.itemId

		if itemId then
			self:_setItemDisplay(itemId, bannerIconPath, bannerIcon)

			self.itemId = itemId
		end
	end

	local taskInfo = ResTask[taskId]

	if not taskInfo then
		return
	end

	self.ruleTxt:setText(taskInfo.action_desc or "")

	self.needProgress = taskInfo.action_param
end

function TaskInfoPanel:refreshTaskInfo(...)
	if not self.currentMainTask then
		return
	end

	local progress, needProgress = CurAvatar:getTaskProcess(self.currentMainTask)

	if needProgress then
		self.progressTxt:setText(math.floor(progress * 100 / needProgress))

		local percent = progress / needProgress

		self.progressSlider:setValue(percent)
	end

	local status = CurAvatar:getTaskStatus(self.currentMainTask)

	self.completeTxt:setVisible(status == Const.TASK_STATUS.AWARD_GOT)
	self.getAwardBtn:setVisible(status ~= Const.TASK_STATUS.AWARD_GOT)

	if status == Const.TASK_STATUS.IN_PROCESS then
		self.getAwardBtn:setEnable(false)
		self.getAwardBtn:setText(Lang.get(30119))
	elseif status == Const.TASK_STATUS.COMPLETE then
		self.getAwardBtn:setEnable(true)

		if self.currentMainTask == DrawCardConfig.NEWBIE_DRAWCARD_TASKID and not CurAvatar.newbieDrawHasChoosen then
			self.getAwardBtn:setText(Lang.get(30120))

			self.jumpId = Const.NEWBIE_DRAWCARD_JUMPID
		else
			self.jumpId = nil

			self.getAwardBtn:setText(Lang.get(38))
		end
	end
end

function TaskInfoPanel:_setHeroDisplay(heroId, bannerPath, bannerIcon)
	self.heroInfoPanel:setVisible(true)
	self.itemInfoPanel:setVisible(false)
	self.heroPortrait:showRole(heroId)

	local hero = BaseObject.GetObject(heroId)

	if hero then
		self.heroNameTxt:setText(hero.name)

		local starPath = hero:getStarPath()

		if starPath then
			self.heroStarImg:setImage(starPath[1], starPath[2])
		end
	end
end

function TaskInfoPanel:_setItemDisplay(itemId, bannerPath, bannerIcon)
	self.heroInfoPanel:setVisible(false)
	self.itemInfoPanel:setVisible(true)

	local item = BaseObject.GetObject(itemId)

	if item then
		self.itemNameTxt:setText(item.name)
	end

	if bannerPath and bannerIcon then
		self.itemIcon:setImage(bannerPath, bannerIcon)
	end
end

function TaskInfoPanel:onClickGetAward(...)
	if self.jumpId then
		JumpGuideManager.jump(self.jumpId)
	else
		CurAvatar:getNewbieTaskAward(self.currentMainTask)
	end
end

function TaskInfoPanel:onClickRank(...)
	JumpGuideManager.jump(Const.HANDBOOK_JUMP_HERO_ID, "", self.heroId)
end

function TaskInfoPanel:onClickItemTips(...)
	if not self.itemId then
		return
	end

	local fakeItem = BaseObject.GetObject(self.itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

function TaskInfoPanel:onClickHeroTips(...)
	if not self.heroId then
		return
	end

	local fakeItem = BaseObject.GetObject(self.heroId)

	UIManager.getUI("heroTips"):showObj(self, fakeItem)
end

function NewbieTaskPage:ctor(...)
	self:initUI()
end

function NewbieTaskPage:initUI(...)
	self.mainTaskListPath = "TaskChooseList/Content"
	self.mainTaskCells = {}
	self.taskInfoPanel = TaskInfoPanel(self, "BigTaskPanel")
	self.subTaskListPath = "TaskList/Content"
	self.subTaskScroll = UIControls.ScrollViewLoopV(self, "TaskList")

	self.subTaskScroll:addEventCellChanged(self.onSubTaskChanged)

	self.subTaskCells = {}
end

function NewbieTaskPage:onPageOpen()
	self:setNewbieTaskData()
	self:selectFocusTask()
end

function NewbieTaskPage:setNewbieTaskData()
	self.newbieMainTasks = CurAvatar.newbieMainTasks
	self.main2SubDict = CurAvatar.parent2ChildrenDict

	if not self.main2SubDict or not self.newbieMainTasks or #self.newbieMainTasks == 0 then
		return
	end

	for index, mainTaskId in ipairs(self.newbieMainTasks) do
		local mainCell = self.mainTaskCells[index]

		if not mainCell then
			mainCell = MainTaskCell(self, self.mainTaskListPath, "System/Task/BeginnerTaskChooseCell", 0, 0, true)
			mainCell.index = index

			mainCell:setSelectFunc(Functor(self._selectMainTask, self, index))

			self.mainTaskCells[index] = mainCell
		end

		mainCell:setMainTaskTab(mainTaskId)
	end
end

function NewbieTaskPage:refreshNewbieTask(...)
	for i, mainCell in ipairs(self.mainTaskCells) do
		mainCell:refreshMainTaskCell()
	end

	self.subTaskIdList = CurAvatar:getSortedNewbieTask(self.currentMainTask)

	self.subTaskScroll:setTotalCount(#self.subTaskIdList)
	self.taskInfoPanel:refreshTaskInfo()
end

function NewbieTaskPage:_selectMainTask(selectIndex)
	self.selectIndex = selectIndex

	for index, mainCell in ipairs(self.mainTaskCells) do
		local cellSelected = index == selectIndex

		mainCell:setEnable(not cellSelected)
		mainCell:onSelected(cellSelected)

		if cellSelected then
			self.currentMainTask = mainCell.mainTaskId
		end
	end

	self.taskInfoPanel:setVisible(true)
	self.taskInfoPanel:setTaskInfo(self.currentMainTask)
	self:refreshNewbieTask()
end

function NewbieTaskPage:_selectMainTaskById(taskId)
	local exist = false

	for index, mainCell in ipairs(self.mainTaskCells) do
		local cellSelected = mainCell.mainTaskId == taskId

		mainCell:setEnable(not cellSelected)
		mainCell:onSelected(cellSelected)

		if cellSelected then
			self.selectIndex = index
			self.currentMainTask = taskId
			exist = true
		end
	end

	if not exist then
		return
	end

	self.taskInfoPanel:setVisible(true)
	self.taskInfoPanel:setTaskInfo(self.currentMainTask)
	self:refreshNewbieTask()
end

function NewbieTaskPage:selectFocusTask()
	local focusTask = CurAvatar:getFocusNewbieTask()

	if focusTask then
		self:_selectMainTaskById(focusTask)
	end
end

function NewbieTaskPage:onSubTaskChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SubTaskCell(sender, "System/Task/BeginnerTaskListCell", newIdx, 0, 0)
	else
		self.subTaskCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local taskId = self.subTaskIdList[newIdx]

	if taskId then
		targetCell:setSubTaskCell(taskId)
		targetCell:refreshSubTaskCell()
	end

	self.subTaskCells[newIdx] = targetCell
end

return NewbieTaskPage
