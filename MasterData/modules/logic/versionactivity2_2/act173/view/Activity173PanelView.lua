-- chunkname: @modules/logic/versionactivity2_2/act173/view/Activity173PanelView.lua

module("modules.logic.versionactivity2_2.act173.view.Activity173PanelView", package.seeall)

local Activity173PanelView = class("Activity173PanelView", BaseView)
local GLOBAL_TASK_ID = 3900001
local TickRefreshRemainTime = 1
local FIRST_ENTER_ANIM = "first"
local NORMAL_ENTER_ANIM = "open"
local STAGESWITCHTOFINISH_ANIM = "get"
local NORMALSTAGE_ANIM = "idle"
local DELAY_PLAY_FIRST_ENTER_ANDIO = 0.18

function Activity173PanelView:onInitView()
	self._goClose = gohelper.findChild(self.viewGO, "#go_Close")
	self._goOpen = gohelper.findChild(self.viewGO, "#go_Open")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Open/Left/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Open/Left/#txt_Descr")
	self._imageFG = gohelper.findChildImage(self.viewGO, "#go_Open/Right/Schedule/Slide/image_FG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity173PanelView:addEvents()
	return
end

function Activity173PanelView:removeEvents()
	return
end

function Activity173PanelView:_btnrewardIconOnClick()
	return
end

function Activity173PanelView:_editableInitView()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.onUpdateTaskList, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._stageStateCache = {}
end

function Activity173PanelView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId
	self._config = ActivityConfig.instance:getActivityCo(self._actId)
	self._txtDescr.text = self._config.actDesc

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, self.onUpdateTaskList, self)
	self:initAct()

	local isFirstEnter = self:isFirstEnter()

	if isFirstEnter then
		TaskDispatcher.cancelTask(self.playFirstEnterAudio, self)
		TaskDispatcher.runDelay(self.playFirstEnterAudio, self, DELAY_PLAY_FIRST_ENTER_ANDIO)
		self:markHasEnter()
	end

	if isFirstEnter then
		if not FIRST_ENTER_ANIM then
			local animName = NORMAL_ENTER_ANIM

			self._animator:Play(animName, 0, 0)
		end
	end
end

function Activity173PanelView:playFirstEnterAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_fistenter_act173)
end

function Activity173PanelView:initAct()
	self:refreshActRemainTime()
	TaskDispatcher.cancelTask(self.refreshActRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshActRemainTime, self, TickRefreshRemainTime)
	self:initTasks()
	self:initOrRefreshGlobalTaskProgress()
end

function Activity173PanelView:onUpdateTaskList()
	self:initOrRefreshGlobalTaskProgress(true)
	self:refreshAllTask()
end

function Activity173PanelView:initTasks()
	local onlineTaskCos = Activity173Config.instance:getAllOnlineTasks()

	for i = 1, #onlineTaskCos do
		local taskCo = onlineTaskCos[i]
		local taskItem = self:getOrCreateTaskItem(i)

		taskItem:init(taskCo)
	end
end

function Activity173PanelView:getOrCreateTaskItem(index)
	self._taskItems = self._taskItems or {}

	local taskItem = self._taskItems[index]

	if not taskItem then
		local taskGo = gohelper.findChild(self.viewGO, "#go_Open/Right/Reward" .. index)

		taskItem = Activity173TaskItem.New(taskGo)
		self._taskItems[index] = taskItem
	end

	return taskItem
end

function Activity173PanelView:refreshActRemainTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function Activity173PanelView:refreshAllTask()
	for _, v in ipairs(self._taskItems) do
		v:refresh()
	end
end

