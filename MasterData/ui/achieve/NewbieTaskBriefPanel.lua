-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\NewbieTaskBriefPanel.lua

local ResTask = require("ClientData/ResTask")
local ResAchieve = require("ClientData/ResAchieve")
local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local EventConst = require("EventConst")
local NewbieTaskBriefPanel = Class("NewbieTaskBriefPanel", UIControls.Panel)

function NewbieTaskBriefPanel:ctor(...)
	self:initUI()
end

function NewbieTaskBriefPanel:initUI(...)
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self.onClickRootBtn)

	self.bgImg = UIControls.Image(self, self.mPath)
	self.gridLockImg = UIControls.Image(self, self.mPath .. "/GridPanel/ImgLock")
	self.gridIcon = UIControls.Image(self, self.mPath .. "/GridPanel/Icon")
	self.taskDesc = UIControls.Label(self, self.mPath .. "/Text")
	self.getTxt = UIControls.Label(self, self.mPath .. "/TextGet")
	self.progressSlider = UIControls.Slider(self, self.mPath .. "/Slider")
	self.conditionId = Const.CONDITION_LIMIT_NEWBIE_TASK
	self.slotOfConditionChanged = Slot(self._checkVisible, self)
	self.slotOfRefresh = Slot(self.refreshNewbieTaskInfo, self)

	if not self.registered then
		EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
		EventCenter.addEventListener(EventConst.NEWBIE_TASK_UPDATE, self.slotOfRefresh)

		self.registered = true
	end

	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")

	self.redDot:addHint({
		UIConst.RD_HINT_ALL_NEWBIE_TASK
	})

	self.awardEfx = UIControls.LazyEffectPlayer(self, self.mPath .. "/EfxGet")
end

function NewbieTaskBriefPanel:destroy(...)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
	EventCenter.removeEventListener(EventConst.NEWBIE_TASK_UPDATE, self.slotOfRefresh)

	self.registered = false
end

function NewbieTaskBriefPanel:refreshNewbieTaskInfo()
	if not self:_checkVisible(self.conditionId) then
		return
	end

	if not CurAvatar:allNewbieTaskFinished() then
		local nowFocusTaskId = CurAvatar:getFocusNewbieTask()

		if not self.focusTaskId or nowFocusTaskId ~= self.focusTaskId then
			self:setFocusTaskId(nowFocusTaskId)
		end

		self:refreshFocusTaskId()
	else
		self:setFocusLoginAchieve()
		self:refreshFocusLoginAchieve()
	end
end

function NewbieTaskBriefPanel:_checkVisible(limitId)
	if not limitId or limitId ~= self.conditionId then
		return
	end

	local visible = false
	local isLocked = ConditionLimitManager.inLimitState(limitId)

	if not isLocked then
		local newbieAllFinished = CurAvatar:allNewbieTaskFinished()
		local loginAllGot = CurAvatar:allAchieveGot(Const.ACHEVE_UPPER_SYSTEM_LOGINTASK)

		visible = not newbieAllFinished or not loginAllGot
	end

	self:setVisible(visible)

	return visible
end

function NewbieTaskBriefPanel:setFocusTaskId(taskId)
	self.focusTaskId = taskId

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
		self.gridIcon:setImage(iconPath[1], iconPath[2])
	end

	self.needProgress = taskInfo.action_param

	local mainTaskInfo = CurAvatar.mainTaskClientInfo[taskId]

	if not mainTaskInfo then
		return
	end

	self.unlockDesc = mainTaskInfo.unlockDesc or Lang.get(30118)
end

