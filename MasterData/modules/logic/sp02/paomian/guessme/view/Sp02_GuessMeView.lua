-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeView.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeView", package.seeall)

local Sp02_GuessMeView = class("Sp02_GuessMeView", BaseView)

function Sp02_GuessMeView:onInitView()
	self._goUnknowHero = gohelper.findChild(self.viewGO, "root/left/#go_UnknowHero")
	self._goKnowHero = gohelper.findChild(self.viewGO, "root/left/#go_KnowHero")
	self._simageRolePic = gohelper.findChildSingleImage(self.viewGO, "root/left/#go_KnowHero/#simage_rolePic")
	self._txtName = gohelper.findChildText(self.viewGO, "root/left/#go_KnowHero/Image_txt/#txt_Name")
	self._simageRolePicMask = gohelper.findChildSingleImage(self.viewGO, "root/left/#go_UnknowHero/#simage_rolePicMask")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList")
	self._goTaskContent = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_TaskItem")
	self._goTextArea = gohelper.findChild(self.viewGO, "#go_Root/#go_TextArea")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "root/right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "root/right/TaskPanel/#scroll_TaskDesc/Viewport/Content/#txt_TaskContent")
	self._goRewardArea = gohelper.findChild(self.viewGO, "#go_Root/#go_RewardArea")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_RewardArea/#scroll_Reward")
	self._goRewardContent = gohelper.findChild(self.viewGO, "root/right/RawardPanel/#scroll_Reward/Viewport/Content")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/right/RawardPanel/#scroll_Reward/Viewport/Content/#go_RewardItem")
	self._goAnswerArea = gohelper.findChild(self.viewGO, "#go_Root/#go_AnswerArea")
	self._scrollOption = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_AnswerArea/#scroll_Option")
	self._goOptionContent = gohelper.findChild(self.viewGO, "root/right/#go_OptionContent")
	self._goOptionItem = gohelper.findChild(self.viewGO, "root/right/#go_OptionContent/#go_OptionItem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._btnGetReward = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/RawardPanel/#btn_getreward")
	self._goLeft = gohelper.findChild(self.viewGO, "root/left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_GuessMeView:addEvents()
	self._btnGetReward:AddClickListener(self._btnGetRewardOnClick, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnUpdateGuessMe, self._onUpdateGuessMe, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnSelectGuessMeDay, self._onSelectGuessDay, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnSelectGuessMeOption, self._onSelectGuessMeOption, self)
end

function Sp02_GuessMeView:removeEvents()
	self._btnGetReward:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()
end

function Sp02_GuessMeView:_btnGetRewardOnClick()
	if self._status ~= Sp02_GuessMeEnum.TaskStatus.CanGet then
		return
	end

	Activity238Rpc.instance:sendAct238BonusRequest(self._activityId, self._selectTaskId)
end

function Sp02_GuessMeView:_editableInitView()
	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._animEventWrap = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEventWrap:AddEventListener("switch_content", self._startSwitchGuessMeDay, self)

	self._leftAnimator = gohelper.onceAddComponent(self._goLeft, gohelper.Type_Animator)
	self._goTaskTabList = self._scrollTaskTabList.gameObject
	self._tranTaskContent = self._goTaskContent.transform
end

function Sp02_GuessMeView:onOpen()
	self._activityId = self.viewParam and self.viewParam.activityId
	self._activityCo = ActivityConfig.instance:getActivityCo(self._activityId)
	self._taskConfigList = Sp02_GuessMeConfig.instance:getConfigList(self._activityId)

	self:initSelectIndex()
	self:refreshUI()
	self:tickRefreshRemainTime()
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.EnterGuessMeView)
end

function Sp02_GuessMeView:initSelectIndex()
	local selectIndex = 1

	for i, config in ipairs(self._taskConfigList) do
		local status = Sp02_GuessMeModel.instance:getStatus(config.activityId, config.id)

		if status == Sp02_GuessMeEnum.TaskStatus.Lock then
			break
		end

		selectIndex = i

		if status == Sp02_GuessMeEnum.TaskStatus.CanGet or status == Sp02_GuessMeEnum.TaskStatus.UnLock then
			break
		end
	end

	self:initSelectInfo(selectIndex)
end

function Sp02_GuessMeView:initSelectInfo(index)
	self._selectIndex = index
	self._preSelectTaskId = self._selectTaskId
	self._selectTaskCo = self._taskConfigList and self._taskConfigList[self._selectIndex]
	self._selectTaskId = self._selectTaskCo and self._selectTaskCo.id
	self._correctOption = self._selectTaskCo and self._selectTaskCo.correctOption
	self._optionList = self:_initOptionList(self._selectTaskCo)
	self._rewardList = Sp02_GuessMeConfig.instance:getRewardIdList(self._selectTaskCo.activityId, self._selectTaskCo.id)
	self._signMo = Sp02_GuessMeModel.instance:getSignInfo(self._selectTaskCo.activityId, self._selectTaskCo.id)
	self._status = Sp02_GuessMeModel.instance:getStatus(self._activityId, self._selectTaskId)
	self._selectFailCount = 0
end

function Sp02_GuessMeView:_initOptionList(dayCo)
	local optionList = {}

	for i = 1, 3 do
		local optionInfo = dayCo["option" .. i]

		if not string.nilorempty(optionInfo) then
			table.insert(optionList, optionInfo)
		end
	end

	return optionList