function Activity173PanelView:initOrRefreshGlobalTaskProgress(playSwitchAnim)
	local globalTaskMo = TaskModel.instance:getTaskById(GLOBAL_TASK_ID)

	if globalTaskMo then
		if not globalTaskMo.progress then
			local progress = 0
			local visibleStages = Activity173Config.instance:getGlobalVisibleTaskStages()

			if visibleStages then
				if not #visibleStages then
					local visibleStageCount = 0
					local fillAmount = 0
					local perStageFillAmount = 1 / (visibleStageCount - 1)
					local preStageCo

					for i = 1, visibleStageCount do
						local curStageCo = visibleStages[i]
						local curStageEndVal = curStageCo.endValue
						local isFinished = curStageEndVal <= progress
						local globalStageItem = self:getOrCreateGlobalTaskStageItem(i)

						globalStageItem.txtNum.text = Activity173Controller.numberDisplay(curStageEndVal)

						gohelper.setActive(globalStageItem.goPointFG, isFinished)
						gohelper.setActive(globalStageItem.goGet, isFinished)
						ZProj.UGUIHelper.SetGrayscale(globalStageItem.imageRewardBG.gameObject, not isFinished)

						preStageCo = visibleStages[i - 1] or curStageCo

						if preStageCo then
							if not preStageCo.endValue then
								local preStageEndVal = 0
								local curStageVal = progress - preStageEndVal
								local curStageRangeVal = curStageEndVal - preStageEndVal
								local curStageProgress = curStageRangeVal ~= 0 and GameUtil.clamp(curStageVal / curStageRangeVal, 0, 1) or 0

								fillAmount = fillAmount + curStageProgress * perStageFillAmount

								if globalTaskMo then
									local isSwitch2FinishState = isFinished and self._stageStateCache[curStageCo.id] == false

									if playSwitchAnim and isSwitch2FinishState then
										if isSwitch2FinishState then
											if not STAGESWITCHTOFINISH_ANIM then
												local animName = NORMALSTAGE_ANIM

												globalStageItem.animGet:Play(animName, 0, 0)
											end
										end
									end

									self._stageStateCache[curStageCo.id] = isFinished
								end
							end
						end
					end

					self._imageFG.fillAmount = fillAmount
				end
			end
		end
	end
end

function Activity173PanelView:getOrCreateGlobalTaskStageItem(index)
	self._globalTaskStageItems = self._globalTaskStageItems or self:getUserDataTb_()

	local stageItem = self._globalTaskStageItems[index]

	if not stageItem then
		stageItem = self:getUserDataTb_()

		local viewGOUrl = "#go_Open/Right/Schedule/HorizonLayout/Point" .. index

		stageItem.viewGO = gohelper.findChild(self.viewGO, viewGOUrl)

		if gohelper.isNil(stageItem.viewGO) then
			logError("缺少全服奖励阶段ui url = " .. viewGOUrl)

			return
		end

		stageItem.imageRewardBG = gohelper.findChildImage(stageItem.viewGO, "image_RewardBG")
		stageItem.txtNum = gohelper.findChildText(stageItem.viewGO, "image_RewardBG/txt_Num")
		stageItem.goGet = gohelper.findChild(stageItem.viewGO, "#go_Get")
		stageItem.goPointFG = gohelper.findChild(stageItem.viewGO, "#go_PointFG")
		stageItem.animGet = gohelper.onceAddComponent(stageItem.goGet, gohelper.Type_Animator)
		self._globalTaskStageItems[index] = stageItem
	end

	return stageItem
end

function Activity173PanelView:isFirstEnter()
	local key = self:getPrefsKey()
	local data = PlayerPrefsHelper.getString(key, "")

	return string.nilorempty(data)
end

function Activity173PanelView:markHasEnter()
	local key = self:getPrefsKey()

	PlayerPrefsHelper.setString(key, "hasEnter")
end

function Activity173PanelView:getPrefsKey()
	return PlayerPrefsKey.FirstEnterActivity173PanelView .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function Activity173PanelView:onClose()
	TaskDispatcher.cancelTask(self.refreshActRemainTime, self)
	TaskDispatcher.cancelTask(self.switch2NormalView, self)
	TaskDispatcher.cancelTask(self.playFirstEnterAudio, self)
end

function Activity173PanelView:onDestroyView()
	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			v:destroy()
		end

		self._taskItems = nil
	end
end

return Activity173PanelView
