-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipView", package.seeall)

local ActFlipView = class("ActFlipView", BaseView)

function ActFlipView:onInitView()
	self._gocardbg1 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg1")
	self._gobg1 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg1/#go_bg1")
	self._gogridbg1 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg1/#go_gridbg1")
	self._gocardbg2 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg2")
	self._gobg2 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg2/#go_bg2")
	self._gogridbg2 = gohelper.findChild(self.viewGO, "root/left/#go_cardbg2/#go_gridbg2")
	self._gocardcontent = gohelper.findChild(self.viewGO, "root/left/#go_cardcontent")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/left/#go_cardcontent/#go_carditem")
	self._goleft = gohelper.findChild(self.viewGO, "root/left")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_right")
	self._golock = gohelper.findChild(self.viewGO, "root/left/#go_lock")
	self._gorewards = gohelper.findChild(self.viewGO, "root/left/#go_rewards")
	self._goreward1 = gohelper.findChild(self.viewGO, "root/left/#go_rewards/#go_reward1")
	self._btnreward1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#go_rewards/#go_reward1/btn_click")
	self._goreward2 = gohelper.findChild(self.viewGO, "root/left/#go_rewards/#go_reward2")
	self._btnreward2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#go_rewards/#go_reward2/btn_click")
	self._txtreward = gohelper.findChildText(self.viewGO, "root/left/#go_rewards/txtbg/#txt_reward")
	self._btnrewardtip = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#go_rewards/#btn_rewardtip")
	self._goprops = gohelper.findChild(self.viewGO, "root/left/#go_props")
	self._gopropbg1 = gohelper.findChild(self.viewGO, "root/left/#go_props/#go_propbg1")
	self._gopropbg2 = gohelper.findChild(self.viewGO, "root/left/#go_props/#go_propbg2")
	self._txtrewardnum = gohelper.findChildText(self.viewGO, "root/left/#go_props/Layout/#txt_rewardnum")
	self._gotime = gohelper.findChild(self.viewGO, "root/right/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/#go_time/#txt_time")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_task")
	self._gotaskitem = gohelper.findChild(self.viewGO, "root/right/#scroll_task/Viewport/Content/#go_taskitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActFlipView:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnreward1:AddClickListener(self._btnleftOnClick, self)
	self._btnreward2:AddClickListener(self._btnrightOnClick, self)
	self._btnrewardtip:AddClickListener(self._btnrewardtipOnClick, self)
end

function ActFlipView:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnreward1:RemoveClickListener()
	self._btnreward2:RemoveClickListener()
	self._btnrewardtip:RemoveClickListener()
end

function ActFlipView:_btnleftOnClick()
	local curCardIndex = ActFlipModel.instance:getCurCardIndex()

	if curCardIndex <= 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum4_0.ConcertLimit.play_ui_activity_reward_ending)
	self._changeAnim:Play("switch_right", 0, 0)
	ActFlipModel.instance:setCurCardIndex(curCardIndex - 1)
	self:_refreshInfo()
	self:_refreshCards()
end

function ActFlipView:_btnrightOnClick()
	local curCardIndex = ActFlipModel.instance:getCurCardIndex()
	local maxPage = ActFlipModel.instance:getTotalCardCount()

	if maxPage <= curCardIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum4_0.ConcertLimit.play_ui_activity_reward_ending)
	self._changeAnim:Play("switch_left", 0, 0)
	ActFlipModel.instance:setCurCardIndex(curCardIndex + 1)
	self:_refreshInfo()
	self:_refreshCards()
end

function ActFlipView:_btnrewardtipOnClick()
	ActFlipController.instance:openActFlipRewardTipsView()
end

function ActFlipView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip

	self:_initView()
	self:_addSelfEvents()
end

function ActFlipView:_initView()
	self._cardItems = self:getUserDataTb_()
	self._taskItems = self:getUserDataTb_()
	self._changeAnim = self._goleft:GetComponent(typeof(UnityEngine.Animator))
	self._propAnim = self._goprops:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gocarditem, false)
	gohelper.setActive(self._gotaskitem, false)
end

function ActFlipView:_addSelfEvents()
	self.addEventCb(self, ActFlipController.instance, ActFlipEvent.RewardInfoChanged, self._refresh, self)
	self.addEventCb(self, ActFlipController.instance, ActFlipEvent.RewardBonusGetShowFinished, self._onBonusGetDone, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskFinishDone, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskFinishDone, self)
	self.addEventCb(self, ActFlipController.instance, ActFlipEvent.ShowAutoChangeCard, self._onShowAutoChangeCard, self)
end

