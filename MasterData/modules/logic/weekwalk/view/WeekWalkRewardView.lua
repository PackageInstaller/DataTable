-- chunkname: @modules/logic/weekwalk/view/WeekWalkRewardView.lua

module("modules.logic.weekwalk.view.WeekWalkRewardView", package.seeall)

local WeekWalkRewardView = class("WeekWalkRewardView", BaseView)

function WeekWalkRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goweek = gohelper.findChild(self.viewGO, "left/#go_week")
	self._goweekunchoose = gohelper.findChild(self.viewGO, "left/#go_week/#go_weekunchoose")
	self._goweekchoose = gohelper.findChild(self.viewGO, "left/#go_week/#go_weekchoose")
	self._goweekreddot = gohelper.findChild(self.viewGO, "left/#go_week/#go_weekreddot")
	self._btnweek = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_week/#btn_week")
	self._godream = gohelper.findChild(self.viewGO, "left/#go_dream")
	self._godreamunchoose = gohelper.findChild(self.viewGO, "left/#go_dream/#go_dreamunchoose")
	self._godreamchoose = gohelper.findChild(self.viewGO, "left/#go_dream/#go_dreamchoose")
	self._godreamreddot = gohelper.findChild(self.viewGO, "left/#go_dream/#go_dreamreddot")
	self._btndream = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_dream/#btn_dream")
	self._gochallenge = gohelper.findChild(self.viewGO, "left/#go_challenge")
	self._gochallengeunchoose = gohelper.findChild(self.viewGO, "left/#go_challenge/#go_challengeunchoose")
	self._gochallengechoose = gohelper.findChild(self.viewGO, "left/#go_challenge/#go_challengechoose")
	self._gochallengereddot = gohelper.findChild(self.viewGO, "left/#go_challenge/#go_challengereddot")
	self._btnchallenge = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_challenge/#btn_challenge")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	self._gofinishall = gohelper.findChild(self.viewGO, "bottom/#go_finishall")
	self._btnfinishall = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_finishall/#btn_finishall")
	self._gocountdown = gohelper.findChild(self.viewGO, "title/#go_countdown")
	self._txtcountdowntitle = gohelper.findChildText(self.viewGO, "title/#go_countdown/#txt_countdowntitle")
	self._txtcountday = gohelper.findChildText(self.viewGO, "title/#go_countdown/#txt_countdowntitle/#txt_countday")
	self._txtlayer = gohelper.findChildText(self.viewGO, "#txt_layer")
	self._gotiptxt = gohelper.findChild(self.viewGO, "#go_tiptxt")
	self._txttotalprogress = gohelper.findChildText(self.viewGO, "#txt_totalprogress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnweek:AddClickListener(self._btnweekOnClick, self)
	self._btndream:AddClickListener(self._btndreamOnClick, self)
	self._btnchallenge:AddClickListener(self._btnchallengeOnClick, self)
	self._btnfinishall:AddClickListener(self._btnfinishallOnClick, self)
end

function WeekWalkRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnweek:RemoveClickListener()
	self._btndream:RemoveClickListener()
	self._btnchallenge:RemoveClickListener()
	self._btnfinishall:RemoveClickListener()
end

function WeekWalkRewardView:_btnchallengeOnClick()
	self._btnIndex = WeekWalkEnum.TaskType.Challenge

	self:_updateBtns()
end

function WeekWalkRewardView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalkRewardView:_btnweekOnClick()
	self._btnIndex = WeekWalkEnum.TaskType.Week

	self:_updateBtns()
end

function WeekWalkRewardView:_btndreamOnClick()
	self._btnIndex = WeekWalkEnum.TaskType.Dream

	self:_updateBtns()
end

function WeekWalkRewardView:_updateBtns()
	local showWeek = self._btnIndex == WeekWalkEnum.TaskType.Week

	gohelper.setActive(self._goweekchoose, showWeek)
	gohelper.setActive(self._goweekunchoose, not showWeek)
	gohelper.setActive(self._goweekreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week))

	local showDream = self._btnIndex == WeekWalkEnum.TaskType.Dream

	gohelper.setActive(self._godreamchoose, showDream)
	gohelper.setActive(self._godreamunchoose, not showDream)
	gohelper.setActive(self._godreamreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Dream))

	local showChallenge = self._btnIndex == WeekWalkEnum.TaskType.Challenge

	gohelper.setActive(self._gochallengechoose, showChallenge)
	gohelper.setActive(self._gochallengeunchoose, not showChallenge)
	gohelper.setActive(self._gochallengereddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Challenge))
	gohelper.setActive(self._gocountdown, not showDream)
	gohelper.setActive(self._gotiptxt, showWeek)

	if not showDream then
		self:_showDeadline()
	else
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	self._scrollreward.verticalNormalizedPosition = 1

	WeekWalkTaskListModel.instance:showTaskList(self._btnIndex, self._mapId)

	self._mapId = nil

	gohelper.setActive(self._gofinishall.gameObject, WeekWalkTaskListModel.instance:hasFinished())

	local list = WeekWalkTaskListModel.instance:getList()
	local progress = 0
	local maxProgress = 0

	for i, v in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(v.id)

		if taskMo then
			progress = math.max(taskMo.progress or 0, progress)
		end

		local config = lua_task_weekwalk.configDict[v.id]

		if config then
			maxProgress = math.max(config.maxProgress or 0, maxProgress)
		end
	end

	self._txttotalprogress.text = string.format("%s/%s", progress, maxProgress)