function NewbieTaskBriefPanel:refreshFocusTaskId()
	if not self.focusTaskId then
		return
	end

	local subTaskList = CurAvatar.parent2ChildrenDict[self.focusTaskId]
	local focusSubTask

	for i, subTask in ipairs(subTaskList) do
		if CurAvatar:getTaskStatus(subTask) == Const.TASK_STATUS.IN_PROCESS then
			focusSubTask = subTask

			break
		end
	end

	if focusSubTask and ResTask[focusSubTask] then
		self.briefDesc = ResTask[focusSubTask].brief_desc or ResTask[focusSubTask].action_desc or ""

		self.taskDesc:setText(self.briefDesc)

		self.fakeComplete = nil
	else
		self.fakeComplete = true
	end

	local progress, needProgress = CurAvatar:getTaskProcess(self.focusTaskId)
	local percent = progress / needProgress

	self.progressSlider:setValue(percent)

	local status = CurAvatar:getTaskStatus(self.focusTaskId)

	self.isLocked = status == Const.TASK_STATUS.NOT_ACTIVE

	local isComplete = status == Const.TASK_STATUS.COMPLETE or self.fakeComplete
	local inProcess = status == Const.TASK_STATUS.IN_PROCESS and not self.fakeComplete

	if self.isLocked then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack")
		self.getTxt:setVisible(false)
		self.taskDesc:setVisible(true)
		self.taskDesc:setFontColor(ResColor.GREYMIDDLE)
		self.taskDesc:setText(self.unlockDesc)
	elseif inProcess then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack")
		self.getTxt:setVisible(false)
		self.taskDesc:setVisible(true)
		self.taskDesc:setFontColor(ResColor.WHITE)
		self.taskDesc:setText(self.briefDesc)
	elseif isComplete then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack1")
		self.getTxt:setVisible(true)
		self.taskDesc:setVisible(false)
	end

	self.gridLockImg:setVisible(self.isLocked)
	self.gridIcon:setImageGray(self.isLocked)
	self.awardEfx:setVisible(isComplete)
end

function NewbieTaskBriefPanel:setFocusLoginAchieve()
	local loginAchieveList = CurAvatar:getAchieveList(Const.ACHEVE_UPPER_SYSTEM_LOGINTASK)
	local focusAchieveId

	for i, achieveId in ipairs(loginAchieveList) do
		local isGot = CurAvatar.achieveAwardGot[achieveId]

		if not isGot then
			focusAchieveId = achieveId

			break
		end
	end

	if focusAchieveId and (not self.focusLoginAchieve or focusAchieveId ~= self.focusLoginAchieve) then
		self.focusLoginAchieve = focusAchieveId

		local achieveInfo = ResAchieve[focusAchieveId]

		if not achieveInfo then
			return
		end

		local iconPath

		if achieveInfo.icon_path and achieveInfo.icon then
			iconPath = {
				achieveInfo.icon_path,
				achieveInfo.icon
			}
		else
			local awardRandId = achieveInfo.award_randid

			if awardRandId and ResRandClient[awardRandId] then
				local itemId = ResRandClient[awardRandId].show_ids[1]
				local itemNum = ResRandClient[awardRandId].show_nums[1]
				local fakeItem = BaseObject.GetObject(itemId, itemNum)

				iconPath = fakeItem:getIconPath()
			end
		end

		if iconPath and #iconPath == 2 then
			self.gridIcon:setImage(iconPath[1], iconPath[2])
		end
	end
end

function NewbieTaskBriefPanel:refreshFocusLoginAchieve(...)
	if not self.focusLoginAchieve then
		return
	end

	local param = ResAchieve[self.focusLoginAchieve].action_param

	self.taskDesc:setText(string.format(Lang.get(30117), param))

	local progress, needProgress = CurAvatar:getAchieveProcess(self.focusLoginAchieve)
	local percent = progress / needProgress

	self.progressSlider:setValue(percent)

	local isQuality = CurAvatar.achieveQualify[self.focusLoginAchieve]

	if not isQuality then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack")
		self.getTxt:setVisible(false)
		self.taskDesc:setVisible(true)
		self.taskDesc:setFontColor(ResColor.WHITE)
	else
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack1")
		self.getTxt:setVisible(true)
		self.taskDesc:setVisible(false)
	end

	self.gridLockImg:setVisible(false)
	self.gridIcon:setImageGray(false)
	self.awardEfx:setVisible(isQuality)
end

function NewbieTaskBriefPanel:onClickRootBtn(...)
	if self.isLocked then
		if self.unlockDesc then
			MsgManager.notice(self.unlockDesc)
		end
	else
		UIManager.getUI("newbieTaskDlg", true)
	end
end

return NewbieTaskBriefPanel
