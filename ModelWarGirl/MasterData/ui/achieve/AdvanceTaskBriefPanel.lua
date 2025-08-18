-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AdvanceTaskBriefPanel.lua

local ResTask = require("ClientData/ResTask")
local ResAdvanceTaskClient = require("ClientData/ResAdvanceTaskClient")
local EventConst = require("EventConst")
local AdvanceTaskBriefPanel = Class("AdvanceTaskBriefPanel", UIControls.Panel)

function AdvanceTaskBriefPanel:ctor(...)
	self:initUI()
end

function AdvanceTaskBriefPanel:initUI(...)
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self.onClickRootBtn)

	self.bgImg = UIControls.Image(self, self.mPath)
	self.gridLockImg = UIControls.Image(self, self.mPath .. "/GridPanel/ImgLock")
	self.gridIcon = UIControls.Image(self, self.mPath .. "/GridPanel/Icon")
	self.conditionId = Const.CONDITION_LIMIT_NEWBIE_TASK
	self.slotOfConditionChanged = Slot(self._checkVisible, self)
	self.slotOfRefresh = Slot(self.refresAdvanceTaskInfo, self)

	if not self.registered then
		EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
		EventCenter.addEventListener(EventConst.NEWBIE_TASK_UPDATE, self.slotOfRefresh)

		self.registered = true
	end

	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")

	self.redDot:addHint({
		UIConst.RD_HINT_ADVANCE_TASK
	})
end

function AdvanceTaskBriefPanel:destroy(...)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfConditionChanged)
	EventCenter.removeEventListener(EventConst.NEWBIE_TASK_UPDATE, self.slotOfRefresh)

	self.registered = false
end

function AdvanceTaskBriefPanel:refresAdvanceTaskInfo(...)
	if not self:_checkVisible(self.conditionId) then
		return
	end

	local isGroup, targetId = CurAvatar:getFocusAdvanceGroup()

	if not self.focusId or self.focusId ~= targetId or self.focusIsGroup ~= isGroup then
		self:setFocusInfo(isGroup, targetId)
	end

	self:refreshFocusInfo()
end

function AdvanceTaskBriefPanel:_checkVisible(limitId)
	if not limitId or limitId ~= self.conditionId then
		return
	end

	local visible = false
	local isLocked = ConditionLimitManager.inLimitState(limitId)

	if not isLocked then
		local newbieAllFinished = CurAvatar:allNewbieTaskFinished()
		local advanceAllFinished = CurAvatar:allAdvanceTaskFinished()

		visible = newbieAllFinished and not advanceAllFinished
	end

	self:setVisible(visible)

	return visible
end

function AdvanceTaskBriefPanel:setFocusInfo(isGroup, targetId)
	self.focusId = targetId
	self.focusIsGroup = isGroup

	local iconPath, unlockDesc

	if isGroup then
		if not ResAdvanceTaskClient[targetId] or not ResAdvanceTaskClient[targetId][1] then
			return
		end

		local groupClientInfo = ResAdvanceTaskClient[targetId][1]

		iconPath = {
			groupClientInfo.tab_path,
			groupClientInfo.tab_icon
		}
		unlockDesc = groupClientInfo.unlock_desc or Lang.get(30118)
	else
		local taskInfo = ResTask[targetId]

		if not taskInfo then
			return
		end

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

		local mainTaskInfo = CurAvatar.advanceSpecTask[targetId]

		if not mainTaskInfo then
			return
		end

		unlockDesc = mainTaskInfo.unlockDesc or Lang.get(30118)
	end

	if iconPath and #iconPath == 2 then
		self.gridIcon:setImage(iconPath[1], iconPath[2])
	end

	self.unlockDesc = unlockDesc
end

function AdvanceTaskBriefPanel:refreshFocusInfo()
	if not self.focusId then
		return
	end

	local inProcess, isComplete

	if self.focusIsGroup then
		self.isLocked = not CurAvatar:advanceGroupUnlock(self.focusId)
		isComplete = CurAvatar:advanceGroupFinished(self.focusId)
		inProcess = not isComplete
	else
		local status = CurAvatar:getTaskStatus(self.focusId)

		self.isLocked = status == Const.TASK_STATUS.NOT_ACTIVE
		isComplete = status == Const.TASK_STATUS.COMPLETE
		inProcess = status == Const.TASK_STATUS.IN_PROCESS
	end

	if self.isLocked then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack")
	elseif inProcess then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack")
	elseif isComplete then
		self.bgImg:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgPromoteBack1")
	end

	self.gridLockImg:setVisible(self.isLocked)
	self.gridIcon:setImageGray(self.isLocked)
end

function AdvanceTaskBriefPanel:onClickRootBtn(...)
	if self.isLocked then
		if self.unlockDesc then
			MsgManager.notice(self.unlockDesc)
		end
	else
		UIManager.getUI("advanceTaskDlg", true)
	end
end

return AdvanceTaskBriefPanel
