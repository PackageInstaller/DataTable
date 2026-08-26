-- chunkname: @modules/logic/activity/view/V2a6_WeekwalkHeart_FullView.lua

module("modules.logic.activity.view.V2a6_WeekwalkHeart_FullView", package.seeall)

local V2a6_WeekwalkHeart_FullView = class("V2a6_WeekwalkHeart_FullView", Activity189BaseView)

V2a6_WeekwalkHeart_FullView.SignInState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
V2a6_WeekwalkHeart_FullView.ReadTaskId = 530008

function V2a6_WeekwalkHeart_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Top/#txt_LimitTime")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_goto")
	self._rewardItemList = {}
	self._tipItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_WeekwalkHeart_FullView:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishReadTask, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onGetReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._refresh, self)
end

function V2a6_WeekwalkHeart_FullView:removeEvents()
	self._btngoto:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, self._onFinishReadTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._onGetReward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._refresh, self)
end

function V2a6_WeekwalkHeart_FullView:_btngotoOnClick()
	GameFacade.jump(JumpEnum.JumpView.WeekWalk)
	self:_trySendReadTask()
end

function V2a6_WeekwalkHeart_FullView:_onFinishReadTask()
	self:_updateRewardState()
end

function V2a6_WeekwalkHeart_FullView:_onGetReward(taskId)
	self._taskId = taskId
end

function V2a6_WeekwalkHeart_FullView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_updateRewardState()
	end
end

function V2a6_WeekwalkHeart_FullView:_editableInitView()
	self:_initReward()
	self:_initTipList()
end

function V2a6_WeekwalkHeart_FullView:_initReward()
	local configList = Activity189Config.instance:getAllTaskList(self:actId())

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.co = configList[i]
		item.go = gohelper.findChild(self.viewGO, "Root/Right/rightbg/taskitem" .. i)
		item.txttask = gohelper.findChildText(item.go, "#txt_task")
		item.goreward = gohelper.findChild(item.go, "#go_rewarditem")
		item.gorewardicon = gohelper.findChild(item.goreward, "go_icon")
		item.gocanget = gohelper.findChild(item.goreward, "go_canget")
		item.goreceive = gohelper.findChild(item.goreward, "go_receive")
		item.gohasget = gohelper.findChild(item.goreward, "go_receive/go_hasget")
		item.btnclick = gohelper.findChildButton(item.goreward, "btnclick")
		item.animget = item.gohasget:GetComponent(typeof(UnityEngine.Animator))

		if item.co then
			local rewardco = string.splitToNumber(item.co.bonus, "#")
			local type, id, num = rewardco[1], rewardco[2], rewardco[3]

			item.txttask.text = item.co.desc
			item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.gorewardicon)

			item.itemIcon:setMOValue(type, id, num, nil, true)

			if i ~= 2 then
				item.itemIcon:setItemIconScale(0.8)
			end

			item.itemIcon:setCountFontSize(36)

			local function func()
				TaskRpc.instance:sendFinishTaskRequest(item.co.id)
			end

			item.btnclick:AddClickListener(func, self, item)
		end

		table.insert(self._rewardItemList, item)
	end
end

function V2a6_WeekwalkHeart_FullView:_initTipList()
	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "Root/Left/tips" .. i .. "/root")

		self:_initTipItem(item)
	end

	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.viewGO, "Root/Right/rightbg/title")

	self:_initTipItem(item)
end