end

function WeekWalkRewardView:_btnfinishallOnClick()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk)
end

function WeekWalkRewardView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function WeekWalkRewardView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._endTime = WeekWalkController.getTaskEndTime(self._btnIndex)

	if not self._endTime then
		return
	end

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()

	self._txtcountdowntitle.text = luaLang(self._btnIndex == WeekWalkEnum.TaskType.Challenge and "p_dungeonweekwalkview_device" or "p_dungeonweekwalkview_task")
end

function WeekWalkRewardView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txtcountday.text = time .. format
end

function WeekWalkRewardView:onUpdateParam()
	return
end

function WeekWalkRewardView:onOpen()
	self._btnIndex = WeekWalkEnum.TaskType.Week
	self._mapId = self.viewParam and self.viewParam.mapId

	if self._mapId then
		self._btnIndex = WeekWalkRewardView.getTaskType(self._mapId)
	end

	self:_updateBtns()
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, self._getTaskBouns, self)
end

function WeekWalkRewardView:_onGetInfo()
	self:_updateBtns()
end

function WeekWalkRewardView.getTaskType(mapId)
	return (WeekWalkModel.isShallowMap(mapId) or nil) and (WeekWalkEnum.TaskType.Dream or WeekWalkEnum.TaskType.Challenge)
end

function WeekWalkRewardView:_onWeekwalkTaskUpdate()
	if not self._bounsItemList or #self._bounsItemList == 0 then
		return
	end

	self:_bonusReply()
end

function WeekWalkRewardView:_getTaskBouns(taskItem)
	self._bounsItemList = self:getUserDataTb_()

	local transform = self._gorewardcontent.transform
	local itemCount = transform.childCount
	local getAllItem

	for i = 1, itemCount do
		local index = i - 1
		local child = transform:GetChild(index)
		local prefabInstGO = gohelper.findChild(child.gameObject, "prefabInst")
		local item = MonoHelper.getLuaComFromGo(prefabInstGO, WeekWalkRewardItem)

		if item._canGet then
			table.insert(self._bounsItemList, item)
		end

		if item._mo.id == 0 then
			getAllItem = item
		end
	end

	if taskItem ~= getAllItem then
		local len = #self._bounsItemList

		self._bounsItemList = self:getUserDataTb_()

		if getAllItem and len <= 3 then
			table.insert(self._bounsItemList, getAllItem)
		end

		table.insert(self._bounsItemList, taskItem)
	end
end

function WeekWalkRewardView:_bonusReply()
	UIBlockMgr.instance:startBlock("WeekWalkRewardView bonus")
	self:_playTaskFinish()
end

function WeekWalkRewardView:_playTaskFinish()
	local list = self._bounsItemList

	self._indexList = {}

	for i, v in ipairs(list) do
		v:playOutAnim()

		local siblingIndex = v.viewGO.transform.parent:GetSiblingIndex()

		table.insert(self._indexList, siblingIndex)
	end

	self._bounsItemList = nil

	TaskDispatcher.runDelay(self._onTaskFinishDone, self, 0.267)
end

function WeekWalkRewardView:_onTaskFinishDone()
	self:_updateBtns()

	local transform = self._gorewardcontent.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local index = i - 1
		local num = self:_skipNum(index)

		if num > 0 then
			local child = transform:GetChild(index)
			local x, y = transformhelper.getLocalPos(child.transform)

			transformhelper.setLocalPosXY(child, x, y - 166 * num)

			local tweenId = ZProj.TweenHelper.DOLocalMoveY(child, y, 0.3, nil, nil, nil, EaseType.Linear)
		end
	end

	TaskDispatcher.runDelay(self._showRewards, self, 0.3)
end

function WeekWalkRewardView:_skipNum(index)
	local num = 0

	for i, v in ipairs(self._indexList) do
		if v <= index then
			num = num + 1
		else
			break
		end
	end

	return num
end

function WeekWalkRewardView:_showRewards()
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")

	local list = WeekWalkTaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
end

function WeekWalkRewardView:onClose()
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._showRewards, self)
	TaskDispatcher.cancelTask(self._onTaskFinishDone, self)
end

function WeekWalkRewardView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return WeekWalkRewardView