end

function Sp02_GuessMeView:refreshUI()
	self._preStatus = self._status
	self._status = Sp02_GuessMeModel.instance:getStatus(self._activityId, self._selectTaskId)

	if self._selectTaskCo then
		self._txtTaskContent.text = self._selectTaskCo.desc or ""
	end

	gohelper.setActive(self._btnGetReward.gameObject, self._status == Sp02_GuessMeEnum.TaskStatus.CanGet)
	gohelper.setActive(self._goUnknowHero, self._status <= Sp02_GuessMeEnum.TaskStatus.UnLock)
	gohelper.setActive(self._goKnowHero, self._status > Sp02_GuessMeEnum.TaskStatus.UnLock)

	if self._status > Sp02_GuessMeEnum.TaskStatus.UnLock then
		self._txtName.text = self._selectTaskCo and self._selectTaskCo.answer

		self._simageRolePic:LoadImage(ResUrl.getS02PaoMianSingleBg("guesshero/" .. self._selectTaskCo.questionPictuer))
	else
		self._simageRolePicMask:LoadImage(ResUrl.getS02PaoMianSingleBg("guesshero/" .. self._selectTaskCo.questionMask))
	end

	self:playLeftContentAnim()
	gohelper.CreateObjList(self, self._refreshTaskItem, self._taskConfigList, self._goTaskContent, self._goTaskItem, Sp02_GuessMeTaskItem)
	gohelper.CreateObjList(self, self._refreshOptionItem, self._optionList, self._goOptionContent, self._goOptionItem, Sp02_GuessMeOptionItem)
	gohelper.CreateObjList(self, self._refreshRewardItem, self._rewardList, self._goRewardContent, self._goRewardItem, Sp02_GuessMeRewardItem)
	TaskDispatcher.cancelTask(self._focusSelectTask, self)
	TaskDispatcher.runDelay(self._focusSelectTask, self, 0.01)
end

function Sp02_GuessMeView:_focusSelectTask()
	if self._selectTaskItem then
		local focusTaskGo = self._selectTaskItem.go
		local offset = gohelper.fitScrollItemOffset(self._goTaskTabList, self._goTaskContent, focusTaskGo, ScrollEnum.ScrollDirH)

		if math.abs(offset) <= 0.01 then
			return
		end

		local curPosX = recthelper.getAnchorX(self._tranTaskContent)

		recthelper.setAnchorX(self._tranTaskContent, curPosX + offset)
	end
end

function Sp02_GuessMeView:playLeftContentAnim()
	if self._preStatus then
		local isPreCanGet = self._preStatus >= Sp02_GuessMeEnum.TaskStatus.CanGet

		if self._status then
			local isCurCanGet = self._status >= Sp02_GuessMeEnum.TaskStatus.CanGet

			self._leftAnimator:Play("idle", 0, 0)

			if isPreCanGet == isCurCanGet then
				return
			end

			if isCurCanGet and not isPreCanGet then
				self._leftAnimator:Play("unlock", 0, 0)
			end
		end
	end
end

function Sp02_GuessMeView:tickRefreshRemainTime()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 30)
end

function Sp02_GuessMeView:refreshRemainTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._activityId)
end

function Sp02_GuessMeView:_refreshTaskItem(taskItem, taskCo, index)
	local isSelect = index == self._selectIndex

	taskItem:onUpdateMO(index, taskCo, isSelect)

	if isSelect then
		self._selectTaskItem = taskItem
	end
end

function Sp02_GuessMeView:_refreshOptionItem(optionItem, optionInfo, index)
	optionItem:onUpdateMO(index, optionInfo, self._selectTaskCo, self._signMo)
end

function Sp02_GuessMeView:_refreshRewardItem(rewardItem, rewardCo, index)
	rewardItem:onUpdateMO(index, rewardCo, self._selectTaskCo, self._signMo)
end

function Sp02_GuessMeView:_onUpdateGuessMe()
	self:refreshUI()
end

function Sp02_GuessMeView:_onSelectGuessDay(index)
	if index == self._selectIndex then
		return
	end

	self._readySelectIndex = index

	self._viewAnimator:Play("switch", 0, 0)
end

function Sp02_GuessMeView:_startSwitchGuessMeDay()
	if not self._readySelectIndex then
		return
	end

	self:initSelectInfo(self._readySelectIndex)
	self:refreshUI()
end

function Sp02_GuessMeView:_onSelectGuessMeOption(index)
	if not index or self._status >= Sp02_GuessMeEnum.TaskStatus.CanGet then
		return
	end

	if index ~= self._correctOption then
		self._selectFailCount = self._selectFailCount + 1
	else
		StatController.instance:track(StatEnum.EventName.Sp02GuessMe, {
			[StatEnum.EventProperties.FaultTime] = self._selectFailCount,
			[StatEnum.EventProperties.ActivityDays] = self._selectIndex
		})
	end
end

function Sp02_GuessMeView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._focusSelectTask, self)
end

function Sp02_GuessMeView:onDestroyView()
	self._simageRolePic:UnLoadImage()
	self._simageRolePicMask:UnLoadImage()
end

return Sp02_GuessMeView