function ActFlipView:_removeSelfEvents()
	self.removeEventCb(self, ActFlipController.instance, ActFlipEvent.RewardInfoChanged, self._refresh, self)
	self.removeEventCb(self, ActFlipController.instance, ActFlipEvent.RewardBonusGetShowFinished, self._onBonusGetDone, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskFinishDone, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskFinishDone, self)
	self.removeEventCb(self, ActFlipController.instance, ActFlipEvent.ShowAutoChangeCard, self._onShowAutoChangeCard, self)
end

function ActFlipView:onOpen()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)

	local curCardIndex = ActFlipModel.instance:getCurCardIndex()
	local isAllRewardGet = ActFlipModel.instance:isCardRewardAllGet(curCardIndex)
	local isNextRewardGet = ActFlipModel.instance:isCardRewardAllGet(3 - curCardIndex)
	local isNextCardUnlock = ActFlipModel.instance:isCardUnlock(2)

	if not isNextCardUnlock then
		curCardIndex = 1
	elseif isAllRewardGet and not isNextRewardGet then
		curCardIndex = 3 - curCardIndex
	end

	ActFlipModel.instance:setCurCardIndex(curCardIndex)

	if curCardIndex > 1 then
		self._changeAnim:Play("switch_left", 0, 1)
	end

	self:_refresh()
end

function ActFlipView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function ActFlipView:_refresh()
	self:_refreshInfo()
	self:_refreshCards()
	self:_refreshTasks()
end

function ActFlipView:_onShowAutoChangeCard()
	self:_btnrightOnClick()
end

function ActFlipView:_onBonusGetDone()
	self:_refreshInfo()
	self:_refreshCards()
end

function ActFlipView:_onTaskFinishDone()
	self:_refresh()
end

function ActFlipView:_refreshInfo()
	local curCardIndex = ActFlipModel.instance:getCurCardIndex()
	local couldGetCount = ActFlipModel.instance:couldGetCardCount(curCardIndex)

	if self._couldGetCount and couldGetCount > self._couldGetCount then
		self._propAnim:Play("add", 0, 0)
	end

	self._couldGetCount = couldGetCount
	self._txtrewardnum.text = luaLang("multiple") .. couldGetCount

	gohelper.setActive(self._gocardbg1, curCardIndex == 1)
	gohelper.setActive(self._gocardbg2, curCardIndex == 2)
	gohelper.setActive(self._btnleft.gameObject, curCardIndex > 1)

	local totalCount = ActFlipModel.instance:getTotalCardCount()

	gohelper.setActive(self._btnright.gameObject, curCardIndex < totalCount)

	local isCardUnlock = ActFlipModel.instance:isCardUnlock(curCardIndex)

	gohelper.setActive(self._golock, not isCardUnlock)
end

function ActFlipView:_refreshCards()
	local curCardIndex = ActFlipModel.instance:getCurCardIndex()

	if not self._curCardIndex or self._curCardIndex ~= curCardIndex then
		if self._cardItems then
			for _, cardItem in pairs(self._cardItems) do
				cardItem:showItem(false)
			end
		end

		self._curCardIndex = curCardIndex
	end

	local cardCo = ActFlipConfig.instance:getCardCo(curCardIndex)

	if not cardCo then
		return
	end

	for rowIndex = 1, cardCo.row do
		for colIndex = 1, cardCo.column do
			local index = (rowIndex - 1) * cardCo.column + colIndex - 1

			if not self._cardItems[index] then
				self._cardItems[index] = ActFlipCardItem.New()

				local go = gohelper.cloneInPlace(self._gocarditem, index)

				self._cardItems[index]:init(go)
			end

			self._cardItems[index]:refresh(index, curCardIndex)
		end
	end
end

function ActFlipView:_refreshTasks()
	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:showItem(false)
		end
	end

	local taskMos = ActFlipModel.instance:getTaskList()

	for index, taskMo in ipairs(taskMos) do
		if not self._taskItems[taskMo.id] then
			self._taskItems[taskMo.id] = ActFlipTaskItem.New()

			local go = gohelper.cloneInPlace(self._gotaskitem)

			self._taskItems[taskMo.id]:init(go)
		end

		self._taskItems[taskMo.id]:refresh(taskMo)
		gohelper.setSibling(self._taskItems[taskMo.id].go, index)
	end
end

function ActFlipView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function ActFlipView:onDestroyView()
	self:_removeSelfEvents()

	if self._cardItems then
		for _, cardItem in pairs(self._cardItems) do
			cardItem:destroy()
		end

		self._cardItems = nil
	end

	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end
end

return ActFlipView