function V2a6_WeekwalkHeart_FullView:_initTipItem(item)
	item.isLike = false
	item.isUnLike = false
	item.golike = gohelper.findChild(item.go, "like")
	item.txtlike = gohelper.findChildText(item.golike, "num")
	item.likenum = math.random(50, 99)
	item.txtlike.text = item.likenum
	item.govxlike = gohelper.findChild(item.golike, "vx_like")
	item.golikeSelect = gohelper.findChild(item.golike, "go_selected")
	item.btnlikeclick = gohelper.findChildButton(item.golike, "#btn_click")

	local function likefunc()
		if not item.isUnLike then
			item.likenum = item.isLike and item.likenum - 1 or item.likenum + 1
			item.isLike = not item.isLike
		end

		gohelper.setActive(item.govxlike, item.isLike)
		gohelper.setActive(item.golikeSelect, item.isLike)

		item.txtlike.text = item.likenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	item.btnlikeclick:AddClickListener(likefunc, self, item)

	item.gounlike = gohelper.findChild(item.go, "unlike")
	item.txtunlike = gohelper.findChildText(item.gounlike, "num")
	item.unlikenum = math.random(50, 99)
	item.txtunlike.text = item.unlikenum
	item.govxunlike = gohelper.findChild(item.gounlike, "vx_unlike")
	item.gounlikeSelect = gohelper.findChild(item.gounlike, "go_selected")
	item.btnunlikeclick = gohelper.findChildButton(item.gounlike, "#btn_click")

	local function unlikefunc()
		if not item.isLike then
			item.unlikenum = item.isUnLike and item.unlikenum - 1 or item.unlikenum + 1
			item.isUnLike = not item.isUnLike
		end

		gohelper.setActive(item.govxunlike, item.isUnLike)
		gohelper.setActive(item.gounlikeSelect, item.isUnLike)

		item.txtunlike.text = item.unlikenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	item.btnunlikeclick:AddClickListener(unlikefunc, self, item)
	gohelper.setActive(item.govxlike, item.isLike)
	gohelper.setActive(item.golikeSelect, item.isLike)
	gohelper.setActive(item.govxunlike, item.isUnLike)
	gohelper.setActive(item.gounlikeSelect, item.isUnLike)
	table.insert(self._tipItemList, item)
end

function V2a6_WeekwalkHeart_FullView:_refresh()
	self:_updateRewardState()
end

function V2a6_WeekwalkHeart_FullView:_updateRewardState()
	local moList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, self:actId())

	for _, mo in ipairs(moList) do
		for _, item in ipairs(self._rewardItemList) do
			if item.co.id == mo.id then
				item.mo = mo

				if mo.finishCount > 0 then
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.goreceive, true)

					if self._taskId == mo.id then
						item.animget:Play("go_hasget_in")

						self._taskId = nil
					end

					gohelper.setActive(item.btnclick.gameObject, false)
				elseif mo.hasFinished then
					gohelper.setActive(item.gocanget, true)
					gohelper.setActive(item.goreceive, false)
					gohelper.setActive(item.btnclick.gameObject, true)
				else
					gohelper.setActive(item.goreceive, false)
					gohelper.setActive(item.gocanget, false)
					gohelper.setActive(item.btnclick.gameObject, false)
				end
			end
		end
	end
end

function V2a6_WeekwalkHeart_FullView:onUpdateParam()
	return
end

function V2a6_WeekwalkHeart_FullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._txtLimitTime.text = self:getRemainTimeStr()

	AudioMgr.instance:trigger(AudioEnum.AudioEnum2_6.WeekwalkHeart.play_ui_wenming_popup)
	Activity189Controller.instance:sendGetTaskInfoRequest(self._refresh, self)
end

function V2a6_WeekwalkHeart_FullView:_trySendReadTask()
	local moList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, self:actId())

	for index, mo in ipairs(moList) do
		if mo.id == V2a6_WeekwalkHeart_FullView.ReadTaskId and not mo.hasFinished and mo.finishCount <= 0 then
			TaskRpc.instance:sendFinishReadTaskRequest(V2a6_WeekwalkHeart_FullView.ReadTaskId)
		end
	end
end

function V2a6_WeekwalkHeart_FullView:onClose()
	for index, item in ipairs(self._rewardItemList) do
		item.btnclick:RemoveClickListener()
	end

	for index, item in ipairs(self._tipItemList) do
		item.btnlikeclick:RemoveClickListener()
		item.btnunlikeclick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._cb, self)
end

function V2a6_WeekwalkHeart_FullView:onDestroyView()
	return
end

return V2a6_WeekwalkHeart_FullView
